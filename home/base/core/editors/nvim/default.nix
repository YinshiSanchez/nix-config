{mylib,  ...}: {
  imports = mylib.scanPaths ./.;

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };
}
