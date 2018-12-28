module LeetCode.Test.Utils
  ( shouldWorkForSamples
  ) where

import           Data.Foldable (traverse_)
import           Test.Hspec

shouldWorkForSamples :: (Show a, Eq a, Show b, Eq b)
                     => (a -> b) -> [(a, b)] -> Expectation
shouldWorkForSamples f samples =
  traverse_ (\(x, y) -> (x, f x) `shouldBe` (x, y)) samples
