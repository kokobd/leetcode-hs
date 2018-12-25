# leetcode-hs

Solutions to some leetcode problems implemented in Haskell.

As of Dec 25, 2018, LeetCode doesn't support Haskell officially, so each
solution has a corresponding C implementation, which is passed on LeetCode.
Haskell versions are tested against C versions, to ensure Haskell
implementations are correct.

For many problems, it's critical to get time and space complexity right. We use
ghc profiling to make sure Haskell versions are not significantly slower than C
ones.

## Build and Development

Please use [cabal new build][1]

The code is tested with `cabal 2.4.1.0` and `GHC 8.6.2`.

There is a special flag in this cabal package: `debug-c`. Enable this flag to
turn on `-g -O0` options of `gcc`. Then you can use `gdb` to debug C code.

[1]: https://cabal.readthedocs.io/en/stable/nix-local-build-overview.html
