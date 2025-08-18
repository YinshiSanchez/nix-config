{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      (nerdfonts.override {
        fonts = [
          # symbols icon only
          "NerdFontsSymbolsOnly"
          # Characters
          "FiraCode"
        ];
      })
    ];
  };
}
