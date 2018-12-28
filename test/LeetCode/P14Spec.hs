{-# LANGUAGE OverloadedStrings #-}

module LeetCode.P14Spec
  ( spec
  ) where

import           Data.Text           (Text)
import           LeetCode.P14
import           LeetCode.Test.Utils (shouldWorkForSamples)
import           Test.Hspec

spec :: Spec
spec = do
  describe "longestCommonPrefix" $
    it "works for some samples" $
      longestCommonPrefix `shouldWorkForSamples` samples
  describe "cLongestCommonPrefix" $
    it "works for some samples" $
      cLongestCommonPrefix `shouldWorkForSamples` samples

samples :: [([Text], Text)]
samples =
  [ (["flower", "flow", "flight"], "fl")
  , (["dog", "racecar", "car"], "")
  , ([], "")
  , ([""], "")
  , (["", "abc"], "")
  , (["abc", ""], "")
  ]
