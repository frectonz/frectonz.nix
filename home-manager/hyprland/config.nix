''
  # See https://wiki.hyprland.org/Configuring/Monitors/
  monitor=eDP-1,1920x1080@60,0x0,1

  exec-once = waybar
  exec-once = swaybg -i ./hdd/home/fraol/Pictures/Wallpapers/sky-1.png -m fill
  exec-once = nm-applet --indicator

  # Source a file (multi-file configs)
  # source = ~/.config/hypr/myColors.conf

  # Some default env vars.
  env = XCURSOR_SIZE,24

  input {
      kb_layout = us

      follow_mouse = 1

      touchpad {
          natural_scroll = no
      }

      sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
  }

  general {
      gaps_in = 10
      gaps_out = 10
      border_size = 0
      col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
      col.inactive_border = rgba(595959aa)

      layout = dwindle
  }

  decoration {
      active_opacity=0.9
      inactive_opacity=0.84

      blur = yes
      blur_size = 3
      blur_passes = 1
      blur_new_optimizations = on

      drop_shadow = yes
      shadow_range = 10
      shadow_render_power = 3
      col.shadow = rgba(1a1a1aee)
  }

  animations {
      enabled = yes

      # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

      bezier = myBezier, 0.05, 0.9, 0.1, 1.05

      animation = windows, 1, 7, myBezier
      animation = windowsOut, 1, 7, default, popin 80%
      animation = border, 1, 10, default
      animation = borderangle, 1, 8, default
      animation = fade, 1, 7, default
      animation = workspaces, 1, 6, default
  }

  dwindle {
      pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
      preserve_split = yes # you probably want this
  }

  master {
      new_is_master = true
  }

  gestures {
      workspace_swipe = on
  }


  # Example windowrule v1
  # windowrule = float, ^(kitty)$
  # Example windowrule v2
  # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
  # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more

  $mainMod = SUPER

  # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
  bind = $mainMod, RETURN,         exec, alacritty
  bind = $mainMod,      Q,               killactive
  bind = $mainMod,    TAB,         exec, alacritty -e ranger
  bind = $mainMod   SHIFT, RETURN, exec, wofi --show drun --gtk-dark --allow-images
  bind = $mainMod   SHIFT,      Q,       exit
  bind = $mainMod,  SPACE,               togglefloating
  bind = $mainMod,      F,               fullscreen

  bind = $mainMod, F1, exec, chromium-browser

  # bind = $mainMod, P, pseudo, # dwindle
  # bind = $mainMod, J, togglesplit, # dwindle

  # Move focus with mainMod + arrow keys
  bind = $mainMod,  left, movefocus, l
  bind = $mainMod, right, movefocus, r
  bind = $mainMod,    up, movefocus, u
  bind = $mainMod,  down, movefocus, d

  # Move focus with mainMod + arrow keys
  bind = $mainMod, L, movefocus, l
  bind = $mainMod, H, movefocus, r
  bind = $mainMod, K, movefocus, u
  bind = $mainMod, J, movefocus, d

  # Switch workspaces with mainMod + [0-9]
  bind = $mainMod, 1, workspace, 1
  bind = $mainMod, 2, workspace, 2
  bind = $mainMod, 3, workspace, 3
  bind = $mainMod, 4, workspace, 4
  bind = $mainMod, 5, workspace, 5
  bind = $mainMod, 6, workspace, 6
  bind = $mainMod, 7, workspace, 7
  bind = $mainMod, 8, workspace, 8
  bind = $mainMod, 9, workspace, 9
  bind = $mainMod, 0, workspace, 10

  # Move active window to a workspace with mainMod + SHIFT + [0-9]
  bind = $mainMod SHIFT, 1, movetoworkspace, 1
  bind = $mainMod SHIFT, 2, movetoworkspace, 2
  bind = $mainMod SHIFT, 3, movetoworkspace, 3
  bind = $mainMod SHIFT, 4, movetoworkspace, 4
  bind = $mainMod SHIFT, 5, movetoworkspace, 5
  bind = $mainMod SHIFT, 6, movetoworkspace, 6
  bind = $mainMod SHIFT, 7, movetoworkspace, 7
  bind = $mainMod SHIFT, 8, movetoworkspace, 8
  bind = $mainMod SHIFT, 9, movetoworkspace, 9
  bind = $mainMod SHIFT, 0, movetoworkspace, 10

  # Scroll through existing workspaces with mainMod + scroll
  bind = $mainMod, mouse_down, workspace, e+1
  bind = $mainMod, mouse_up, workspace, e-1

  # Move/resize windows with mainMod + LMB/RMB and dragging
  bindm = $mainMod, mouse:272, movewindow
  bindm = $mainMod, mouse:273, resizewindow

  # Media Control
  bind=,XF86AudioNext,exec,playerctl next
  bind=,XF86AudioPrev,exec,playerctl previous
  bind=,XF86AudioPlay,exec,playerctl play-pause
  bind=ALT,XF86AudioNext,exec,playerctld shift
  bind=ALT,XF86AudioPrev,exec,playerctld unshift
  bind=ALT,XF86AudioPlay,exec,systemctl --user restart playerctld

  # Screenshots
  bind=,Print,exec,grimblast --notify copy output
  bind=SHIFT,Print,exec,grimblast --notify copy active
  bind=CONTROL,Print,exec,grimblast --notify copy screen
  bind=SUPER,Print,exec,grimblast --notify copy window
  bind=ALT,Print,exec,grimblast --notify copy area

  # Audio
  bind=,XF86AudioRaiseVolume,exec,pactl set-sink-volume @DEFAULT_SINK@ +5%
  bind=,XF86AudioLowerVolume,exec,pactl set-sink-volume @DEFAULT_SINK@ -5%
  bind=,XF86AudioMute,exec,pactl set-sink-mute @DEFAULT_SINK@ toggle

  # Brightness
  bind=,XF86MonBrightnessUp,exec,light -A 10
  bind=,XF86MonBrightnessDown,exec,light -U 10


  bind = $mainMod, P, exec, pass-wofi --gtk-dark
''
