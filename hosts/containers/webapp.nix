{
  pkgs ? import <nixpkgs> {},
  game_name ? "'Dragonmon Hunters'",
  server_host ? "'10.233.1.2'",
  db_user ? "'postgres'",
  db_password ? "'password'",
  db_members ? "'gf_gs'",
  db_account ? "'gf_ls'",
  db_gateway ? "'gf_ms'",
  # login_port ? 6543,
}: {
  source-code = pkgs.stdenv.mkDerivation {
    name = "webapp-php";

    src = ./webapp;

    config_file = let
      inherit game_name;
      inherit server_host;
      inherit db_user;
      inherit db_password;
      inherit db_members;
      inherit db_account;
      inherit db_gateway;
      # inherit login_port;
    in
      pkgs.writeText "config.php"
      /*
      php
      */
      ''
        <?php
            $server_host = ${server_host};
            $db_user = ${db_user};
            $db_password = ${db_password};
            $game_name = ${game_name};

            $db_members = ${db_members};
            $db_account = ${db_account};
            $db_gateway = ${db_gateway};

            /*$login_port = $ {login_port};*/
            $login_port = 6543;

            $db_gs = pg_connect("host=$server_host dbname=$db_members user=$db_user password=$db_password");
            $db_ls = pg_connect("host=$server_host dbname=$db_account user=$db_user password=$db_password");
            $db_ms = pg_connect("host=$server_host dbname=$db_gateway user=$db_user password=$db_password");
        ?>
      '';

    phases = ["installPhase"];
    installPhase = ''
      mkdir $out
      cp $config_file $out/config.php
      cp -r $src/* $out
    '';
  };
}
