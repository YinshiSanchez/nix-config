{
  description = "Personal nix config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable-small";

    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    darwin = {
      url = "github:lnl7/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    flake-utils.url = "github:numtide/flake-utils";

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-unstable,
    nixpkgs-darwin,
    darwin,
    nix-index-database,
    rust-overlay,
    home-manager,
    flake-utils,
    catppuccin,
    ...
  }: let
    inherit (nixpkgs) lib;
    inherit (self) outputs;

    mylib = import ./lib {inherit lib;};

    hostConfigs = import ./hosts {inherit catppuccin;};

    systems = [
      # linux
      "x86_64-linux"
      # darwin
      "aarch64-darwin"
    ];

    forAllSystems = lib.genAttrs systems;

    genSpecialArgs = system: {
      inherit mylib;
      pkgs =
        import
        (
          if lib.hasSuffix "darwin" system
          then nixpkgs-darwin
          else nixpkgs
        ) {
          inherit system;
          config.allowUnfree = true;
          overlays = [rust-overlay.overlays.default];
        };

      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    };

    pkgArgs = forAllSystems genSpecialArgs;

    mkHomeConfiguration = host:
      home-manager.lib.homeManagerConfiguration {
        pkgs = pkgArgs.${host.system}.pkgs;
        extraSpecialArgs =
          pkgArgs.${host.system}
          // {
            inherit inputs outputs;
            inherit (host) username homeDirectory system;
            is_desktop = host.is_desktop or false;
          };
        modules =
          (lib.optionals (!lib.hasSuffix "darwin" host.system) host.hostModules)
          ++ host.homeModules
          ++ [
            {
              home = {
                username = lib.mkDefault host.username;
                homeDirectory = lib.mkDefault host.homeDirectory;
              };
            }
          ];
      };

    mkHomeConfigurations = hosts:
      lib.concatMapAttrs (hostname: host: let
        config = mkHomeConfiguration host;
      in {
        ${hostname} = config;
        "${host.username}@${hostname}" = config;
      })
      hosts;
  in {
    homeConfigurations = mkHomeConfigurations (hostConfigs.homeOnlyHosts // hostConfigs.darwinHosts);

    darwinConfigurations = builtins.mapAttrs (_: host:
      darwin.lib.darwinSystem rec {
        specialArgs =
          pkgArgs.${host.system}
          // {
            inherit inputs outputs;
            is_desktop = host.is_desktop or false;
          }
          // {inherit (host) username homeDirectory system;};
        modules =
          host.hostModules
          ++ [
            home-manager.darwinModules.home-manager
            {
              home-manager = {
                extraSpecialArgs = specialArgs;
                verbose = true;
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${host.username}.imports = host.homeModules;
              };
            }
          ];
      })
    hostConfigs.darwinHosts;
  };
}
