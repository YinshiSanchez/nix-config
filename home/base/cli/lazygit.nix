{pkgs-unstable, ...}: {
  catppuccin.lazygit.enable = true;

  programs.lazygit = {
    enable = true;
    package = pkgs-unstable.lazygit;
    settings = {
      gui = {
        language = "en";
        nerdFontsVersion = "3";
        authorColors = {"*" = "#b4befe";};
      };
      git = {
        autoFetch = false;
        paging = {
          colorArg = "always";
          pager = "delta --dark --paging=never";
        };
      };
    };
  };
}
