{mylib, ...}: {
  imports =
    (mylib.scanPaths ./.)
    ++ [../base/home.nix ../base/core ../base/cli ../base/gui];
}
