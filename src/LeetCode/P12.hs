{-# LANGUAGE OverloadedLists   #-}
{-# LANGUAGE OverloadedStrings #-}

module LeetCode.P12
  ( intToRoman
  , cIntToRoman
  ) where

import           Data.ByteString    (ByteString)
import qualified Data.ByteString    as BS
import           Data.Text          (Text)
import qualified Data.Text          as Text
import qualified Data.Text.Encoding as Text
import           Data.Vector        (Vector)
import qualified Data.Vector        as V
import           Foreign            (Ptr)
import           Foreign.C          (CInt (..), CString)
import           System.IO.Unsafe   (unsafePerformIO)

intToRoman :: Int -> Maybe Text
intToRoman x =
  if x > 3999 || x <= 0
  then Nothing
  else Just $
    Text.concat . reverse $ zipWith digitToRoman digits [0..]
  where
    digits = intDigits x

-- |Generate digits of an integer, from lower to higher.
intDigits :: Int -> [Int]
intDigits n
  | n <= 0 = []
  | otherwise = (n `mod` 10) : intDigits (n `div` 10)
  where
    base = 10

digitToRoman :: Int -- ^digit
             -> Int -- ^index
             -> Text -- ^roman
digitToRoman digit i = (digitToRomanTable V.! i) V.! digit

digitToRomanTable :: Vector (Vector Text)
digitToRomanTable =
  [ ["", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"]
  , ["", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"]
  , ["", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"]
  , ["", "M", "MM", "MMM"]
  ]

cIntToRoman :: Int -> Text
cIntToRoman x = unsafePerformIO $ do
  result <- c_intToRoman (fromIntegral x)
  bs <- BS.packCString result
  c_free result
  pure . Text.decodeUtf8 $ bs
{-# NOINLINE cIntToRoman #-}

foreign import ccall "p12_intToRoman"
  c_intToRoman :: CInt -> IO CString

foreign import ccall unsafe "free"
  c_free :: Ptr a -> IO ()
