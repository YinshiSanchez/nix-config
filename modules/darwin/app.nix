{
  lib,
  is_desktop,
  ...
}: let
  # Homebrew Mirror
  # NOTE: is only useful when you run `brew install` manually! (not via nix-darwin)
  homebrew_mirror_env = {
    HOMEBREW_API_DOMAIN = "https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api";
    HOMEBREW_BOTTLE_DOMAIN = "https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles";
    HOMEBREW_BREW_GIT_REMOTE = "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git";
    HOMEBREW_CORE_GIT_REMOTE = "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git";
    HOMEBREW_PIP_INDEX_URL = "https://pypi.tuna.tsinghua.edu.cn/simple";
  };

  local_proxy_env = {
    # HTTP_PROXY = "http://127.0.0.1:7890";
    # HTTPS_PROXY = "http://127.0.0.1:7890";
  };

  homebrew_env_script =
    lib.attrsets.foldlAttrs
    (acc: name: value: acc + "\nexport ${name}=${value}")
    ""
    (homebrew_mirror_env // local_proxy_env);
in {
  # Set environment variables for nix-darwin before run `brew bundle`.
  system.activationScripts.homebrew.text = lib.mkBefore ''
    echo >&2 '${homebrew_env_script}'
    ${homebrew_env_script}
  '';

  homebrew = {
    enable = true;

    masApps = {
      Wechat = 836500024;
      QQ = 451108668;
    };

    taps = [
      "localsend/localsend"
    ];

    brews = [
      "flyctl"
      "mas"
    ];

    # `brew install --cask`
    casks =
      [
        "raycast"
        "visual-studio-code"
        "font-fira-code-nerd-font"
        "rectangle"
      ]
      ++ lib.optionals is_desktop [
        "ghostty"
      ];
  };
}
