{...}: {
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host node3
          Hostname 219.216.64.113
      Host github.com
          Hostname ssh.github.com
          Port 443
          User git
    '';
  };
}
