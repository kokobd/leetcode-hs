#include <limits.h>
#include <stdbool.h>
#include <stdlib.h>

static int compInt(const void *lhs, const void *rhs) {
  int x = *(const int *)lhs;
  int y = *(const int *)rhs;
  if (x < y) {
    return -1;
  } else if (x == y) {
    return 0;
  } else {
    return 1;
  }
}

int p16_threeSumClosest(int *nums, int numsSize, int target) {
  qsort(nums, numsSize, sizeof(int), compInt);
  int closestSum = INT_MAX;
  int minDiff = INT_MAX;
  bool foundEqual = false;
  for (size_t i = 0; i < numsSize - 2 && !foundEqual; ++i) {
    int x = nums[i];
    size_t j = i + 1;
    size_t k = numsSize - 1;
    while (j < k) {
      int y = nums[j];
      int z = nums[k];
      int s = x + y + z;
      int diff = abs(s - target);
      if (diff < minDiff) {
        minDiff = diff;
        closestSum = s;
      }
      if (s < target) {
        ++j;
      } else if (s > target) {
        --k;
      } else {
        foundEqual = true;
        break;
      }
    }
  }

  return closestSum;
}
