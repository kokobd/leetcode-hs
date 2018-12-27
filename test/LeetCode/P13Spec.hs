module LeetCode.P13Spec
  ( spec
  ) where

import           Data.Maybe   (fromJust)
import           LeetCode.P12 (intToRoman)
import           LeetCode.P13 (romanToInt)
import           Test.Hspec

spec :: Spec
spec =
  describe "romanToInt" $
    it "is an inverse operation of intToRoman" $
      fmap (romanToInt . fromJust . intToRoman) [1..3999] `shouldBe` [1..3999]
