{
  programs.zsh = {
    envExtra = ''
      [ -f "/opt/homebrew/bin/" ] && eval "$(/opt/homebrew/bin/brew shellenv)"
    '';

    initExtraBeforeCompInit = ''
      [ "$(command -v brew)" ] && fpath=("$(brew --prefix)/share/zsh/site-functions" $fpath)
    '';

    initExtra = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
  };

}
