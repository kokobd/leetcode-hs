#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

inline static bool parMatch(char left, char right) {
  return left == '(' && right == ')' || left == '[' && right == ']' ||
         left == '{' && right == '}';
}

bool p20_isValid(const char *s) {
  size_t s_len = strlen(s);
  char *stack = (char *)malloc(s_len * sizeof(char));
  size_t stack_size = 0;
  bool ret = false;
  for (const char *pt = s; *pt != '\0'; ++pt) {
    const char ch = *pt;
    if (ch == '(' || ch == '[' || ch == '{') {
      stack[stack_size++] = ch;
    } else {
      if (parMatch(stack[stack_size - 1], ch)) {
        --stack_size;
      } else {
        goto cleanup;
      }
    }
  }
  if (stack_size == 0)
    ret = true;

cleanup:
  free(stack);
  return ret;
}
