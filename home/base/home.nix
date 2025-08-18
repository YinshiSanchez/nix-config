{...}: {
  programs.home-manager.enable = true;

  home = {
    stateVersion = "25.05";
    sessionPath = [
      "$HOME/.local/bin"
      "$HOME/.bin"
      "$HOME/.cargo/bin"
      "$HOME/go/bin"
    ];
  };

  catppuccin.flavor = "mocha";
}
