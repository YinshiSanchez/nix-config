{...}: {
  catppuccin.fzf.enable = true;

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;

    defaultCommand = "fd --type f --strip-cwd-prefix --hidden --follow --exclude .git";
  };
}
