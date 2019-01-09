module LeetCode.P16Spec
  ( spec
  ) where

import           LeetCode.P16
import           LeetCode.Test.Utils
import           Test.Hspec
import           Test.QuickCheck

spec :: Spec
spec = do
  describe "threeSumClosest" $ do
    it "works for some known samples" $
      uncurry threeSumClosest `shouldWorkForSamples` samples
    it "gives the same answer as the c version" $ property $
      \xs target -> threeSumClosest xs target == cThreeSumClosest xs target
  describe "cThreeSumClosest" $
    it "works for some known samples" $
      uncurry cThreeSumClosest `shouldWorkForSamples` samples

samples :: [(([Int], Int), Maybe Int)]
samples =
  [ (([-1, 2, 1, -4], 1), Just 2)
  , (([], 3), Nothing)
  ]
