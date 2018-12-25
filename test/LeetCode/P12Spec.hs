{-# LANGUAGE OverloadedStrings #-}

module LeetCode.P12Spec
  ( spec
  ) where

import           Data.Foldable (traverse_)
import           Data.Maybe    (fromJust)
import           Data.Text     (Text)
import           Test.Hspec

import           LeetCode.P12  (cIntToRoman, intToRoman)

spec :: Spec
spec = do
  describe "cIntToRoman" $
    it "works for given samples" $
      cIntToRoman `shouldWorkForSamples` basicSamples
  describe "intToRoman" $ do
    it "works for given samples" $
      (fromJust . intToRoman) `shouldWorkForSamples` basicSamples
    it "gives same answer as the c version for all input from 1 to 3999" $ do
      let xs = [1..3999]
      fmap (Just . cIntToRoman) xs `shouldBe` fmap intToRoman xs

basicSamples :: [(Int, Text)]
basicSamples =
  [ (3, "III")
  , (4, "IV")
  , (9, "IX")
  , (58, "LVIII")
  , (1994, "MCMXCIV")
  ]

shouldWorkForSamples :: (Show a, Eq a, Show b, Eq b)
                     => (a -> b) -> [(a, b)] -> Expectation
shouldWorkForSamples f samples =
  traverse_ (\(x, y) -> (x, f x) `shouldBe` (x, y)) samples
