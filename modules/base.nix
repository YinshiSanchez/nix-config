# Cycad's default home manager module which imports other home manager modules
{pkgs, ...}: {
  # Fonts
  fonts = {
    packages = with pkgs; [
      (nerdfonts.override {
        fonts = [
          # symbols icon only
          "NerdFontsSymbolsOnly"
          # Characters
          "FiraCode"
        ];
      })
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        emoji = ["FiraCode Nerd Font"];
        monospace = ["FiraCode Nerd Font"];
        sansSerif = ["FiraCode Nerd Font"];
        serif = ["FiraCode Nerd Font"];
      };
    };
  };
  xdg.enable = true;
}
