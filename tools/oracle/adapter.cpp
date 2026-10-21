// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
// Adapter only: all clipping is performed by the locked C++ Clipper2 engine.
#include "clipper2/clipper.engine.h"
#include "clipper2/clipper.offset.h"
#include "clipper2/clipper.h"
#include <cmath>
#include <map>
#include "json.hpp"
#include <iostream>
#include <iterator>
#include <set>
#include <stdexcept>
#include <string>
#include <vector>

using nlohmann::json;
using namespace Clipper2Lib;
constexpr const char* kCommit = "21ebba05db8894f0c7217ad35ea518080f324946";
constexpr size_t kMaxVertices = 100000;
constexpr size_t kMaxPaths = 10000;

void require(bool condition, const std::string& message) {
  if (!condition) throw std::runtime_error(message);
}
void keys(const json& value, std::initializer_list<const char*> fields, const std::string& where) {
  require(value.is_object() && value.size() == fields.size(), where + ": unexpected fields or type");
  for (auto field : fields) require(value.contains(field), where + ": missing " + field);
}
int64_t integer(const json& value, const std::string& where, int64_t low, int64_t high) {
  require(value.is_number_integer(), where + ": expected integer token");
  if (value.is_number_unsigned()) require(value.get<uint64_t>() <= static_cast<uint64_t>(high), where + ": integer out of range");
  auto number = value.get<int64_t>();
  require(number >= low && number <= high, where + ": integer out of range");
  return number;
}
Paths64 paths(const json& value, const std::string& where, size_t& path_count, size_t& vertices) {
  require(value.is_array(), where + ": expected paths array");
  require(value.size() <= kMaxPaths - path_count, where + ": path limit exceeded");
  path_count += value.size();
  Paths64 result;
  for (size_t i = 0; i < value.size(); ++i) {
    const auto& source = value[i];
    auto label = where + "[" + std::to_string(i) + "]";
    require(source.is_array(), label + ": expected path array");
    require(source.size() <= kMaxVertices - vertices, label + ": vertex limit exceeded");
    vertices += source.size();
    Path64 path;
    for (size_t j = 0; j < source.size(); ++j) {
      auto point_label = label + "[" + std::to_string(j) + "]";
      const auto& point = source[j];
      require(point.is_array() && point.size() == 2, point_label + ": expected coordinate pair");
      path.emplace_back(integer(point[0], point_label + ".x", -1000000000, 1000000000),
                        integer(point[1], point_label + ".y", -1000000000, 1000000000));
    }
    result.push_back(std::move(path));
  }
  return result;
}
json output_path(const Path64& path) {
  json result = json::array();
  for (const auto& point : path) result.push_back(json::array({point.x, point.y}));
  return result;
}
json children(const PolyPath64& parent, unsigned depth, size_t& nodes) {
  require(depth <= 64 || parent.Count() == 0, "tree: depth limit exceeded");
  json result = json::array();
  for (size_t i = 0; i < parent.Count(); ++i) {
    require(++nodes <= kMaxPaths, "tree: node limit exceeded");
    auto child = parent.Child(i);
    result.push_back({{"path", output_path(child->Polygon())}, {"children", children(*child, depth + 1, nodes)}});
  }
  return result;
}
void configure(Clipper64& engine, const Paths64& subject, const Paths64& clip, const json& options) {
  engine.PreserveCollinear(options["preserve_collinear"].get<bool>());
  engine.ReverseSolution(options["reverse_solution"].get<bool>());
  engine.AddSubject(subject);
  engine.AddClip(clip);
}
std::string request_metadata(const json& request) {
  require(request["case_id"].is_string(), "case_id: expected string");
  auto id = request["case_id"].get<std::string>();
  require(!id.empty() && std::string("abcdefghijklmnopqrstuvwxyz0123456789").find(id[0]) != std::string::npos && id.size() <= 101 && id.find_first_not_of("abcdefghijklmnopqrstuvwxyz0123456789_-") == std::string::npos, "case_id: invalid ID");
  const auto& source = request["source"];
  require(source.is_object() && source.contains("kind") && source["kind"].is_string(), "source: missing kind");
  auto kind = source["kind"].get<std::string>();
  if (kind == "moonclip_constructed") keys(source, {"kind", "intent", "group"}, "source");
  else if (kind == "upstream") keys(source, {"kind", "file", "case_id", "sha256"}, "source");
  else if (kind == "regression") keys(source, {"kind", "discovery", "issue"}, "source");
  else throw std::runtime_error("source: unknown kind");
  for (const auto& field : source.items())
    require(field.value().is_string() && !field.value().get<std::string>().empty(), "source: expected nonempty strings");
  if (kind == "upstream") {
    auto hash = source["sha256"].get<std::string>();
    require(hash.size() == 64 && hash.find_first_not_of("0123456789abcdef") == std::string::npos, "source: invalid file hash");
  }
  keys(request["options"], {"preserve_collinear", "reverse_solution"}, "options");
  for (const auto& option : request["options"].items())
    require(option.value().is_boolean() && !option.value().get<bool>(), "options: protocol 1 requires explicit false booleans");
  return id;
}
json execute(const json& request);
double finite_number(const json& value, const std::string& where) {
  require(value.is_number(), where + ": expected finite numeric token");
  double number = value.get<double>();
  require(std::isfinite(number), where + ": expected finite number");
  return number;
}
json execute_stroke(const json& request) {
  keys(request, {"format_version","operation","case_id","source","options","path","width","join_type","cap_type","miter_limit","arc_tolerance"}, "stroke request");
  integer(request["format_version"],"stroke format_version",3,3);
  const auto id=request_metadata(request);
  const double width=finite_number(request["width"],"width");
  const double miter=finite_number(request["miter_limit"],"miter_limit");
  const double tolerance=finite_number(request["arc_tolerance"],"arc_tolerance");
  require(width>=1.0,"reference stroke width must be at least 1");
  require(miter>=2.0 && tolerance>=0.0,"invalid stroke options");
  require(request["join_type"].is_string() && request["cap_type"].is_string(),"stroke style: expected strings");
  const auto join=request["join_type"].get<std::string>(), cap=request["cap_type"].get<std::string>();
  require(join=="Miter" || join=="Bevel" || join=="Square" || join=="Round","unknown stroke join");
  require(cap=="Butt" || cap=="Square" || cap=="Round","unknown stroke cap");
  size_t count=0,vertices=0;
  auto source=paths(json::array({request["path"]}),"stroke path",count,vertices);
  StripDuplicates(source[0],false);
  require(source[0].size()>=2,"reference stroke needs an effective open segment");
  const double radius=width/2.0;
  require(radius<=2000000000.0,"stroke radius: unsafe distance");
  require(join!="Miter" || source[0].size()==2 || std::isfinite(miter*miter),"stroke miter: numeric overflow");
  if (join=="Round" || cap=="Round") {
    const double pi=std::acos(-1.0);
    const double effective=tolerance>1e-12 ? std::min(radius,tolerance) : radius*0.002;
    const double argument=1.0-effective/radius;
    const double circle=argument==1.0 ? radius*pi : std::min(pi/std::acos(argument),radius*pi);
    const double arc_points=std::ceil(circle/2.0)+1.0;
    // Two sides per internal vertex plus both caps, before upstream int casts/loops.
    const double corner_points=join=="Round" ? std::max(3.0,arc_points) : 3.0;
    const double cap_points=cap=="Round" ? arc_points : 2.0;
    const double samples=2.0*static_cast<double>(source[0].size()-2)*corner_points+2.0*cap_points;
    require(std::isfinite(samples) && samples<=static_cast<double>(kMaxVertices),"stroke sampling exceeds adapter resource limit");
  } else require(source[0].size()<=kMaxVertices/6,"stroke generation exceeds adapter resource limit");
  const JoinType jt=join=="Miter" ? JoinType::Miter : join=="Bevel" ? JoinType::Bevel : join=="Square" ? JoinType::Square : JoinType::Round;
  const EndType et=cap=="Butt" ? EndType::Butt : cap=="Square" ? EndType::Square : EndType::Round;
  // The original open route is passed directly; no preliminary closed Union.
  ClipperOffset offset(miter,tolerance,false,false);
  offset.AddPath(source[0],jt,et);
  Paths64 result;offset.Execute(radius,result);
  require(offset.ErrorCode()==0,"Clipper2 stroke execution failed");
  json output=json::array();
  for (const auto& path:result) {
    for (const auto& p:path) require(p.x>=-1000000000 && p.x<=1000000000 && p.y>=-1000000000 && p.y<=1000000000,"stroke generated coordinate out of range");
    output.push_back(output_path(path));
  }
  return {{"format_version",3},{"adapter_protocol_version",3},{"case_id",id},{"oracle_commit",kCommit},{"status","success"},{"paths",output}};
}
json execute_offset(const json& request) {
  json base_request=request;
  base_request.erase("arc_tolerance");
  keys(base_request, {"format_version", "case_id", "source", "operation", "fill_rule", "options", "paths", "delta", "join_type", "miter_limit"}, "offset request");
  double arc_tolerance=request.contains("arc_tolerance") ? finite_number(request["arc_tolerance"], "arc_tolerance") : 0.0;
  require(arc_tolerance >= 0.0, "arc_tolerance: must be non-negative");
  integer(request["format_version"], "offset format_version", 2, 2);
  double delta = finite_number(request["delta"], "delta");
  double miter = finite_number(request["miter_limit"], "miter_limit");
  require(miter >= 2, "miter_limit: must be at least 2");
  require(request["join_type"].is_string(), "join_type: expected string");
  auto join = request["join_type"].get<std::string>();
  require(join == "Miter" || join == "Bevel" || join == "Square" || join == "Round", "join_type: unsupported join");
  require(request["fill_rule"] == "EvenOdd" || request["fill_rule"] == "NonZero", "fill_rule: unsupported offset rule");
  // Reuse strict v1 provenance/options validation and independent fixed-engine Union.
  json normalize = {{"format_version", 1}, {"case_id", request["case_id"]},
    {"source", request["source"]}, {"operation", "Union"}, {"fill_rule", request["fill_rule"]},
    {"options", request["options"]}, {"subject", request["paths"]}, {"clip", json::array()}};
  auto region = execute(normalize);
  size_t count = 0, vertices = 0;
  auto normalized = paths(region["paths"], "normalized", count, vertices);
  Paths64 result;
  if (!normalized.empty()) {
    require(std::abs(delta) <= 2000000000.0, "delta: unsafe offset distance");
    require(join != "Miter" || std::abs(delta) < 0.5 || std::isfinite(miter * miter), "miter_limit: numeric overflow");
    if (join == "Round" && std::abs(delta) >= 0.5) {
      // Adapter-only bounded execution guard, before upstream's int cast/loop.
      // This is a conservative sample ceiling, not an alternative offset result.
      const double radius=std::abs(delta), pi=std::acos(-1.0);
      const double tolerance=arc_tolerance > 1e-12 ? std::min(radius,arc_tolerance) : radius*0.002;
      const double argument=1.0-tolerance/radius;
      const double circle=argument == 1.0 ? radius*pi : std::min(pi/std::acos(argument),radius*pi);
      const double per_corner=std::ceil(circle/2.0)+1.0;
      require(std::isfinite(per_corner) && per_corner <= static_cast<double>(kMaxVertices) &&
              static_cast<double>(vertices)*per_corner <= static_cast<double>(kMaxVertices),
              "Round sampling exceeds adapter resource limit");
    }
    ClipperOffset offset(miter, arc_tolerance, false, false);
    JoinType join_type = join == "Miter" ? JoinType::Miter : join == "Bevel" ? JoinType::Bevel : join == "Square" ? JoinType::Square : JoinType::Round;
    offset.AddPaths(normalized, join_type, EndType::Polygon);
    offset.Execute(delta, result);
    require(offset.ErrorCode() == 0, "Clipper2 offset execution failed");
  }
  json output = json::array();
  for (const auto& path : result) {
    for (const auto& p : path)
      require(p.x >= -1000000000 && p.x <= 1000000000 && p.y >= -1000000000 && p.y <= 1000000000, "generated coordinate outside supported range");
    output.push_back(output_path(path));
  }
  return {{"format_version", 2}, {"adapter_protocol_version", 2}, {"case_id", request["case_id"]},
          {"oracle_commit", kCommit}, {"status", "success"}, {"paths", output}};
}
struct CompositionFailure : std::runtime_error {
  int step;
  CompositionFailure(int index, const std::string& message) : std::runtime_error(message), step(index) {}
};
json execute_composition(const json& request);
json execute_decimal(const json& request);
json execute_simplify(const json& request);
json execute_minkowski(const json& request);
json execute_rectclip(const json& request);
json execute(const json& request) {
  if(request.is_object() && request.value("operation",json())=="RectClipLines") return execute_rectclip(request);
  if(request.is_object() && request.value("operation",json())=="MinkowskiSum") return execute_minkowski(request);
  if (request.is_object() && (request.value("operation",json())=="Simplify64" || request.value("operation",json())=="SimplifyD")) return execute_simplify(request);
  if (request.is_object() && (request.value("operation",json())=="BooleanD" || request.value("operation",json())=="OffsetD" || request.value("operation",json())=="StrokeD")) return execute_decimal(request);
  if (request.is_object() && request.value("operation",json())=="Composition") return execute_composition(request);
  if (request.is_object() && request.value("operation",json())=="StrokePolyline") return execute_stroke(request);
  if (request.is_object() && request.value("operation", json()) == "OffsetPolygons") return execute_offset(request);
  keys(request, {"format_version", "case_id", "source", "operation", "fill_rule", "options", "subject", "clip"}, "request");
  require(integer(request["format_version"], "format_version", 1, 1) == 1, "unknown protocol");
  const auto id = request_metadata(request);
  require(request["operation"].is_string() && request["fill_rule"].is_string(), "operation/fill_rule: expected strings");
  ClipType operation;
  const auto op = request["operation"].get<std::string>();
  if (op == "Intersection") operation = ClipType::Intersection;
  else if (op == "Union") operation = ClipType::Union;
  else if (op == "Difference") operation = ClipType::Difference;
  else if (op == "Xor") operation = ClipType::Xor;
  else throw std::runtime_error("operation: unknown operation");
  FillRule rule;
  const auto fill = request["fill_rule"].get<std::string>();
  if (fill == "EvenOdd") rule = FillRule::EvenOdd;
  else if (fill == "NonZero") rule = FillRule::NonZero;
  else if (fill == "Positive") rule = FillRule::Positive;
  else if (fill == "Negative") rule = FillRule::Negative;
  else throw std::runtime_error("fill_rule: unknown fill rule");
  size_t path_count = 0, vertex_count = 0;
  const auto subject = paths(request["subject"], "subject", path_count, vertex_count);
  const auto clip = paths(request["clip"], "clip", path_count, vertex_count);
  // Separate engine instances and separate Execute calls; never infer a tree.
  Clipper64 flat_engine, tree_engine;
  configure(flat_engine, subject, clip, request["options"]);
  configure(tree_engine, subject, clip, request["options"]);
  Paths64 flat;
  PolyTree64 tree;
  require(flat_engine.Execute(operation, rule, flat) && flat_engine.ErrorCode() == 0, "Clipper2 flat execution failed");
  require(tree_engine.Execute(operation, rule, tree) && tree_engine.ErrorCode() == 0, "Clipper2 tree execution failed");
  json flat_json = json::array();
  for (const auto& path : flat) flat_json.push_back(output_path(path));
  size_t nodes = 0;
  return {{"format_version", 1}, {"case_id", id}, {"adapter_protocol_version", 1},
          {"oracle_commit", kCommit}, {"status", "success"}, {"paths", flat_json},
          {"tree", {{"children", children(tree, 1, nodes)}}}};
}
// The second request is built exclusively from the just-computed first result.
json execute_composition(const json& request) {
  keys(request,{"format_version","operation","recipe","case_id","source","options","steps"},"composition");
  integer(request["format_version"],"composition version",4,4);
  request_metadata(request);
  require(request["recipe"].is_string(),"recipe: expected string");
  const auto recipe=request["recipe"].get<std::string>();
  require(recipe=="BooleanThenOffset" || recipe=="InsetThenTree" || recipe=="StrokeThenIntersection","unknown composition recipe");
  require(request["steps"].is_array() && request["steps"].size()==2,"composition: expected two steps");
  json intermediate, final;
  for (int i=0;i<2;++i) {
    try {
      json step=request["steps"][i];
      if (i==0) {
        if (recipe=="BooleanThenOffset") keys(step,{"format_version","operation","subject","clip","fill_rule"},"first Boolean");
        else if (recipe=="InsetThenTree") {
          keys(step,{"format_version","operation","paths","delta","fill_rule","join_type","miter_limit","arc_tolerance"},"first inset");
          require(step["operation"]=="OffsetPolygons" && step["delta"].is_number() && step["delta"].get<double>()<0,"expected negative inset");
        } else {
          keys(step,{"format_version","operation","path","width","cap_type","join_type","miter_limit","arc_tolerance"},"first stroke");
          require(step["operation"]=="StrokePolyline","expected first stroke");
        }
      } else if (recipe=="BooleanThenOffset") {
        keys(step,{"format_version","operation","delta","fill_rule","join_type","miter_limit","arc_tolerance"},"second offset");
        require(step["operation"]=="OffsetPolygons","expected second offset");
        step["paths"]=intermediate["paths"];
      } else {
        keys(step,{"format_version","operation","clip","fill_rule"},"second Boolean");
        require(step["operation"]==(recipe=="InsetThenTree" ? "Union" : "Intersection"),"wrong second Boolean operation");
        if (recipe=="InsetThenTree") require(step["clip"]==json::array(),"tree Union clip must be empty");
        step["subject"]=intermediate["paths"];
      }
      if (step.contains("fill_rule")) require(step["fill_rule"]=="NonZero" || step["fill_rule"]=="EvenOdd","public fill rule required");
      for (auto field : {"case_id","source","options"}) step[field]=request[field];
      auto result=execute(step);
      size_t pc=0,vc=0;
      paths(result["paths"],"composition stage output",pc,vc);
      if (i==0) intermediate={{"paths",result["paths"]}};
      else {
        final={{"paths",result["paths"]}};
        if (recipe=="InsetThenTree") final["tree"]=result["tree"];
      }
    } catch (const std::exception& error) { throw CompositionFailure(i+1,error.what()); }
  }
  return {{"format_version",4},{"adapter_protocol_version",4},{"case_id",request["case_id"]},
    {"oracle_commit",kCommit},{"status","success"},{"recipe",recipe},{"intermediate",intermediate},{"final",final}};
}
// v5 deliberately uses a decimal grid, independently of ClipperD's binary scale.
json execute_decimal(const json& request) {
  require(request.is_object() && request["operation"].is_string(),"decimal operation");
  const auto operation=request["operation"].get<std::string>();
  if (operation=="BooleanD") keys(request,{"format_version","operation","case_id","source","options","precision","grid","reference_route","subject","clip","clip_type","fill_rule"},"decimal Boolean");
  else if (operation=="OffsetD") keys(request,{"format_version","operation","case_id","source","options","precision","grid","reference_route","paths","delta","fill_rule","join_type","miter_limit","arc_tolerance"},"decimal offset");
  else keys(request,{"format_version","operation","case_id","source","options","precision","grid","reference_route","path","width","join_type","cap_type","miter_limit","arc_tolerance"},"decimal stroke");
  integer(request["format_version"],"decimal version",5,5);
  const auto id=request_metadata(request);
  const int precision=static_cast<int>(integer(request["precision"],"precision",0,6));
  const double scales[]={1,10,100,1000,10000,100000,1000000};
  const double scale=scales[precision], bound=1000000000.0/scale;
  require(request["grid"]=="DecimalHalfAwayFromZero","unknown decimal grid");
  require(request["reference_route"].is_string(),"decimal route: expected string");
  const auto route=request["reference_route"].get<std::string>();
  require(route=="DecimalGrid" || (route=="ClipperDCommonGrid" && operation=="BooleanD"),"unknown decimal reference route");
  if (operation!="StrokeD") require(request["fill_rule"]=="EvenOdd" || request["fill_rule"]=="NonZero","unsupported decimal fill");
  double distance=0,miter=2,tolerance=0;
  if (operation!="BooleanD") {
    distance=finite_number(request[operation=="OffsetD"?"delta":"width"],"distance");
    require(operation!="StrokeD" || distance>=0,"negative decimal width");
    miter=finite_number(request["miter_limit"],"miter_limit");
    tolerance=finite_number(request["arc_tolerance"],"arc_tolerance");
    require(miter>=2 && tolerance>=0,"invalid decimal options");
    require(request["join_type"]=="Miter" || request["join_type"]=="Bevel" || request["join_type"]=="Square" || request["join_type"]=="Round","unknown decimal join");
    if (operation=="StrokeD") require(request["cap_type"]=="Butt" || request["cap_type"]=="Square" || request["cap_type"]=="Round","unknown decimal cap");
    distance*=scale;tolerance*=scale;
    require(std::isfinite(distance) && std::isfinite(tolerance),"decimal parameter scaling overflow");
  }
  size_t path_count=0,vertex_count=0;
  std::map<std::pair<int64_t,int64_t>,std::pair<double,double>> seen;
  auto quantize=[&](const json& input) {
    require(input.is_array() && input.size()<=kMaxPaths-path_count,"decimal input path limit");
    path_count+=input.size();
    Paths64 grids;PathsD originals;
    for (const auto& path : input) {
      require(path.is_array() && path.size()<=kMaxVertices-vertex_count,"decimal raw vertex limit");
      vertex_count+=path.size();Path64 grid;PathD original;
      for (const auto& point : path) {
        require(point.is_array() && point.size()==2,"decimal point: expected pair");
        double x=finite_number(point[0],"x"),y=finite_number(point[1],"y");
        require(x>=-bound && x<=bound && y>=-bound && y<=bound,"decimal original coordinate range");
        const double sx=x*scale,sy=y*scale;
        require(std::isfinite(sx) && std::isfinite(sy) && sx>=-1000000000.0 && sx<=1000000000.0 && sy>=-1000000000.0 && sy<=1000000000.0,"decimal scaled coordinate range");
        if (route=="ClipperDCommonGrid") {
          const double binary=std::ldexp(1.0,std::ilogb(scale)+1);
          require(sx==std::round(sx) && sy==std::round(sy) && x*binary==std::round(x*binary) && y*binary==std::round(y*binary),"decimal input not on both grids");
        }
        const auto key=std::make_pair(static_cast<int64_t>(std::round(sx)),static_cast<int64_t>(std::round(sy)));
        const auto raw=std::make_pair(x,y);
        auto existing=seen.find(key);
        require(existing==seen.end() || existing->second==raw,"distinct decimal positions merge");
        seen.emplace(key,raw);grid.emplace_back(key.first,key.second);original.emplace_back(x,y);
      }
      if (operation!="StrokeD" && !grid.empty()) {
        auto a=grid[0];size_t j=1;
        while (j<grid.size() && grid[j]==a) ++j;
        bool noncollinear=false;
        if (j<grid.size()) for (const auto& c : grid) {
          const auto& b=grid[j];
          if ((b.x-a.x)*(c.y-a.y)-(b.y-a.y)*(c.x-a.x)!=0) {noncollinear=true;break;}
        }
        require(noncollinear,"quantized closed input is degenerate");
      }
      grids.push_back(std::move(grid));originals.push_back(std::move(original));
    }
    return std::make_pair(grids,originals);
  };
  const json empty=json::array();
  auto left=quantize(operation=="BooleanD" ? request["subject"] : operation=="OffsetD" ? request["paths"] : json::array({request["path"]}));
  auto right=quantize(operation=="BooleanD" ? request["clip"] : empty);
  json grid_output=json::array(), decimal_output=json::array();
  if (route=="ClipperDCommonGrid") {
    const auto op=request["clip_type"];
    require(op=="Intersection" || op=="Union" || op=="Difference" || op=="Xor","unknown decimal Boolean operation");
    ClipType type=op=="Intersection"?ClipType::Intersection:op=="Union"?ClipType::Union:op=="Difference"?ClipType::Difference:ClipType::Xor;
    ClipperD engine(precision);
    engine.PreserveCollinear(false);engine.ReverseSolution(false);
    engine.AddSubject(left.second);engine.AddClip(right.second);
    PathsD output;
    require(engine.Execute(type,request["fill_rule"]=="EvenOdd"?FillRule::EvenOdd:FillRule::NonZero,output) && engine.ErrorCode()==0,"actual ClipperD execution failed");
    for (const auto& path : output) {
      json gp=json::array(),dp=json::array();
      for (const auto& p : path) {
        const double sx=p.x*scale,sy=p.y*scale;
        require(std::isfinite(sx) && std::isfinite(sy) && sx==std::round(sx) && sy==std::round(sy) && p.x==sx/scale && p.y==sy/scale,"raw ClipperD output is not on the target decimal grid");
        require(sx>=-1000000000.0 && sx<=1000000000.0 && sy>=-1000000000.0 && sy<=1000000000.0,"ClipperD output range");
        gp.push_back({static_cast<int64_t>(sx),static_cast<int64_t>(sy)});
        dp.push_back({p.x==0?0.0:p.x,p.y==0?0.0:p.y});
      }
      grid_output.push_back(gp);decimal_output.push_back(dp);
    }
  } else {
    json integer_request={{"case_id",id},{"source",request["source"]},{"options",request["options"]}};
    json l=json::array(),r=json::array();
    for (const auto& p : left.first) l.push_back(output_path(p));
    for (const auto& p : right.first) r.push_back(output_path(p));
    if (operation=="BooleanD") {
      integer_request.update({{"format_version",1},{"operation",request["clip_type"]},{"subject",l},{"clip",r},{"fill_rule",request["fill_rule"]}});
    } else {
      integer_request.update({{"format_version",operation=="OffsetD"?2:3},{"operation",operation=="OffsetD"?"OffsetPolygons":"StrokePolyline"},{"join_type",request["join_type"]},{"miter_limit",miter},{"arc_tolerance",tolerance}});
      if (operation=="OffsetD") integer_request.update({{"paths",l},{"delta",distance},{"fill_rule",request["fill_rule"]}});
      else integer_request.update({{"path",l[0]},{"width",distance},{"cap_type",request["cap_type"]}});
    }
    bool empty_stroke=false;
    if (operation=="StrokeD") {auto effective=left.first[0];StripDuplicates(effective,false);empty_stroke=distance<1.0 || effective.size()<2;}
    if (!empty_stroke) grid_output=execute(integer_request)["paths"];
    for (const auto& path : grid_output) {
      json dp=json::array();
      for (const auto& p : path) {auto x=p[0].get<int64_t>(),y=p[1].get<int64_t>();dp.push_back({x==0?0.0:static_cast<double>(x)/scale,y==0?0.0:static_cast<double>(y)/scale});}
      decimal_output.push_back(dp);
    }
  }
  size_t pc=0,vc=0;paths(grid_output,"decimal output",pc,vc);
  return {{"format_version",5},{"adapter_protocol_version",5},{"case_id",id},{"oracle_commit",kCommit},{"status","success"},{"operation",operation},{"precision",precision},{"reference_route",route},{"grid_paths",grid_output},{"paths",decimal_output}};
}
int main() {
  try {
    std::string data;
    char ch;
    while (std::cin.get(ch)) {
      require(data.size() < 8 * 1024 * 1024, "request: byte limit exceeded");
      data.push_back(ch);
    }
    std::vector<std::set<std::string>> object_keys;
    auto callback = [&object_keys](int depth, json::parse_event_t event, json& parsed) {
      require(depth <= 128, "request: JSON depth limit exceeded");
      if (event == json::parse_event_t::object_start) object_keys.emplace_back();
      else if (event == json::parse_event_t::key)
        require(object_keys.back().insert(parsed.get<std::string>()).second, "request: duplicate JSON field");
      else if (event == json::parse_event_t::object_end) object_keys.pop_back();
      return true;
    };
    auto response = execute(json::parse(data, callback));
    std::cout << response.dump() << '\n';
    return 0;
  } catch (const CompositionFailure& error) {
    std::cerr << "oracle: composition step " << error.step << ": " << error.what() << '\n';
    std::cout << json({{"format_version",4},{"status","error"},{"failure_step",error.step},{"message",error.what()}}).dump() << '\n';
    return 2;
  } catch (const std::exception& error) {
    std::cerr << "oracle: " << error.what() << '\n';
    std::cout << json({{"format_version", 1}, {"status", "error"}, {"message", error.what()}}).dump() << '\n';
    return 2;
  }
}

