// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
// Native CLI transport only. No geometry code and no user text in a shell command.
#ifndef _WIN32
#define _POSIX_C_SOURCE 200809L
#endif
#include <moonbit.h>
#include <stdio.h>
#include <stdlib.h>
#ifndef _WIN32
#include <sys/wait.h>
#endif
int32_t moonclip_report(moonbit_bytes_t payload) {
#ifdef _WIN32
  FILE *pipe = _popen("python tools/conformance/run_report.py", "wb");
#else
  FILE *pipe = popen("python tools/conformance/run_report.py", "w");
#endif
  if (!pipe) return 2;
  size_t n = (size_t)Moonbit_array_length(payload);
  int failed = fwrite(payload, 1, n, pipe) != n;
#ifdef _WIN32
  int code = _pclose(pipe);
#else
  int status = pclose(pipe);
  int code = WIFEXITED(status) ? WEXITSTATUS(status) : 2;
#endif
  return failed ? 2 : code;
}
void moonclip_exit(int32_t code) { exit(code); }
