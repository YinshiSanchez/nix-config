{
  pkgs,
  mylib,
  ...
}: {
  imports = mylib.scanPaths ./.;

  home.packages = with pkgs;
  # cpp tools
    [
      gnumake
      checkmake
      # c/c++ tools with clang-tools, the unwrapped version won't
      # add alias like `cc` and `c++`, so that it won't conflict with gcc
      # llvmPackages.clang-unwrapped
      # llvmPackages_18.clang-tools
      bear # Bear is a tool that generates a compilation database for clang tooling.
      protobuf
      protobufc
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
    ]
    ++
    # python
    [
      black
    ]
    ++
    #
    [
      dotnet-sdk
    ]
    ++
    # js
    [
      bun
      nodejs_24
    ]
    ;
}
