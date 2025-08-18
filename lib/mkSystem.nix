{
  lib,
  inputs,
  darwinModules,
  homeModules ? [],
  myvars,
  specialArgs ,
  ...
}: let
  inherit (myvars) system;
  inherit (inputs) nixpkgs-darwin home-manager nix-darwin nix-index-database;
in
  nix-darwin.lib.darwinSystem {
    inherit system specialArgs;
    modules =
      darwinModules
      ++ [
        {nixpkgs.pkgs = import nixpkgs-darwin {inherit system;};}
        nix-index-database.darwinModules.nix-index # command-not-found
      ]
      ++ (
        lib.optionals ((lib.lists.length homeModules) > 0)
        [
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              verbose = true;
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${myvars.username}.imports = homeModules;
              extraSpecialArgs = specialArgs;
            };
          }
        ]
      );
  }