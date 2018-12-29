module LeetCode.Foreign
  ( module Foreign
  , module Foreign.C
  , cFree
  ) where

import           Foreign
import           Foreign.C

foreign import ccall unsafe "free"
  cFree :: Ptr a -> IO ()
