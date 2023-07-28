{ outputs, config, lib, pkgs, ... }:

let
  jq = "${pkgs.jq}/bin/jq";
  playerctl = "${pkgs.playerctl}/bin/playerctl";
  playerctld = "${pkgs.playerctl}/bin/playerctld";

  # Function to simplify making waybar outputs
  jsonOutput = name: { pre ? "", text ? "", tooltip ? "", alt ? "", class ? "", percentage ? "" }: "${pkgs.writeShellScriptBin "waybar-${name}" ''
    set -euo pipefail
    ${pre}
    ${jq} -cn \
      --arg text "${text}" \
      --arg tooltip "${tooltip}" \
      --arg alt "${alt}" \
      --arg class "${class}" \
      --arg percentage "${percentage}" \
      '{text:$text,tooltip:$tooltip,alt:$alt,class:$class,percentage:$percentage}'
  ''}/bin/waybar-${name}";
in
{
  programs.waybar = {
    enable = true;
    package = (pkgs.waybar.overrideAttrs (oldAttrs: {
       mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    }));

    settings = {
      primary = {
        mode = "dock";
        layer = "top";
        height = 32;
        position = "bottom";
        modules-left = [
	  "wlr/workspaces"
	];

	"wlr/workspaces" = {
          on-click = "activate";
        };

	modules-right = [
	  "custom/player"
	  "custom/currentplayer"
	  "backlight"
	  "pulseaudio"
	  "network"
	  "battery"
	  "cpu"
	  "memory"
	  "clock"
	  "tray"
	];

	clock = {
          format = "{:%d/%m/%Y %H:%M}";
        };

	memory = {
          format = "󰍛  {}%";
          interval = 5;
        };

	cpu = {
          format = "   {usage}%";
        };

	battery = {
          bat = "BAT0";
          interval = 10;
          format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
        };

        network = {
          interval = 3;
          format-wifi = "   {essid}";
          format-ethernet = "󰈁 Connected";
          format-disconnected = "";
          tooltip-format = ''
            {ifname}
            {ipaddr}/{cidr}
            Up: {bandwidthUpBits}
            Down: {bandwidthDownBits}'';
        };

	pulseaudio = {
          format = "{icon}  {volume}%";
          format-muted = "   0%";
          format-icons = {
            headphone = "󰋋";
            headset = "󰋎";
            portable = "";
            default = [ "" "" "" ];
          };
        };

        "custom/player" = {
          exec-if = "${playerctl} status";
          exec = ''${playerctl} metadata --format '{"text": "{{artist}} - {{title}}", "alt": "{{status}}", "tooltip": "{{title}} ({{artist}} - {{album}})"}' '';
          return-type = "json";
          interval = 1;
          format = "{icon} {}";
          format-icons = {
            "Playing" = "󰐊";
            "Paused" = "󰏤 ";
            "Stopped" = "󰓛";
          };
          on-click = "${playerctl} play-pause";
        };

	"custom/currentplayer" = {
          interval = 1;
          return-type = "json";
          exec = jsonOutput "currentplayer" {
            pre = ''
              player="$(${playerctl} status -f "{{playerName}}" 2>/dev/null || echo "No player active" | cut -d '.' -f1)"
              count="$(${playerctl} -l | wc -l)"
              if ((count > 1)); then
                more=" +$((count - 1))"
              else
                more=""
              fi
            '';
            alt = "$player";
            tooltip = "$player ($count available)";
            text = "$more";
          };
          format = "{icon}{}";
          format-icons = {
            "No player active" = "";
            "mpv" = "󰎁 ";
            "discord" = " 󰙯 ";
            "kdeconnect" = "󰄡 ";
	    "chromium" = " ";
          };
          on-click = "${playerctld} shift";
          on-click-right = "${playerctld} unshift";
        };

	backlight = {
          format = "{icon}";
          format-icons = [ "" "" "" "" "" "" "" "" ""];
        };
      };
    };

    style = ''
    window#waybar {
      background-color: rgba(0, 0, 0, .3);
    }

    #workspaces button {
      margin: 5;
      color: white;
      border-radius: 0;
      border: none;
    }

    #workspaces button.active {
      border: 1px solid white;
      background-color: black;
    }

    #workspaces button:hover {
      color: black;
    }

    #clock,
    #memory,
    #cpu,
    #battery,
    #network,
    #pulseaudio,
    #backlight,
    #custom-currentplayer {
      padding: 0 15;
      color: white;
      border-radius: 0;
      border-left: 1px solid white;
    }

    #custom-player {
      padding: 0 15;
      color: white;
    }

    #tray {
      padding: 0 15;
      border-left: 1px solid white;
    }
    '';
  };
}
