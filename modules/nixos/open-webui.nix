{
  lib,
  pkgs,
  isHome,
  ...
}: {
  services.open-webui = let
    pkgs.overlays = [
      (final: prev: {
        python3Packages =
          prev.python3Packages
          ++ [
            (
              python-final: python-prev: {
                onnxruntime = python-prev.onnxruntime.overridePythonAttrs (
                  oldAttrs: {
                    buildInputs = lib.lists.remove pkgs.onnxruntime oldAttrs.buildInputs;
                  }
                );
              }
            )
          ];
      })
    ];
  in {
    enable =
      if isHome
      then true
      else true;
    # openFirewall = true;
  };
}
