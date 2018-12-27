# leetcode-hs

LeetCode solutions implemented in Haskell and C.

As of Dec 25, 2018, LeetCode doesn't support Haskell officially, so each
solution has a corresponding C implementation, which is passed on LeetCode.
Haskell versions are tested against C versions, to ensure Haskell
implementations are correct.

For many problems, it's critical to get time and space complexity right. We use
ghc profiling to make sure Haskell versions are not significantly slower than C
ones.

## Build and Development

Please use [stack](https://docs.haskellstack.org/en/stable/README/)

There is a special flag in this cabal package: `debug-c`. Enable this flag to
turn on `-g -O0` options of `gcc`. Then you can use `gdb` to debug C code.
