{...}: {
  programs.ripgrep = {
    enable = true;
    arguments = [
      "--colors=line:style:bold"
    ];
  };
}
