{
  pkgs,
  mylib,
  system,
  ...
}: {
  imports = mylib.scanPaths ./.;

  home.packages = with pkgs;
    [
      # c/c++ tools with clang-tools, the unwrapped version won't
      # add alias like `cc` and `c++`, so that it won't conflict with gcc
      # llvmPackages.clang-unwrapped
      bear # Bear is a tool that generates a compilation database for clang tooling.
      protobuf
      protobufc
    ]
    # ++ [
    #   (rust-bin.selectLatestNightlyWith (toolchain:
    #     toolchain.default.override {
    #       extensions = [
    #         "rust-src"
    #         "rustfmt"
    #         "rust-analyzer"
    #         "clippy"
    #       ];
    #     }))
    # ]
    ++ [
      lua
    ]
    ++ [
      go
    ]
    ++ [
      nil
      statix
      alejandra
    ]
    ++ [
      black
    ]
    ++ [
      dotnet-sdk
    ]
    ++ [
      bun
    ]
    ++ (
      if system == "x86_64-linux"
      then [gdb]
      else []
    );
}
