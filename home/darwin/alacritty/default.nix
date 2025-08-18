{
  config,
  pkgs,
  ...
}: {
  catppuccin.alacritty.enable = true;

  programs.alacritty = {
    enable = true;
    package = pkgs.alacritty;

    settings = {
       keyboard.bindings = [
        {
          key = "Space";
          mods = "Shift";
          action = "ToggleViMode";
        }
      ];
      window = {
        opacity = 0.85;
        startup_mode = "Maximized"; # Maximized window
        dynamic_title = true;
        option_as_alt = "Both"; # use `option` as `alt` in MacOS
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
        osc52 = "CopyPaste";
      };
    };
  };
}
