{
  pkgs,
  username,
  ...
}: {
  programs.home-manager.enable = true;

  home = {stateVersion = "25.05";};

  catppuccin.flavor = "mocha";
}
