# { nixpkgs ? import <nixpkgs> {}, compiler ? "default" }:
# let
#   inherit (nixpkgs) pkgs;
#   drv = import ./default.nix { inherit nixpkgs compiler; };
#   drvWithTools = pkgs.haskell.lib.addBuildDepends drv [ pkgs.cabal-install ];
# in
#   if pkgs.lib.inNixShell then drvWithTools.env else drvWithTools
let
  config = (import ./config.nix);
in with config; hpkgs.shellFor {
      packages = p: [drv];
      buildInputs = with nixpkgs; [ hie cabal2nix cabal-install hlint hpkgs.ghcid hpkgs.stylish-haskell hpkgs.hasktags hpkgs.hoogle ];
    }

# Maybe this will cure my woes one day; https://twitter.com/puffnfresh/status/990154797494943744?lang=en
# (import <nixpkgs> { }).haskellPackages.developPackage { root = ./.; }

