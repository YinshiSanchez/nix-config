{catppuccin, ...}: {
  homeOnlyHosts = {
    ubuntu-dev = rec {
      username = "dev";
      homeDirectory = "/home/${username}";
      system = "x86_64-linux";
      is_desktop = true;

      hostModules = [
        ../modules/x86_64-linux
        ../hosts/ubuntu-dev
      ];
      homeModules = [
        ../home/x86_64-linux
        catppuccin.homeManagerModules.catppuccin
      ];
    };
    devbox = rec {
      username = "zhangzhixin.2892";
      homeDirectory = "/home/${username}";
      system = "x86_64-linux";
      is_desktop = false;
      homeModules = [
        ../home/x86_64-linux
        ../hosts/devbox/home.nix
        catppuccin.homeManagerModules.catppuccin
      ];
      hostModules = [
        ../modules/x86_64-linux
        ../hosts/devbox
      ];
    };
  };

  darwinHosts = {
    work = rec {
      username = "bytedance";
      homeDirectory = "/Users/${username}";
      system = "aarch64-darwin";
      is_desktop = true;
      is_desktop = true;
      homeModules = [
        ../home/darwin
        ../hosts/work/home.nix
        catppuccin.homeManagerModules.catppuccin
      ];
      hostModules = [
        ../modules/darwin
        ../hosts/work
      ];
    };
  };
}
