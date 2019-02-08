#include <stdbool.h>
#include <stdlib.h>

static bool matchPrefix(char **strp, const char *prefix);

#define ROMAN_TABLE_ROWS 4
#define ROMAN_TABLE_COLS 10
static char *romanTable[ROMAN_TABLE_ROWS][ROMAN_TABLE_COLS] = {
    {"", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"},
    {"", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"},
    {"", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"},
    {"", "M", "MM", "MMM"}};

int p13_romanToInt(char *s) {
  int result = 0;
  for (int i = ROMAN_TABLE_ROWS - 1; i >= 0; --i) {
    result *= 10;
    bool matched = false;
    int j;
    for (j = ROMAN_TABLE_COLS - 1; j >= 0; --j) {
      if (matched = matchPrefix(&s, romanTable[i][j])) {
        break;
      }
    }
    if (matched)
      result += j;
  }
  return result;
}

static bool matchPrefix(char **strp, const char *prefix) {
  if (prefix == NULL) {
    return false;
  }
  char *str = *strp;
  while (*prefix != '\0') {
    if (*prefix != *str) {
      return false;
    }
    ++prefix;
    ++str;
  }
  *strp = str;
  return true;
}
