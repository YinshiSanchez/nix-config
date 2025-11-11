{
  config,
  pkgs,
  ...
}: {
  catppuccin.ghostty.enable = true;
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty;

    enableZshIntegration = true;

    installVimSyntax = true;
    installBatSyntax = true;

    settings = {
        font-size = 13;
        font-family = "FiraCode Nerd Font";
        macos-option-as-alt = left;
      }

  };

}
