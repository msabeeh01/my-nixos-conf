{ pkgs ? import <nixpkgs> {} }:

(pkgs.buildFHSEnv {
  name = "simple-x11-env";
  allowUnfree=true;
  targetPkgs = pkgs: (with pkgs; [
    udev
    alsa-lib
    opera
    nautilus
  ]) ++ (with pkgs.xorg; [
    libX11
    libXcursor
    libXrandr
    #software
  ]);
  multiPkgs = pkgs: (with pkgs; [
    udev
    alsa-lib
  ]);
  runScript = "bash";
}).env
