module LeetCode.P20Spec
  ( spec
  ) where

import           LeetCode.P20        (isValid)
import           LeetCode.Test.Utils
import           Test.Hspec

spec :: Spec
spec =
  describe "isValid" $
    it "works for given samples" $
      isValid `shouldWorkForSamples` samples

samples :: [(String, Bool)]
samples =
  [ ("", True)
  , ("(", False)
  , ("()", True)
  , ("[]", True)
  , ("{}", True)
  , ("{()}", True)
  , ("{()]}", False)
  , ("([]){[", False)
  , ("([]){}", True)
  , ("(abc)[]", True)
  ]
