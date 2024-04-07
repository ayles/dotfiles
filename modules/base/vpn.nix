{ myvars, config, pkgs, lib, ... }:
{
  services.openvpn.servers = {
    butter = {
      config = ''
        config /home/${myvars.user}/.openvpn/butter.conf
        connect-retry 15
      '';
      autoStart = false;
    };
  };
}
