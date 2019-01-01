#include <stdlib.h>
#include <string.h>

static const char *digitLetterTable[] = {"abc", "def",  "ghi", "jkl",
                                         "mno", "pqrs", "tuv", "wxyz"};

static size_t digitLetterSizeTable[] = {3, 3, 3, 3, 3, 4, 3, 4};

inline static const char *digitToLetters(char digit) {
  return digitLetterTable[digit - '0' - 2];
}

inline static const size_t digitToLettersSize(char digit) {
  return digitLetterSizeTable[digit - '0' - 2];
}

char **p17_letterCombinations(char *digits, int *returnSize) {
  if (digits[0] == '\0') {
    *returnSize = 0;
    return NULL;
  }
  size_t resultSize = 1;
  size_t digitsSize = 0;
  for (char *pt = digits; *pt != '\0'; ++pt) {
    resultSize *= digitToLettersSize(*pt);
    ++digitsSize;
  }
  *returnSize = resultSize;
  char **results = (char **)malloc(resultSize * sizeof(char *));
  for (size_t i = 0; i < resultSize; ++i) {
    results[i] = (char *)calloc(1 + digitsSize, sizeof(char));
  }
  size_t cycleSize = resultSize;
  for (size_t i = 0; i != digitsSize; ++i) {
    char digit = digits[i];
    const char *letters = digitToLetters(digit);
    size_t lettersSize = digitToLettersSize(digit);
    size_t cycleCount = resultSize / cycleSize;
    size_t letterRepeat = cycleSize / lettersSize;
    size_t j = 0;
    for (size_t a = 0; a != cycleCount; ++a) {
      for (size_t b = 0; b != lettersSize; ++b) {
        const char ch = letters[b];
        for (size_t c = 0; c != letterRepeat; ++c) {
          results[j][i] = ch;
          ++j;
        }
      }
    }
    cycleSize = letterRepeat;
  }
  return results;
}
