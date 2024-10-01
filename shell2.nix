{
  pkgs ? import <nixpkgs> {
    config.allowUnfree = true;
  },
}:
(pkgs.buildFHSEnv {
  name = "simple-x11-env";
  targetPkgs =
    pkgs:
    (with pkgs; [
      udev
      alsa-lib
    ])
    ++ (with pkgs.xorg; [
      libX11
      libXcursor
      libXrandr
      #software
    ]);
  multiPkgs =
    pkgs:
    (with pkgs; [
      udev
      alsa-lib
    ]);
  runScript = "bash";

  }).env


