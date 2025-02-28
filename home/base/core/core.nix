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
      # A simple, fast and user-friendly alternative to 'find'
      fd
      # A framework for managing and maintaining multi-language pre-commit hooks.
      pre-commit
    ];
  };
}
