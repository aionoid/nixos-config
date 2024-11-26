{...}: {
  programs.ncmpcpp.enable = true;
  # run 'mpc update' after adding files to
  # ~/Music the default location
  services.mpd = {
    enable = true;
    network.listenAddress = "any"; # if you want to allow non-localhost connections
    network.startWhenNeeded = true;
  };
}
