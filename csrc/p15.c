#include <stdlib.h>

static int compareInt(const void *lhs, const void *rhs) {
  int x = *(const int *)lhs;
  int y = *(const int *)rhs;
  if (x < y) {
    return -1;
  } else if (x > y) {
    return 1;
  } else {
    return 0;
  }
}

int **p15_threeSum(int *nums, int numsSize, int *returnSize) {
  size_t resultSize = 0;
  size_t resultCapacity = 10;
  int **results = malloc(resultCapacity * sizeof(int *));
  qsort(nums, numsSize, sizeof(int), compareInt);
  for (int i = 0; i < numsSize - 2; ++i) {
    int a = nums[i];
    if (i > 0 && a == nums[i - 1])
      continue;
    int beg = i + 1;
    int end = numsSize - 1; // inclusive
    while (beg < end) {
      int b = nums[beg];
      int c = nums[end];
      int s = a + b + c;
      if (s == 0) {
        // found one
        if (resultSize == resultCapacity) {
          resultCapacity *= 2;
          results = realloc(results, resultCapacity * sizeof(int *));
        }
        results[resultSize] = malloc(3 * sizeof(int));
        results[resultSize][0] = a;
        results[resultSize][1] = b;
        results[resultSize][2] = c;
        ++resultSize;
        while (nums[beg] == b) {
          ++beg;
        }
        while (nums[end] == c) {
          --end;
        }
      } else if (s > 0) {
        while (nums[end] == c) {
          --end;
        }
      } else {
        while (nums[beg] == b) {
          ++beg;
        }
      }
    }
  }
  *returnSize = resultSize;
  return results;
}
