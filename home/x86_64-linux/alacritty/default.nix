{
  config,
  pkgs,
  ...
}: {
  catppuccin.alacritty.enable = true;

  programs.alacritty = {
    enable = true;
    # settings = builtins.fromTOML (builtins.readFile ./alacritty.toml);
    package = config.lib.nixGL.wrap pkgs.alacritty;

    settings = {
      # general.import = [ ./catppuccin-mocha.toml ];
      window = {
        opacity = 0.85;
        startup_mode = "Maximized"; # Maximized window
        dynamic_title = true;
      };

      scrolling = {history = 10000;};

      font = {
        bold = {family = "FiraCode Nerd Font";};
        italic = {family = "FiraCode Nerd Font";};
        normal = {family = "FiraCode Nerd Font";};
        bold_italic = {family = "FiraCode Nerd Font";};
        size = 13;
      };

      terminal = {
        shell = {
          program = "${pkgs.zsh}/bin/zsh";
          args = ["-l" "-c" "zellij"];
        };
        # Controls the ability to write to the system clipboard with the OSC 52 escape sequence.
        osc52 = "CopyPaste";
      };
    };
  };
}
