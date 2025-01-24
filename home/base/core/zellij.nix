{...}: {
  catppuccin.zellij.enable = true;

  programs.zellij = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      default_shell = "zsh";
      default_mode = "locked";
      mouse_mode = true;
      scroll_buffer_size = 10000;
    };
  };
}
