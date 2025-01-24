{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    dotDir = ".config/zsh";

    initExtraFirst = ''
      ZVM_INIT_MODE=sourcing
    '';

    initExtra = ''
      bindkey ^F forward-word
      bindkey ^B backward-word
    '';

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
