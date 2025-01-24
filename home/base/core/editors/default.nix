{
  pkgs,
  mylib,
  ...
}: {
  imports = mylib.scanPaths ./.;

  home.packages = with pkgs;
  # cpp tools
    [
      cmake
      cmake-language-server
      gnumake
      checkmake
      gcc
      gdb
      # c/c++ tools with clang-tools, the unwrapped version won't
      # add alias like `cc` and `c++`, so that it won't conflict with gcc
      # llvmPackages.clang-unwrapped
      clang-tools
      lldb
    ]
    ++
    # rust
    [
      # rust
      # rust-overlay
      rust-bin.stable.latest.default # The default profile of `rustup`.
      rust-bin.stable.latest.rust-analyzer # rust lsp
    ]
    ++
    # nix
    [
      # lsp
      nil
      # # nixd
      statix # Lints and suggestions for the nix programming language
      alejandra # Nix Code Formatter]
    ];
}
