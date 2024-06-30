{ myvars, ... }:
{
  security.sudo.wheelNeedsPassword = false;

  # TODO
  # users.mutableUsers = false;

  users.users.${myvars.user} = {
    isNormalUser = true;
    extraGroups = [
      "docker"
      "input"
      "networkmanager"
      "wheel"
    ];
  };
}
