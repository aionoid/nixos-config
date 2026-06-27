{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    onlyoffice-desktopeditors
    # libreoffice-qt
    # hunspell
    # hunspellDicts.uk_UA
    # hunspellDicts.th_TH
  ];
}
