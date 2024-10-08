{pkgs, ...}: {
  environment.systemPackages = with pkgs; #SDDM
  
    [
      (catppuccin-sddm.override
        {
          flavor = "mocha";
          background = "${pkgs.gnome-backgrounds}/share/backgrounds/gnome/morphogenesis-d.svg";
          loginBackground = true;
        })
    ];
  #SDDM
  services.displayManager.sddm = {
    wayland.enable = true;
    enable = true;
    autoNumlock = true;
    # settings.Theme.Current = "catppuccin-mocha";
    theme = "catppuccin-mocha";
    package = pkgs.kdePackages.sddm;
  };
}
