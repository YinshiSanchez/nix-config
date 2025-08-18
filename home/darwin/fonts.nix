{...}: {
  # In macOS, fonts are managed through homebrew in modules/darwin/app.nix
  # The font-fira-code-nerd-font cask is installed there directly
  # (no longer needs homebrew/cask-fonts tap as it was deprecated)
  #
  # This provides the same Nerd Font functionality as the Linux configuration
  # but uses the macOS-appropriate package manager
}
