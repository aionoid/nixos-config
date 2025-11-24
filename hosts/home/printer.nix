{pkgs, ...}: {
  services.printing = {
    enable = true;
    drivers = [
      pkgs.canon-capt
      pkgs.hplip
    ];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  hardware.printers = {
    ensureDefaultPrinter = "LBP2900";
    ensurePrinters = [
      {
        name = "LBP2900";
        location = "Home";
        deviceUri = "usb://Canon/LBP2900?serial=0000A382NGVr";
        model = "canon/CanonLBP-2900-3000.ppd";
        ppdOptions = {
          PageSize = "A4";
        };
      }
    ];
  };
}
