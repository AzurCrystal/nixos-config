{ config, pkgs, lib, ... }:

{
  wayland.windowManager.sway =
    let
      cfg = config.wayland.windowManager.sway.config;
      workspaceSymbols = [
        "1:"
        "2:󰖟"
        "3:"
        "4:󱢧"
        "5:"
        "6:󰏆"
        "7:"
        "8:"
        "9:"
        "10:󰀲"
      ];
    in
    {
      package = null;
      enable = true;
      config = {
        modifier = "Mod4";
        terminal = "alacritty";
        menu = "rofi -show drun -theme $HOME/.config/rofi/style-launcher.rasi";
        output = {
          "*" = {
            bg = "$HOME/.local/share/background.jpg fill";
          };
        };
        keybindings =
          let

            workspaces = builtins.listToAttrs (map
              (i:
                {
                  name = "${cfg.modifier}+" + (if i == 10 then "0" else (toString i));
                  value = "workspace number ${builtins.elemAt workspaceSymbols (i - 1)}";
                }
              )
              (lib.lists.range 1 10));
            moveContainers = builtins.listToAttrs (map
              (i:
                {
                  name = "${cfg.modifier}+Shift+" + (if i == 10 then "0" else (toString i));
                  value = "move container to workspace number ${builtins.elemAt workspaceSymbols (i - 1)}";
                }
              )
              (lib.lists.range 1 10));
            moveWorkspaces = {
              "${cfg.modifier}+bracketleft" = "move workspace to output left";
              "${cfg.modifier}+bracketright" = "move workspace to output right";
            };
            specialKeys = {
              "--locked XF86Display" = "wlr-randr --output eDP-1 --toggle";
            };
          in
          lib.mkOptionDefault (
            workspaces //
            moveContainers //
            moveWorkspaces //
            specialKeys
          );
        assigns = {
          "1:" = [ ];
          "2:󰖟" = [
            { app_id = "firefox"; }
          ];
          "3:" = [
            { class = "obsidian"; }
          ];
          "4:󱢧" = [
            { app_id = "anki"; }
          ];
          "5:" = [
            { app_id = "vlc"; }
          ];
          "6:󰏆" = [
            { class = "wps"; }
          ];
          "7:" = [
            { class = "QQ"; }
            { class = "Element"; }
            { class = "TeamSpeak 3"; }
            { app_id = "org.telegram.desktop"; }
            { class = "weixin"; }
            { class = "com.alibabainc.dingtalk"; }
            { instance = "wechat.exe"; }
          ];
          "8:" = [
            { app_id = "com.gitee.gmg137.NeteaseCloudMusicGtk4"; }
          ];
          "9:" = [
            { class = "Steam"; }
            { class = "steam"; }
          ];
          "10:󰀲" = [
            { app_id = "Waydroid"; }
          ];
        };
        startup = [
          { command = "--no-startup-id swaymsg 'workspace ${builtins.elemAt workspaceSymbols 1}; exec firefox'"; }
          { command = "--no-startup-id swaymsg 'workspace ${builtins.elemAt workspaceSymbols 7}; exec netease-cloud-music-gtk4'"; }
          { command = "--no-startup-id swaymsg 'workspace ${builtins.elemAt workspaceSymbols 0} ; exec ${cfg.terminal}'"; }
        ];

        bars = [{
          fonts = {
            names = [ "Hack Nerd Font Mono" ];
            size = 16.0;
          };
          statusCommand = "i3status-rs config-laptop-main.toml";
          position = "top";
          mode = "dock";
          workspaceNumbers = false;
        }];
      };
      extraConfig = ''
        default_border none
        default_floating_border none
        font pango:monospace 0
        titlebar_padding 1
        titlebar_border_thickness 0
      '';

    };
  home.file = {
    ".local/share/background.jpg" = {
      source = ./background.jpg;
    };
  };
}
