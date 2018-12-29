{-# LANGUAGE MultiWayIf    #-}
{-# LANGUAGE TupleSections #-}

module LeetCode.P15
  ( threeSum
  , cThreeSum
  , UnorderedTuple(..)
  ) where

import           Data.Foldable    (foldl')
import           Data.IntSet      (IntSet)
import qualified Data.IntSet      as IntSet
import           Data.List        (sort, tails)
import qualified Data.Set         as Set
import           LeetCode.Foreign
import           System.IO.Unsafe (unsafePerformIO)

threeSum :: [Int] -> [(Int, Int, Int)]
threeSum = fmap unUnorderedTuple . nub' . concatMap (\xs' ->
  case splitHead xs' of
    Just (x, ys) -> fmap (\(y, z) -> UnorderedTuple (x, y, z)) (twoSum (-x) ys)
    Nothing      -> []
  ) . tails

twoSum :: Int -> [Int] -> [(Int, Int)]
twoSum x = snd . foldl' go (IntSet.empty, [])
  where
    go :: (IntSet, [(Int, Int)]) -> Int -> (IntSet, [(Int, Int)])
    go (ys, results) z =
      let y = x - z
       in if IntSet.member y ys
          then (ys, (y, z):results)
          else (IntSet.insert z ys, results)

splitHead :: [a] -> Maybe (a, [a])
splitHead []     = Nothing
splitHead (x:xs) = Just (x, xs)

newtype UnorderedTuple a = UnorderedTuple
  { unUnorderedTuple :: (a, a, a)
  }

instance Ord a => Eq (UnorderedTuple a) where
  t1 == t2 = t1 `compare` t2 == EQ

instance Ord a => Ord (UnorderedTuple a) where
  UnorderedTuple (x1, y1, z1) `compare` UnorderedTuple (x2, y2, z2) =
    sort [x1, y1, z1] `compare` sort [x2, y2, z2]

instance Show a => Show (UnorderedTuple a) where
  show (UnorderedTuple t) = show t

nub' :: Ord a => [a] -> [a]
nub' = Set.toList . Set.fromList

cThreeSum :: [Int] -> [(Int, Int, Int)]
cThreeSum xs = unsafePerformIO $
  withArray (fmap fromIntegral xs) $ \numsPtr ->
    alloca $ \resultsSizePtr -> do
      resultsPtr <- c_threeSum numsPtr numsSize resultsSizePtr
      resultsSize <- fromIntegral <$> peek resultsSizePtr
      results <- peekArray resultsSize resultsPtr
      results' <- flip traverse results $ \resultPtr -> do
        [x, y, z] <- peekArray 3 resultPtr
        let r = (fromIntegral x, fromIntegral y, fromIntegral z)
        cFree resultPtr
        pure r
      cFree resultsPtr
      pure results'

  where
    numsSize = fromIntegral $ length xs
{-# NOINLINE cThreeSum #-}

foreign import ccall "p15_threeSum"
  c_threeSum :: Ptr CInt -> CInt -> Ptr CInt -> IO (Ptr (Ptr CInt))
