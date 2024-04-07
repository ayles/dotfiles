{ config, pkgs, lib, ... }:
{
  # Windows dualboot compat
  time.hardwareClockInLocalTime = true;

  time.timeZone = "Europe/Moscow";

  i18n.defaultLocale = "en_US.UTF-8";
}
