{
  lib,
  pkgs,
  config,
  is_desktop,
  ...
}: let
  configDir =
    if pkgs.stdenv.isDarwin
    then "Library/Application Support/com.mitchellh.ghostty"
    else "${config.xdg.configHome}/ghostty";
in {
  # It feels a bit strange to manage GUI applications with home-manager...
  # programs.ghostty = {
  #   enable = true;
  # };
  catppuccin.ghostty.enable = lib.mkIf is_desktop true;

  home.activation.installGhostty = lib.mkIf is_desktop (lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ -x /opt/homebrew/bin/brew ]; then
      BREW_BIN=/opt/homebrew/bin/brew
    elif command -v brew >/dev/null 2>&1; then
      BREW_BIN="$(command -v brew)"
    else
      echo "Skipping Ghostty install: Homebrew is not available" >&2
      exit 0
    fi

    if ! "$BREW_BIN" list --cask ghostty >/dev/null 2>&1; then
      echo "Installing Ghostty via Homebrew cask" >&2
      "$BREW_BIN" install --cask ghostty
    fi
  '');

  home.file."${configDir}/config" = lib.mkIf is_desktop {
    text = ''
      copy-on-select = true
      cursor-style = block
      cursor-style-blink = false
      font-family = "FiraCode Nerd Font"
      font-size = 12
      macos-option-as-alt = left
      macos-titlebar-proxy-icon = hidden
      macos-titlebar-style = tabs
      shell-integration = zsh
      shell-integration-features = sudo,no-cursor
      theme = Catppuccin Mocha
      window-decoration = true
      window-padding-balance = false
      window-padding-x = 10
      window-padding-y = 0
      keybind = shift+enter=text:\n
      auto-update-channel = tip
    '';
  };
}
