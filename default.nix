let cfg = (pkgs : {
      packageOverrides = pkgs : {

    localHaskellPackages = pkgs.haskellPackages_ghc783.override {
          extension = self : super : {

        cabal = super.cabal.override {
          extension = self : super : {
            noHaddock = true;
            hyperlinkSource = false;
          };
        };

          };
        };
      };
  }); in
let pkgs = import <nixpkgs> {config = cfg;}; in
let localHaskellPackages = pkgs.localHaskellPackages; in

pkgs.haskellPackages.cabal.mkDerivation (self: {
  pname = "ocharles-netwire";
  version = "0.1.0.0";
  src = ./.;
  buildDepends = with localHaskellPackages; [ cabalInstall SDL netwire ];
  hyperlinkSource = false;
  isLibrary = false;
  isExecutable = true;
})
