{mylib, ...}: {
  imports = (mylib.scanPaths ./.) ++ [../base.nix];
  
  fontconfig = {
    enable = true;
    defaultFonts = {
      emoji = ["FiraCode Nerd Font"];
      monospace = ["FiraCode Nerd Font"];
      sansSerif = ["FiraCode Nerd Font"];
      serif = ["FiraCode Nerd Font"];
    };
  };
}
