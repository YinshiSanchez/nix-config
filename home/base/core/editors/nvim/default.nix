{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  home.activation.installNeovimConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
    nvimConfigDir="${config.xdg.configHome}/nvim"
    nvimConfigRepo="git@github.com:YinshiSanchez/nvim.git"

    if [ -e "$nvimConfigDir" ] && [ ! -d "$nvimConfigDir" ]; then
      echo "Skipping Neovim config setup: $nvimConfigDir exists but is not a directory" >&2
      exit 0
    fi

    if [ ! -e "$nvimConfigDir" ]; then
      echo "Cloning Neovim config into $nvimConfigDir" >&2
      mkdir -p "$(dirname "$nvimConfigDir")"
      ${pkgs.git}/bin/git clone "$nvimConfigRepo" "$nvimConfigDir"
      exit 0
    fi

    if [ -d "$nvimConfigDir/.git" ]; then
      remote_url="$(${pkgs.git}/bin/git -C "$nvimConfigDir" remote get-url origin 2>/dev/null || true)"

      if [ -n "$remote_url" ] && [ "$remote_url" != "$nvimConfigRepo" ]; then
        echo "Neovim config remote is $remote_url, expected $nvimConfigRepo; leaving existing checkout untouched" >&2
      fi
    else
      echo "Neovim config directory already exists at $nvimConfigDir; leaving it untouched" >&2
    fi
  '';
}
