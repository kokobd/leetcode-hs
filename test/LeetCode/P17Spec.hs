module LeetCode.P17Spec
  ( spec
  ) where

import           LeetCode.P17        (letterCombinations)
import           LeetCode.Test.Utils
import           Test.Hspec

spec :: Spec
spec =
  describe "letterCombinations" $
    it "works for given samples" $
      letterCombinations `shouldWorkForSamples` samples

samples :: [(String, [String])]
samples =
  [ ("23", ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"])
  ]
