{
  pkgs,
  lib,
  ...
}: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    dotDir = ".config/zsh";
    shellAliases = {
      lg = "lazygit";
      byte_proxy = "http_proxy=http://sys-proxy-rd-relay.byted.org:8118 https_proxy=http://sys-proxy-rd-relay.byted.org:8118 no_proxy=.byted.org";
      singbox_proxy = "http_proxy=http://127.0.0.1:2892 https_proxy=http://127.0.0.1:2892";
    };

    initContent = lib.mkMerge [
      (lib.mkBefore ''
        ZVM_INIT_MODE=sourcing
        export CLANG_FORMAT=/usr/bin/clang-format
        export NIXPKGS_ALLOW_UNFREE=1
        eval "$(direnv hook zsh)"
      '')
      (lib.mkAfter ''
        bindkey ^F forward-word
        bindkey ^B backward-word
        # bindkey '^I' expand-or-complete

        # Fix CTRL+L clearing scrollback buffer
        # Use clear-screen instead of the default clear which might include \e[3J
        bindkey '^L' clear-screen
      '')
    ];

    plugins = [
      {
        name = "zsh-vi-mode";
        src = pkgs.fetchFromGitHub {
          owner = "jeffreytse";
          repo = "zsh-vi-mode";
          rev = "v0.11.0";
          sha256 = "sha256-xbchXJTFWeABTwq6h4KWLh+EvydDrDzcY9AQVK65RS8=";
        };
      }
    ];

    oh-my-zsh = {
      enable = true;
      plugins = ["git" "golang" "docker"];
      theme = ""; # starship
    };
  };
}
