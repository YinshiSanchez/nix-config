{
  pkgs,
  extraPlugins ? [],
  primaryIpModule ? null,
}: let
  # 辅助函数：自动生成 run-shell 指令
  # 标准 Nix插件路径通常是: share/tmux-plugins/<name>/<name>.tmux
  loadPlugin = pluginPack: let
    args =
      if builtins.isAttrs pluginPack && builtins.hasAttr "plugin" pluginPack
      then pluginPack
      else {plugin = pluginPack;};
    plugin = args.plugin;
    extraConfig = args.extraConfig or "";
  in
    # load config first, then run-shell to load the plugin
    ''
      ${extraConfig}
      run-shell ${plugin}/share/tmux-plugins/${plugin.pluginName}/${plugin.pluginName}.tmux
    '';
in ''
  # Place your custom tmux configuration here
  # This file will be appended to the gpakosz's .tmux.conf.local

  # Options to make tmux more pleasant
  set -g mouse on
  set -g mode-keys vi
  set -g status-keys vi
  set -g default-terminal "tmux-256color"
  set -ga terminal-overrides ",*:Tc"

  # Configure the catppuccin plugin
  tmux_conf_theme=disabled
  set -g @catppuccin_flavor "mocha"
  set -g @catppuccin_window_status_style "rounded"
  set -g @catppuccin_directory_text " #{=/-20/...:#{s|$HOME|~|:pane_current_path}}"
  set -g @catppuccin_window_text " #W"
  set -g @catppuccin_window_current_text " #W"

  # Load catppuccin
  # 使用 source-file 同步加载，确保变量在 status-right 构建前立即可用
  source -F "${pkgs.tmuxPlugins.catppuccin}/share/tmux-plugins/catppuccin/catppuccin_options_tmux.conf"
  source -F "${pkgs.tmuxPlugins.catppuccin}/share/tmux-plugins/catppuccin/catppuccin_tmux.conf"

  # 强制重新加载 directory 模块，确保它能读取到最新的 @catppuccin_directory_text
  source -F "${pkgs.tmuxPlugins.catppuccin}/share/tmux-plugins/catppuccin/status/directory.conf"

  # Primary IP module for catppuccin (requires tmux-primary-ip plugin)
  ${
    if primaryIpModule != null
    then "source -F ${primaryIpModule}"
    else ""
  }

  set -g automatic-rename-format "#{window_icon} #{b:pane_current_path}"
  # Make the status line pretty and add some modules
  set -g status-right-length 200
  set -g status-left-length 100
  set -g status-left ""
  set -g status-left "#{E:@catppuccin_status_session} "
  set -g status-right ""
  # set -g status-right "#{E:@catppuccin_status_application}"

  # 注意：这里改用 set -ag (去掉F)，让 status line 在运行时动态展开 path
  # 如果用 -F，会在加载配置时立即展开，导致 path 为空
  set -ag status-right "#{E:@catppuccin_status_directory}"
  set -agF status-right "#{E:@catppuccin_status_primary_ip}"
  set -agF status-right "#{E:@catppuccin_status_cpu}"
  set -ag status-right "#{E:@catppuccin_status_uptime}"
  set -agF status-right "#{E:@catppuccin_status_battery}"
  set -g status-position bottom

  # Load standard plugins
  ${loadPlugin pkgs.tmuxPlugins.cpu}
  ${loadPlugin pkgs.tmuxPlugins.battery}

  # Load extra custom plugins
  ${builtins.concatStringsSep "\n" (map loadPlugin extraPlugins)}

  # Fix CTRL+L clearing scrollback history
  # gpakosz config binds C-l to 'send-keys C-l \; clear-history' by default.
  # We override it to only send the keys.
  bind -n C-l send-keys C-l
''
