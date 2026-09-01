{lib, ...}: let
  notifycmd = "notify-send -h string:x-canonical-private-synchronous:hypr-cfg -u low";
  term = "terminal";
  screenshot = "rofi_screenshot";
  lockscreen = "hyprlock";
  colorpicker = "colorpicker";
  files = "nemo";
  editor = "nvim";
  browser = "zen-beta";
  rofi_emoji = "rofi_emoji";
  rofi_launcher = "rofi_launcher";
  rofi_runner = "rofi_apps";
  rofi_music = "rofi_music";
  rofi_network = "rofi_network";
  rofi_powermenu = "rofi_powermenu";
  rofi_screenshot = "rofi_screenshot";
  rofi_volume = "rofi_volume";
  background_swap = "~/.config/hypr/scripts/background";
  waybar_themes = "~/.config/hypr/waybar/scripts/change-theme.sh";
  cheatsheet = "kitty --app-id='kitty-float' -t cheatsheet -e nvim ~/.config/hypr/cheatsheet.md";
in {
  wayland.windowManager.hyprland = {
    extraConfig = ''
      -- #-- Groups & Focus --
      hl.bind("SUPER + G", function()
          hl.dispatch(hl.dsp.group.toggle())
          hl.dispatch(hl.dsp.exec_cmd("${notifycmd} 'Toggled Group Mode'"))
      end)
      -- # hl.bind("SUPER + H", hl.dsp.group.change_active("b"))
      -- # hl.bind("SUPER + L", hl.dsp.group.change_active("f"))

      -- # -- Terminal --
      hl.bind("SUPER + RETURN", hl.dsp.exec_cmd("${term}"))
      hl.bind("SUPER + SHIFT + RETURN", hl.dsp.exec_cmd("${term} -f"))
      hl.bind("SUPER + ALT + RETURN", hl.dsp.exec_cmd("${term} -s"))
      hl.bind("SUPER + T", hl.dsp.exec_cmd("${term} -F"))

      -- # -- Apps --
      hl.bind("SUPER + N", hl.dsp.exec_cmd("${files}"))
      hl.bind("SUPER + SHIFT + E", hl.dsp.exec_cmd("${editor}"))
      hl.bind("SUPER + SHIFT + W", hl.dsp.exec_cmd("${browser}"))

      -- # -- Rofi Launchers --
      hl.bind("SUPER + D", hl.dsp.exec_cmd("${rofi_launcher}"))
      hl.bind("SUPER + R", hl.dsp.exec_cmd("${rofi_runner}"))
      hl.bind("SUPER + M", hl.dsp.exec_cmd("${rofi_music}"))
      hl.bind("SUPER + SHIFT + N", hl.dsp.exec_cmd("${rofi_network}"))
      hl.bind("SUPER + X", hl.dsp.exec_cmd("${rofi_powermenu}"))
      hl.bind("SUPER + A", hl.dsp.exec_cmd("${rofi_screenshot}"))
      hl.bind("SUPER + V", hl.dsp.exec_cmd("${rofi_volume}"))
      hl.bind("SUPER + E", hl.dsp.exec_cmd("${rofi_emoji}"))

      -- # -- Misc Tools --
      hl.bind("SUPER + P", hl.dsp.exec_cmd("${colorpicker}"))
      hl.bind("CTRL + ALT + L", hl.dsp.exec_cmd("${lockscreen}"))
      hl.bind("SUPER + SHIFT + B", hl.dsp.exec_cmd("${background_swap}"))
      hl.bind("SUPER + SHIFT + T", hl.dsp.exec_cmd("${waybar_themes}"))

      -- # -- Cheatsheet --
      hl.bind("SUPER + SHIFT + I", hl.dsp.exec_cmd("${cheatsheet}"))

      -- # -- Screenshots --
      hl.bind("PRINT", hl.dsp.exec_cmd("${screenshot} --now"))
      hl.bind("ALT + PRINT", hl.dsp.exec_cmd("${screenshot} --in5"))
      hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("${screenshot} --in10"))
      hl.bind("CTRL + PRINT", hl.dsp.exec_cmd("${screenshot} --win"))
      hl.bind("SUPER + PRINT", hl.dsp.exec_cmd("${screenshot} --area"))

      -- # -- Hyprland Control Actions --
      hl.bind("SUPER + Q", hl.dsp.window.kill())
      hl.bind("SUPER + C", hl.dsp.window.kill())
      hl.bind("CTRL + ALT + DELETE", hl.dsp.exit())

      hl.bind("SUPER + F", function()
          hl.dispatch(hl.dsp.window.fullscreen())
          hl.dispatch(hl.dsp.exec_cmd("${notifycmd} 'Fullscreen Mode'"))
      end)

      hl.bind("SUPER + S", function()
          hl.dispatch(hl.dsp.window.pseudo())
          hl.dispatch(hl.dsp.exec_cmd("${notifycmd} 'Pseudo Mode'"))
      end)

      -- # Toggle float <-> tile for the focused window
      hl.bind("SUPER + SPACE", hl.dsp.window.float())

      -- # Mouse: drag / resize windows while holding SUPER (bindm equivalents)
      hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { drag = true })
      hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { drag = true })
    '';
  };
}
