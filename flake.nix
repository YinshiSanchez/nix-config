{
  description = "Personal nix config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable-small";

    nixGL = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
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
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-unstable,
    nixGL,
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

    systems = [
      # linux
      "x86_64-linux"
      # darwin
    ];

    hosts = ["ubuntu-dev"];

    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;

    genSpecialArgs = system: {
      inherit mylib;
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [nixGL.overlays.default rust-overlay.overlays.default];
      };

      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };

      # nixgl = {
      #   packages = inputs.nixGL.packages.${system};
      #   config.allowUnfree = true;
      # };
    };

    pkgArgs = forAllSystems (system: genSpecialArgs system);
  in {
    # Available through 'home-manager switch --flake .#your-username@your-hostname'
    homeConfigurations = nixpkgs.lib.genAttrs hosts (host:
      home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs =
          pkgArgs.x86_64-linux
          // {
            inherit inputs outputs;
          };
        modules = [./hosts/${host} catppuccin.homeManagerModules.catppuccin];
      });
  };
}
