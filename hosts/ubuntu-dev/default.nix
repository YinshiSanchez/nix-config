{...}: {
  xdg.enable = true;

  home = {
    username = "dev";
    homeDirectory = "/home/dev";

    sessionPath = [
      "$HOME/.local/bin"
      "$HOME/.bin"
    ];
  };
}
