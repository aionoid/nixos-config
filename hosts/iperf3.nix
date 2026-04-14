# tool for testing local network test
{...}: {
  services.iperf3 = {
    enable = true;
    openFirewall = true;
  };
}
