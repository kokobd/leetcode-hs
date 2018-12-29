module LeetCode.P15Spec
  ( spec
  ) where

import           Data.Bifunctor      (second)
import           Data.Set            (Set)
import qualified Data.Set            as Set
import           LeetCode.P15
import           LeetCode.Test.Utils (shouldWorkForSamples)
import           Test.Hspec

spec :: Spec
spec = do
  describe "threeSum" $
    it "works for some known samples" $
      (toResult . threeSum) `shouldWorkForSamples` samples
  describe "cThreeSum" $
    it "works for some known samples" $
      (toResult . cThreeSum) `shouldWorkForSamples` samples

samples :: [([Int], (Set (UnorderedTuple Int), Int))]
samples = fmap (second toResult)
  [ ([-1, 0, 1, 2, -1, -4], [(-1, 0, 1), (-1, -1, 2)])
  , ([], [])
  , ([0, 0, 0, 0, 0], [(0, 0, 0)])
  ]

toResult :: [(Int, Int, Int)] -> (Set (UnorderedTuple Int), Int)
toResult rs = (Set.fromList . fmap UnorderedTuple $ rs, length rs)
