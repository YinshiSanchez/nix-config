{lib, ...}: {
  programs.zsh = {
    envExtra = ''
      [ -x /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"
    '';

    initContent = lib.mkMerge [
      (lib.mkBefore ''
        [ "$(command -v brew)" ] && fpath=("$(brew --prefix)/share/zsh/site-functions" $fpath)
      '')
      (lib.mkAfter ''
        eval "$(/opt/homebrew/bin/brew shellenv)"
      '')
    ];
  };
}
