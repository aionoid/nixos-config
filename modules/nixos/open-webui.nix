{isHome, ...}: {
  services.open-webui = {
    enable =
      if isHome
      then true
      else false;
    # openFirewall = true;
  };
}
