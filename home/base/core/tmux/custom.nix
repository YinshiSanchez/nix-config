{
  pkgs,
  tmuxConfig,
}: let
  # 辅助函数：自动生成 run-shell 指令
  loadPlugin = pluginPack: let
    args =
      if builtins.isAttrs pluginPack && builtins.hasAttr "plugin" pluginPack
      then pluginPack
      else {plugin = pluginPack;};
    plugin = args.plugin;
    extraConfig = args.extraConfig or "";
  in ''
    ${extraConfig}
    run-shell ${plugin}/share/tmux-plugins/${plugin.pluginName}/${plugin.pluginName}.tmux
  '';

  # 辅助函数：渲染 Catppuccin 模块定义
  # 如果模块提供了 definition，直接渲染
  renderModuleDefinition = mod:
    if mod ? definition
    then mod.definition
    else "";

  # 辅助函数：渲染 Catppuccin 模块初始化脚本 (init)
  # 用于 source 对应的 conf 文件 (例如 directory.conf)
  renderModuleInit = mod:
    if mod ? init
    then mod.init
    else "";

  # 辅助函数：生成 status-right 的组件
  renderStatusModule = mod: "set -agF status-right \"#{E:@catppuccin_status_${mod.name}}\"";

in ''
  # ==========================================
  # General Settings
  # ==========================================
  ${tmuxConfig.baseConfig}

  # ==========================================
  # Catppuccin Configuration
  # ==========================================
  tmux_conf_theme=disabled
  ${builtins.concatStringsSep "\n" (pkgs.lib.mapAttrsToList (k: v: "set -g @catppuccin_${k} \"${v}\"") tmuxConfig.catppuccin.options)}

  # Load Catppuccin Core
  # 使用 source-file 同步加载，确保变量在 status-right 构建前立即可用
  source -F "${pkgs.tmuxPlugins.catppuccin}/share/tmux-plugins/catppuccin/catppuccin_options_tmux.conf"
  source -F "${pkgs.tmuxPlugins.catppuccin}/share/tmux-plugins/catppuccin/catppuccin_tmux.conf"

  # ==========================================
  # Custom & Standard Module Definitions
  # ==========================================
  # 1. Define custom modules (variables + sourcing status_module.conf)
  ${builtins.concatStringsSep "\n" (map renderModuleDefinition tmuxConfig.catppuccin.modules)}

  # 2. Initialize/Reload modules if needed (e.g. re-sourcing directory.conf)
  ${builtins.concatStringsSep "\n" (map renderModuleInit tmuxConfig.catppuccin.modules)}

  # ==========================================
  # Status Line Composition
  # ==========================================
  set -g status-right-length 200
  set -g status-left-length 100
  set -g status-left ""
  set -g status-left "#{E:@catppuccin_status_session} "
  set -g status-right ""

  # Append modules to status-right in order
  ${builtins.concatStringsSep "\n" (map renderStatusModule tmuxConfig.catppuccin.modules)}

  set -g status-position bottom

  # ==========================================
  # Plugins Loading
  # ==========================================
  ${builtins.concatStringsSep "\n" (map loadPlugin tmuxConfig.plugins)}
''