// v6 uses the real locked template. Reporting and normalization belong to this adapter.
Path64 simplify_normalize(const Path64& input, bool closed) {
  Path64 result;
  for (const auto& p:input) if (result.empty() || result.back()!=p) result.push_back(p);
  if (closed && result.size()>1 && result.front()==result.back()) result.pop_back();
  return result;
}
bool simplify_degenerate(const Path64& path,bool closed) {
  if (path.empty()) return true;
  auto a=path.front();auto b=a;
  for (auto p:path) if(p!=a) { b=p;break; }
  if(b==a) return true;
  if(!closed) return false;
  for(auto c:path) if((b.x-a.x)*(c.y-a.y)-(b.y-a.y)*(c.x-a.x)!=0) return false;
  return true;
}
json execute_simplify(const json& request) {
  bool decimal=request["operation"]=="SimplifyD";
  if(decimal) keys(request,{"format_version","operation","case_id","source","options","mode","epsilon","reference_route","normalization","paths","precision","grid"},"simplify decimal");
  else keys(request,{"format_version","operation","case_id","source","options","mode","epsilon","reference_route","normalization","paths"},"simplify integer");
  integer(request["format_version"],"simplify version",6,6);auto id=request_metadata(request);
  require(request["mode"]=="Closed" || request["mode"]=="Open","unknown simplify mode");
  bool closed=request["mode"]=="Closed";
  require(request["normalization"]=="ConsecutiveDuplicatesAndClosedSeam","unknown normalization");
  require(request["reference_route"]==(decimal?"DecimalGrid":"Integer"),"unknown simplify route");
  int precision=0;double scale=1;
  if(decimal) {precision=static_cast<int>(integer(request["precision"],"precision",0,6));const double scales[]={1,10,100,1000,10000,100000,1000000};scale=scales[precision];require(request["grid"]=="DecimalHalfAwayFromZero","unknown grid");}
  double epsilon=finite_number(request["epsilon"],"epsilon");require(epsilon>0,"reference epsilon must be positive");epsilon*=scale;
  require(std::isfinite(epsilon) && std::isfinite(epsilon*epsilon),"epsilon scaling/square overflow");
  Paths64 input;size_t pc=0,vc=0;
  if(!decimal) input=paths(request["paths"],"simplify paths",pc,vc);
  else {
    const auto& raw=request["paths"];require(raw.is_array() && raw.size()<=kMaxPaths,"path limit/type");
    std::map<std::pair<int64_t,int64_t>,std::pair<double,double>> seen;
    for(const auto& path:raw) {
      require(path.is_array() && path.size()<=kMaxVertices-vc,"raw vertex limit");vc+=path.size();Path64 out;
      for(const auto& point:path) {
        require(point.is_array() && point.size()==2,"expected pair");
        double x=finite_number(point[0],"x"),y=finite_number(point[1],"y"),bound=1000000000.0/scale;
        require(x>=-bound && x<=bound && y>=-bound && y<=bound,"original coordinate range");
        double sx=x*scale,sy=y*scale;require(std::isfinite(sx) && std::isfinite(sy) && sx>=-1e9 && sx<=1e9 && sy>=-1e9 && sy<=1e9,"scaled coordinate range");
        auto key=std::make_pair(static_cast<int64_t>(std::round(sx)),static_cast<int64_t>(std::round(sy)));auto rawp=std::make_pair(x,y);
        require(seen.find(key)==seen.end() || seen[key]==rawp,"distinct input positions merge");seen.emplace(key,rawp);out.emplace_back(key.first,key.second);
      }
      input.push_back(std::move(out));
    }
  }
  Paths64 normalized;json before=json::array(),after=json::array(),collapsed=json::array(),counts=json::array(),output=json::array(),decoded=json::array();
  for(size_t i=0;i<input.size();++i) {normalized.push_back(simplify_normalize(input[i],closed));if(simplify_degenerate(normalized.back(),closed)) before.push_back(i);}
  // Keep the actual template candidate order and floating distance formula.
  auto result=SimplifyPaths<int64_t>(normalized,epsilon,closed);size_t removed=0;
  for(size_t i=0;i<result.size();++i) {
    auto path=closed?simplify_normalize(result[i],true):result[i];output.push_back(output_path(path));
    size_t n=input[i].size()-path.size();counts.push_back(n);removed+=n;
    if(simplify_degenerate(path,closed)) {after.push_back(i);if(!simplify_degenerate(normalized[i],closed)) collapsed.push_back(i);}
    if(decimal) {json dp=json::array();for(auto p:path) dp.push_back(json::array({p.x==0?0.0:p.x/scale,p.y==0?0.0:p.y/scale}));decoded.push_back(dp);}
  }
  json response={{"format_version",6},{"adapter_protocol_version",6},{"case_id",id},{"oracle_commit",kCommit},{"status","success"},{"operation",request["operation"]},{"mode",request["mode"]},{"reference_route",request["reference_route"]},{"paths",output},{"removed_vertices",removed},{"removed_per_path",counts},{"input_degenerate_indices",before},{"degenerate_indices",after},{"collapsed_indices",collapsed}};
  if(decimal) {response["precision"]=precision;response["paths_d"]=decoded;}
  return response;
}

