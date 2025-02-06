# { inputs, outputs, pkgs, pkgs-unstable, nixgl, mylib, ... }: {
{
  inputs,
  outputs,
  pkgs,
  pkgs-unstable,
  mylib,
  config,
  ...
}: {
  xdg.enable = true;


  home = {
    username = "yinshi";
    homeDirectory = "/home/yinshi";

    sessionPath = [
      "$HOME/.local/bin"
      "$HOME/.bin"
    ];
  };

  imports = [../../home/x86_64-linux];

  nixGL.packages = pkgs.nixgl;
  nixGL.defaultWrapper = "nvidia";
  nixGL.offloadWrapper = "nvidiaPrime";
  nixGL.installScripts = ["nvidia" "nvidiaPrime"];
}
