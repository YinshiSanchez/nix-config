# copy from maolonglong
{pkgs, ...}: let
  gpakosz-tmux = pkgs.fetchFromGitHub {
    owner = "gpakosz";
    repo = ".tmux";
    rev = "8e3b90c6c8d0eea022cbcb007dc518503a823765";
    hash = "sha256-Dg94ZMAxaF9okoNWFJymOY+NrNkfjugMZ8P66Se78yU=";
  };

  # 辅助函数：简化插件创建
  mkTmuxPlugin = pkgs.tmuxPlugins.mkTmuxPlugin;

  primaryIpModule = pkgs.writeText "primary_ip.conf" ''
    %hidden MODULE_NAME='primary_ip'
    set -ogq "@catppuccin_''${MODULE_NAME}_icon" '🌐'
    set -ogqF "@catppuccin_''${MODULE_NAME}_color" '#{E:@thm_lavender}'
    set -ogq "@catppuccin_''${MODULE_NAME}_text" '#{l:#{primary_ip}}'
    source -F ${pkgs.tmuxPlugins.catppuccin}/share/tmux-plugins/catppuccin/utils/status_module.conf
  '';

  #在此列表定义你需要但 pkgs.tmuxPlugins 中没有的插件
  customPlugins = [
    {
      plugin = mkTmuxPlugin {
        pluginName = "tmux-primary-ip";
        version = "master";
        src = pkgs.fetchFromGitHub {
          owner = "dreknix";
          repo = "tmux-primary-ip";
          rev = "d9323ee6517264e2e0ec2b87f4268eaa534206cd";
          hash = "sha256-0SMKeykR4IYlzexFJOC0Lz1ct0CFfUiDWAcxMZUVa+I=";
        };
      };
    }
    {
      plugin = mkTmuxPlugin {
        pluginName = "tmux-nerd-font-window-name";
        version = "master";
        src = pkgs.fetchFromGitHub {
          owner = "joshmedeski";
          repo = "tmux-nerd-font-window-name";
          rev = "f908795316ad27f7a76f04a660b355023e268e66";
          hash = "sha256-WIwGVk3j2QMXo5Q65ByY4nj8ySUVcpwptAAjw6kh8ds=";
        };
      };
    }
  ];
in {
  home.file = {
    ".tmux.conf".text = builtins.readFile "${gpakosz-tmux}/.tmux.conf";
    ".tmux.conf.local".text =
      builtins.readFile "${gpakosz-tmux}/.tmux.conf.local"
      + "\n"
      + (import ./custom.nix {
        inherit pkgs;
        extraPlugins = customPlugins;
        inherit primaryIpModule;
      });
  };

  catppuccin.tmux.enable = true;

  programs.tmux = {
    enable = true;
    extraConfig = ''
      source-file ~/.tmux.conf
      # Force status line to bottom after loading gpakosz config
      set -g status-position bottom
    '';
  };
}
