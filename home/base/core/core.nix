{
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      nerd-fonts.fira-code
      # A command-line system information tool
      neofetch
      # Just is a handy way to save and run project-specific commands.
      just
      # Disk Usage/Free Utility - a better 'df' alternative
      duf
      # A simple, fast and user-friendly alternative to 'find'
      fd
      # A framework for managing and maintaining multi-language pre-commit hooks.
      pre-commit
      # Simplified and community-driven man pages.
      tldr
      # Extremely fast Python package installer and resolver, written in Rust
      uv
      # command line json pager
      jless
      nodejs_24
      # a lightweight and portable command-line YAML, JSON, INI and XML processor.
      yq-go
      # a dependency and package manager for C and C++ languages
      conan
      # Python frame stack sampler for CPython
      austin
    ];
  };
}
