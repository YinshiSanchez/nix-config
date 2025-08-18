{
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
}
