{...}: {
  imports = [./home.nix];
  # username
  home = {
    username = "antiroot";
    homeDirectory = "/home/antiroot";
  };
}
