{...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    extraLuaConfig = ''
      require("self")
    '';
  };

  xdg.configFile."nvim/lua".source = ./lua;
}
