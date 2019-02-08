import           Development.CabalBundleCLib       (mainWithCLib)
import           Development.CabalBundleCLib.CMake (simpleCMakeBuilder)

main :: IO ()
main = mainWithCLib
  "csrc" -- C project root directory, relative to package root directory
  ["leetcode_hs"] -- C library names
  ["."] -- Direct parent dirs for built libraries, relative to build root dir.
  simpleCMakeBuilder -- The builder
