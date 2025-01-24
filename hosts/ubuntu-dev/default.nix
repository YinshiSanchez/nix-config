# { inputs, outputs, pkgs, pkgs-unstable, nixgl, mylib, ... }: {
{
  inputs,
  outputs,
  pkgs,
  pkgs-unstable,
  mylib,
  ...
}: {
  home = {
    username = "yinshi";
    homeDirectory = "/home/yinshi";
  };

  imports = [../../home/x86_64-linux];

  nixGL.packages = pkgs.nixgl;
  nixGL.defaultWrapper = "nvidia";
  nixGL.offloadWrapper = "nvidiaPrime";
  nixGL.installScripts = ["nvidia" "nvidiaPrime"];
}
