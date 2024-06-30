{ ... }:
{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;

    extraConfig = {
      pipewire."92-low-latency" = {
        context.properties = {
          default.clock.rate = 192000;
        };
      };
      pipewire-pulse."92-low-latency" = {
        stream.properties = {
          resample.quality = 15;
        };
      };
      client."92-low-latency" = {
        stream.properties = {
          resample.quality = 15;
        };
      };
      client-rt."92-low-latency" = {
        stream.properties = {
          resample.quality = 15;
        };
      };
    };
  };

  security.rtkit.enable = true;
}
