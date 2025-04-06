{
  lib,
  pkgs,
  isHome,
  ...
}: {
  services.open-webui = let
    # pkgs.overlays = [
    #   (final: prev: {
    #     pythonPackagesExtensions =
    #       prev.pythonPackagesExtensions
    #       ++ [
    #         (
    #           python-final: python-prev: {
    #             onnxruntime = python-prev.onnxruntime.overridePythonAttrs (
    #               oldAttrs: {
    #                 buildInputs = lib.lists.remove pkgs.onnxruntime oldAttrs.buildInputs;
    #               }
    #             );
    #           }
    #         )
    #       ];
    #   })
    # ];
  in {
    enable =
      if isHome
      then false
      else true;
    # openFirewall = true;
  };
}
