{...}: {
  # A smarter cd command. Supports all major shells.
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
