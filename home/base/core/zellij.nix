{...}: {
  catppuccin.zellij.enable = true;

  programs.zellij = {
    enable = true;

    settings = {
      default_shell = "zsh";
      default_mode = "normal";
      mouse_mode = true;
      scroll_buffer_size = 10000;
      show_startup_tips= false;
    };
  };
}
