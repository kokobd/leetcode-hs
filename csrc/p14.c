#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

char *p14_longestCommonPrefix(char **strs, int strsSize) {
  if (strsSize <= 0) {
    return "";
  }
  int j = 0;
  while (true) {
    char ch = strs[0][j];
    if (ch == '\0')
      goto endloop;
    for (int i = 1; i < strsSize; ++i) {
      if (strs[i][j] != ch) {
        goto endloop;
      }
    }
    ++j;
  }
  char *prefix;
endloop:
  prefix = malloc((j + 1) * sizeof(char));
  memcpy(prefix, strs[0], j);
  prefix[j] = '\0';
  return prefix;
}
