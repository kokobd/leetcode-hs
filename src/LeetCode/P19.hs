module LeetCode.P19
  ( removeNthFromEnd
  ) where

import           Control.Monad.State.Strict

removeNthFromEnd :: Int -> [a] -> [a]
removeNthFromEnd n xs
    | n < 0 = error "Illegal arument"
    | otherwise = evalState (removeNthFromEnd' n) (0, [], xs, xs)

removeNthFromEnd' :: Int -> State (Int, [a], [a], [a]) [a]
removeNthFromEnd' n = do
  (dist, prec, left, right) <- get
  case right of
    [] ->
      if dist < n
      then pure $ left
      else pure $ prec ++ safeTail left
    (_:right') -> do
      let newState =
            if dist < n
            then (dist + 1, prec, left, right')
            else
              let (x:left') = left
               in (dist, prec ++ [x], left', right')
      put newState
      removeNthFromEnd' n

safeTail :: [a] -> [a]
safeTail []     = []
safeTail (_:xs) = xs
