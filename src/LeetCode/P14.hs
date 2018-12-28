module LeetCode.P14
  ( longestCommonPrefix
  , cLongestCommonPrefix
  ) where

import           Data.ByteString        (ByteString)
import qualified Data.ByteString        as BS
import qualified Data.ByteString.Unsafe as BS
import           Data.List              (transpose)
import           Data.Text              (Text)
import qualified Data.Text              as Text
import qualified Data.Text.Encoding     as Text
import           Foreign
import           Foreign.C
import           System.IO.Unsafe       (unsafePerformIO)

longestCommonPrefix :: [Text] -> Text
longestCommonPrefix ts =
  let minLength = minimum (fmap Text.length ts)
   in Text.pack $
        longestCommonPrefix' (fmap (take minLength . Text.unpack) ts)

longestCommonPrefix' :: [String] -> String
longestCommonPrefix' = fmap head . takeWhile allEqual . transpose

allEqual :: Eq a => [a] -> Bool
allEqual []     = True
allEqual (x:xs) = all (==x) xs

cLongestCommonPrefix :: [Text] -> Text
cLongestCommonPrefix ts = unsafePerformIO $
  useAsCStrings (Text.encodeUtf8 <$> ts) $ \cstrs -> do
    prefix <- c_longestCommonPrefix cstrs (fromIntegral $ length ts)
    Text.decodeUtf8 <$> BS.unsafePackMallocCString prefix
{-# NOINLINE cLongestCommonPrefix #-}

useAsCStrings :: [ByteString] -> (Ptr CString -> IO a) -> IO a
useAsCStrings bss action = do
  let len = length bss
  allocaArray len $ \cstrs ->
    fillCStrings bss cstrs cstrs action

fillCStrings :: [ByteString]
             -> Ptr CString -- dest begin
             -> Ptr CString -- dest current
             -> (Ptr CString -> IO a)
             -> IO a
fillCStrings [] destBeg _ action = action destBeg
fillCStrings (bs:bss) destBeg destCurrent action =
  BS.useAsCString bs $ \cstr -> do
    poke destCurrent cstr
    let destNext = plusPtr destCurrent (sizeOf cstr)
    fillCStrings bss destBeg destNext action

foreign import ccall "p14_longestCommonPrefix"
  c_longestCommonPrefix :: Ptr CString -> CInt -> IO CString
