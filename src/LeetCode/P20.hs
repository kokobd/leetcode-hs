{-# LANGUAGE MultiWayIf #-}

module LeetCode.P20
  ( isValid
  ) where

import           Data.Maybe (maybe)

-- | test whether the input string contains valid parenthesis
isValid :: String -> Bool
isValid s = maybe False null (isValid' s "")

isValid' :: String -> String -> Maybe String
isValid' "" stack = Just stack
isValid' (x:xs) stack =
  if | isLeftPar x -> isValid' xs (x:stack)
     | isRightPar x -> popCorrespondingLeft x stack >>= isValid' xs
     | otherwise -> isValid' xs stack

isLeftPar :: Char -> Bool
isLeftPar c = c `elem` "([{"

isRightPar :: Char -> Bool
isRightPar c = c `elem` ")]}"

popCorrespondingLeft :: Char -> String -> Maybe String
popCorrespondingLeft _ "" = Nothing
popCorrespondingLeft c (x:xs) = do
  matches <- fmap (c==) (lookup x [('(', ')'), ('[', ']'), ('{', '}')])
  if matches
    then Just xs
    else Nothing
