{
  inputs,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      fira-code-nerdfont
      # A command-line system information tool
      neofetch
      # Just is a handy way to save and run project-specific commands.
      just
      # Disk Usage/Free Utility - a better 'df' alternative
      duf
      # Shell extension that manages your environment
      direnv
    ];
  };
}
