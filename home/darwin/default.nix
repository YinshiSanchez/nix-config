{mylib, ...}: {
  imports =
    (mylib.scanPaths ./.)
    ++ [../base/home.nix ../base/core ../base/cli ../base/gui];

  home = {
    sessionPath = [
      "/opt/homebrew/bin"
      "$HOME/.bin"
      "$HOME/.local/bin"
      "$HOME/Library/Python/3.9/bin"
    ];
  };
}
