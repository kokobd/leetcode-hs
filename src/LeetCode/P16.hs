module LeetCode.P16
  ( threeSumClosest
  , cThreeSumClosest
  ) where

import           Data.Foldable                (minimumBy)
import           Data.Function                (on)
import qualified Data.Vector.Algorithms.Intro as Vector.Intro
import qualified Data.Vector.Unboxed          as UV
import           LeetCode.Foreign
import           System.IO.Unsafe             (unsafePerformIO)

threeSumClosest :: [Int] -> Int -> Maybe Int
threeSumClosest xs target
  | lengthLessThan xs 3 = Nothing
  | otherwise = Just $ threeSumClosest' (UV.fromList xs) target

lengthLessThan :: [a] -> Int -> Bool
lengthLessThan xs n = null . drop (n - 1) $ xs

threeSumClosest' :: UV.Vector Int -> Int -> Int
threeSumClosest' xs target = fst . minimumBy (compare `on` snd)
  . fmap (uncurry (threeSumClosestWithX target)) $ splits
  where
    splits = uvSplits $ UV.create $ do
      xs' <- UV.thaw xs
      Vector.Intro.sort xs'
      pure xs'

uvSplits :: UV.Unbox a => UV.Vector a -> [(a, UV.Vector a)]
uvSplits v
  | UV.length v < 3 = []
  | otherwise = (UV.head v, UV.tail v) : uvSplits (UV.tail v)

threeSumClosestWithX :: Int -- target
                     -> Int -- head
                     -> UV.Vector Int -- remains
                     -> (Int, Int) -- (closest sum, diff to target)
threeSumClosestWithX target x remains
  | UV.length remains >= 2 =
      let y = UV.head remains
          z = UV.last remains
          s = x + y + z
          diff = abs (s - target)
          nextRemains = if s < target then UV.tail remains else UV.init remains
          (nextSum, nextDiff) = threeSumClosestWithX target x nextRemains
       in minimumBy (compare `on` snd) [(s, diff), (nextSum, nextDiff)]
  | otherwise = (maxBound, maxBound)

foreign import ccall "p16_threeSumClosest"
  c_threeSumClosest :: Ptr CInt -> CInt -> CInt -> IO CInt

cThreeSumClosest :: [Int] -> Int -> Maybe Int
cThreeSumClosest xs target
  | lengthLessThan xs 3 = Nothing
  | otherwise = Just $ unsafePerformIO $
      withArray (fromIntegral <$> xs) $ \nums ->
        fromIntegral <$> c_threeSumClosest
          nums (fromIntegral n) (fromIntegral target)
      where
        n = length xs
{-# NOINLINE cThreeSumClosest #-}