// v8: real locked RectClipLines64. Output stays ordered, open and directed.
json execute_rectclip(const json& request) {
  keys(request,{"format_version","case_id","source","operation","options","rect","paths"},"rectclip");
  integer(request["format_version"],"rectclip version",8,8);
  const auto id=request_metadata(request);
  const auto& r=request["rect"];
  require(r.is_array() && r.size()==4,"rect: expected four integer coordinates");
  int64_t a=integer(r[0],"rect.min_x",-1000000000,1000000000),b=integer(r[1],"rect.min_y",-1000000000,1000000000);
  int64_t c=integer(r[2],"rect.max_x",-1000000000,1000000000),d=integer(r[3],"rect.max_y",-1000000000,1000000000);
  require(a<=c && b<=d,"rect: reversed bounds");
  size_t pc=0,vc=0;auto input=paths(request["paths"],"rectclip paths",pc,vc);
  RectClipLines64 engine(Rect64(a,b,c,d));
  auto result=engine.Execute(input);
  json output=json::array();for(const auto& path:result) output.push_back(output_path(path));
  pc=0;vc=0;paths(output,"rectclip output",pc,vc);
  return {{"format_version",8},{"adapter_protocol_version",8},{"case_id",id},{"oracle_commit",kCommit},{"status","success"},{"operation","RectClipLines"},{"options",request["options"]},{"paths",output}};
}

