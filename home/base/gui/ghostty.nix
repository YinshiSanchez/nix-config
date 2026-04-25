{
  lib,
  pkgs,
  is_desktop,
  ...
}: {
  home.packages = lib.optionals (is_desktop && !pkgs.stdenv.isDarwin && builtins.hasAttr "ghostty" pkgs) [
    pkgs.ghostty
  ];
}
