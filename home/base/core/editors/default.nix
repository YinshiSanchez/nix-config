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
      bear # Bear is a tool that generates a compilation database for clang tooling.
      protobuf
      protobufc
    ]
    ++
    # rust
    [
      # rust
      # rust-overlay
      # (rust-bin.stable.latest.default.override {
      #   extensions = [
      #   ];
      # })
      (rust-bin.selectLatestNightlyWith (toolchain:
        toolchain.default.override {
          extensions = [
            "rust-src" # source code
            "rustfmt" # formatting tool
            "rust-analyzer" # lsp
            "clippy" # lint
          ];
        }))
    ]
    ++
    # go
    [
      go
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
