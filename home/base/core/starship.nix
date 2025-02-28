{...}: {
  catppuccin.starship.enable = true;

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      "$schema" = "https://starship.rs/config-schema.json";
      character = {
        success_symbol = "[>](bold green)";
        error_symbol = "[>](bold red)";
        vimcmd_symbol = "[<](bold green)";
        vimcmd_replace_symbol = "[<](bold yellow)";
        vimcmd_replace_one_symbol = "[<](bold purple)";
        
      };
    };
  };
}
# "format": "$symbol ",
#        "success_symbol": "[❯](bold green)",
#        "error_symbol": "[❯](bold red)",
#        "vimcmd_symbol": "[❮](bold green)",
#        "vimcmd_visual_symbol": "[❮](bold yellow)",
#        "vimcmd_replace_symbol": "[❮](bold purple)",
#        "vimcmd_replace_one_symbol": "[❮](bold purple)",
#        "disabled": false
