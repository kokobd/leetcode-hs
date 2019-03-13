module LeetCode.P19Spec
  ( spec
  ) where

import           LeetCode.Test.Utils (shouldWorkForSamples)
import           Test.Hspec

import           LeetCode.P19        (removeNthFromEnd)

spec :: Spec
spec =
  describe "removeNthFromEnd" $
    it "should work for the given samples" $
      flip removeNthFromEnd [1..5] `shouldWorkForSamples` samples

samples :: [(Int, [Int])]
samples =
  [ (0, [1..5])
  , (1, [1..4])
  , (2, [1, 2, 3, 5])
  , (3, [1, 2, 4, 5])
  , (4, [1, 3, 4, 5])
  , (5, [2, 3, 4, 5])
  , (6, [1..5])
  ]
