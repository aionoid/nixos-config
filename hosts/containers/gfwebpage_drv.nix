{pkgs ? import <nixpkgs> {}}:
with pkgs; {
  source-code = stdenv.mkDerivation {
    name = "gf-webapp-php";

    # src = "/home/ovo/Documents/gf_server/_utils/web/";
    src = ./web;

    phases = ["installPhase"];
    installPhase = ''
      cp -r $src $out
    '';
  };
}
