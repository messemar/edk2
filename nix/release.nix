{ sources ? import ./sources.nix
, pkgs ? import sources.nixpkgs  {}
}:
let
  edk2 = (pkgs.edk2.overrideAttrs (old: {
    src = ../.;
  }));

  Ovmf = { debug ? false, secureBoot ? false }:
    ((pkgs.OVMF.override {
      inherit edk2;
      # csmSupport = true;
    }).overrideAttrs (old: {
      src = ../.;
    })).fd;
in rec {
  Efi64Fd = Ovmf { };
  Efi64FdDebug = Ovmf { debug = true; };
}
