{
  mylib,
  username,
  system,
  pkgs,
  ...
}: {
  imports = mylib.scanPaths ./.;

  users.users."${username}" = {
    home = "/Users/${username}";
  };

  nixpkgs.hostPlatform = system;
  system.stateVersion = 5;
  system.primaryUser = "${username}";

  environment.systemPackages = with pkgs; [
    htop
    wget
    neovim
  ];
}
