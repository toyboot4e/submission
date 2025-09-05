# nix-direnv 用
# https://github.com/nix-community/nix-direnv

# cabal-plan は license-report 付きでインストールする方法が分からなかったので
# 手動で `cabal install cabal-plan -f exe -f license-report --overwrite-policy=always` しています……
# https://github.com/haskell-hvr/cabal-plan

{
  description = "A basic flake with a shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-for-ghc.url = "github:NixOS/nixpkgs/ebe4301cbd8f81c4f8d3244b3632338bbeb6d49c";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-for-ghc,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
        ghcpkgs = import nixpkgs-for-ghc {
          inherit system;
        };
      in
      {
        devShells.default =
          with pkgs;
          mkShell {
            buildInputs = [
              pkg-config
              stack
              cabal-install
              # glibc
              llvmPackages.bintools
              # openssl

              # hmatrix: https://github.com/haskell-numerics/hmatrix/blob/master/shell.nix
              zlib
              sundials
              blas
              gfortran.cc
              liblapack
              gsl
              glpk
              sundials
            ];

            packages = [
              (ghcpkgs.haskell.compiler.ghc984.override { useLLVM = true; })
              ghcpkgs.haskell.packages.ghc984.cabal-fmt
              # ghcpkgs.haskell.packages.ghc984.cabal-plan
            ];
          };
      }
    );
}
