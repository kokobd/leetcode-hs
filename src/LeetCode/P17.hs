{-# LANGUAGE OverloadedLists #-}

module LeetCode.P17
  ( letterCombinations
  ) where

import           Data.Char   (ord)
import qualified Data.Vector as V

letterCombinations :: String -> [String]
letterCombinations [] = []
letterCombinations (d:ds) =
  case digitToLetters d of
    Nothing      -> remaining
    Just letters ->
      if null remaining
      then fmap (:[]) letters
      else [ l:r | l <- letters, r <- remaining ]
  where
    remaining = letterCombinations ds

digitToLetters :: Char -> Maybe String
digitToLetters d = digitLetters V.!? (ord d - ord '0' - 2)

digitLetters :: V.Vector String
digitLetters = ["abc", "def", "ghi", "jkl", "mno", "pqrs", "tuv", "wxyz"]