// v7: real locked MinkowskiSum. Only preflight is adapter code.
json execute_minkowski(const json& request) {
  keys(request,{"format_version","case_id","source","operation","options","pattern","path","path_is_closed"},"Minkowski");
  integer(request["format_version"],"Minkowski version",7,7);
  require(request["operation"]=="MinkowskiSum" && request["path_is_closed"].is_boolean(),"invalid Minkowski operation/mode");
  keys(request["options"],{"preserve_collinear","reverse_solution"},"Minkowski options");
  require(request["options"]["preserve_collinear"].is_boolean() && request["options"]["preserve_collinear"]==true && request["options"]["reverse_solution"].is_boolean() && request["options"]["reverse_solution"]==false,"Minkowski output settings");
  auto metadata=request;metadata["options"]["preserve_collinear"]=false;auto id=request_metadata(metadata);
  size_t pc=0,vc=0;auto input=paths(json::array({request["pattern"],request["path"]}),"Minkowski input",pc,vc);
  const auto& pattern=input[0];const auto& path=input[1];bool closed=request["path_is_closed"].get<bool>();
  const size_t m=pattern.size(),n=path.size();
  if(m && n) {
    size_t edges=closed?n:n-1;
    require(m<=2147483647/n && (edges==0 || m<=2147483647/edges),"Minkowski product overflow");
    size_t p=m*n,q=m*edges;require(q<=2147483647/4,"Minkowski quad slots overflow");
    require(2+2*n+2*p+6*q<=500000 && n+p+2*q<=5000000,"Minkowski generation limit");
    for(auto a:path) for(auto b:pattern) {
      auto x=a.x+b.x,y=a.y+b.y;require(x>=-1000000000 && x<=1000000000 && y>=-1000000000 && y<=1000000000,"Minkowski translated coordinate range");
    }
  }
  auto result=MinkowskiSum(pattern,path,closed);
  json output=json::array();for(const auto& p:result) output.push_back(output_path(p));
  pc=0;vc=0;paths(output,"Minkowski output",pc,vc);
  return {{"format_version",7},{"adapter_protocol_version",7},{"case_id",id},{"oracle_commit",kCommit},{"status","success"},{"operation","MinkowskiSum"},{"fill_rule","NonZero"},{"options",request["options"]},{"paths",output}};
}
