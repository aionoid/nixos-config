{pkgs, ...}: let
  # Elements
  hypr_border_size = 2;
  # hypr_gaps_in = 5;
  # hypr_gaps_out = 10;
  # hypr_rounding = 10;
  #
  # # Colors
  # gradient_angle = 45deg;
  # active_border_col_1 = 0xFFB4A1DB;
  # active_border_col_2 = 0xFFD04E9D;
  # inactive_border_col_1 = 1e2030;
  # inactive_border_col_2 = 1e2030;
  # active_shadow_col = 0x66000000;
  # inactive_shadow_col = 0x66000000;
  # group_border_col = 0xFFDB695B;
  # group_border_active_col = 0xFF4BC66D;
  #
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${pkgs.gbar}/bin/gbar &
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.swww}/bin/swww init &

    sleep 1

  '';
in {
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      exec-once = ''${startupScript}/bin/start'';
    };
  };
}
