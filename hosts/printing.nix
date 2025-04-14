{pkgs, ...}: {
  services.printing = {
    enable = true;
    drivers = [
      pkgs.canon-capt
    ];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  hardware.printers = {
    ensureDefaultPrinter = "LBP6000";
    ensurePrinters = [
      {
        name = "LBP6000";
        location = "Home";
        deviceUri = "usb://Canon/LBP6000/LBP6018?serial=0000B3B438Ze";
        model = "canon/CanonLBP-3010-3018-3050.ppd";
        ppdOptions = {
          PageSize = "A4";
        };
      }
    ];
  };
}
