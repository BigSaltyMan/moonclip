// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
// Adapter only: all clipping is performed by the locked C++ Clipper2 engine.
#include "clipper2/clipper.engine.h"
#include "clipper2/clipper.offset.h"
#include <cmath>
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
json execute(const json& request);
double finite_number(const json& value, const std::string& where) {
  require(value.is_number(), where + ": expected finite numeric token");
  double number = value.get<double>();
  require(std::isfinite(number), where + ": expected finite number");
  return number;
}
json execute_offset(const json& request) {
  keys(request, {"format_version", "case_id", "source", "operation", "fill_rule", "options", "paths", "delta", "join_type", "miter_limit"}, "offset request");
  integer(request["format_version"], "offset format_version", 2, 2);
  double delta = finite_number(request["delta"], "delta");
  double miter = finite_number(request["miter_limit"], "miter_limit");
  require(miter >= 2, "miter_limit: must be at least 2");
  require(request["join_type"].is_string(), "join_type: expected string");
  auto join = request["join_type"].get<std::string>();
  require(join == "Miter" || join == "Bevel", "join_type: unsupported join");
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
    require(join == "Bevel" || std::abs(delta) < 0.5 || std::isfinite(miter * miter), "miter_limit: numeric overflow");
    ClipperOffset offset(miter, 0.0, false, false);
    offset.AddPaths(normalized, join == "Miter" ? JoinType::Miter : JoinType::Bevel, EndType::Polygon);
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
json execute(const json& request) {
  if (request.is_object() && request.value("operation", json()) == "OffsetPolygons") return execute_offset(request);
  keys(request, {"format_version", "case_id", "source", "operation", "fill_rule", "options", "subject", "clip"}, "request");
  require(integer(request["format_version"], "format_version", 1, 1) == 1, "unknown protocol");
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
  } catch (const std::exception& error) {
    std::cerr << "oracle: " << error.what() << '\n';
    std::cout << json({{"format_version", 1}, {"status", "error"}, {"message", error.what()}}).dump() << '\n';
    return 2;
  }
}
