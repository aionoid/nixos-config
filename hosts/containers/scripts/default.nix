{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "sstart" (builtins.readFile ./start.sh))
    (writeShellScriptBin "sstop" (builtins.readFile ./stop.sh))
    (writeShellScriptBin "sclear" (builtins.readFile ./clear.sh))
  ];
}
