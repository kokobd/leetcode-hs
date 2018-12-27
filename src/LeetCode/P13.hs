{-# LANGUAGE BangPatterns      #-}
{-# LANGUAGE OverloadedLists   #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TupleSections     #-}

module LeetCode.P13
  ( romanToInt
  , cRomanToInt
  ) where

import qualified Data.ByteString    as BS
import           Data.List          (stripPrefix)
import           Data.Maybe         (catMaybes)
import           Data.Text          (Text)
import qualified Data.Text          as Text
import qualified Data.Text.Encoding as Text
import           Data.Vector        (Vector)
import qualified Data.Vector        as V
import           Foreign
import           Foreign.C
import           System.IO.Unsafe   (unsafePerformIO)

romanToInt :: Text -> Int
romanToInt roman = romanToInt' (Text.unpack roman, romanTable, 0)

romanToInt' :: (String, [Vector Text], Int) -> Int
romanToInt' ("", [], !n) = n
romanToInt' (s, [], !_) = error "invalid sequence"
romanToInt' (s, (row:rows), !n) =
  case safeHead . catMaybes . V.toList . V.imap (\i p -> (,i) <$> stripPrefix (Text.unpack p) s) $ row of
    Nothing      -> error "Impossible code path"
    Just (s', i) -> romanToInt' (s', rows, V.length row - 1 - i + n * 10)

safeHead :: [a] -> Maybe a
safeHead []    = Nothing
safeHead (x:_) = Just x

romanTable :: [Vector Text]
romanTable = reverse . fmap V.reverse $
  [ ["", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"]
  , ["", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"]
  , ["", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"]
  , ["", "M", "MM", "MMM"]
  ]

cRomanToInt :: Text -> Int
cRomanToInt text = unsafePerformIO $
  BS.useAsCString (Text.encodeUtf8 text) $ \cstr ->
    pure . fromIntegral $ c_romanToInt cstr
{-# NOINLINE cRomanToInt #-}

foreign import ccall "p13_romanToInt"
  c_romanToInt :: CString -> CInt
