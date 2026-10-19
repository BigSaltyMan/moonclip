// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
// CLI transport only; geometry remains in the MoonBit library.
#include <moonbit.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
moonbit_bytes_t moonclip_probe_stdin(void) {
  const size_t limit = 8 * 1024 * 1024;
  unsigned char *buffer = (unsigned char *)malloc(limit + 1);
  if (!buffer) return moonbit_make_bytes(0, 0);
  size_t size = fread(buffer, 1, limit + 1, stdin);
  if (size > limit || ferror(stdin)) { free(buffer); return moonbit_make_bytes(0, 0); }
  moonbit_bytes_t result = moonbit_make_bytes_raw((int32_t)size);
  memcpy(result, buffer, size);
  free(buffer);
  return result;
}
