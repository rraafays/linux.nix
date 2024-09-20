{ pkgs, ... }:

{
  sound.enable = true;
  hardware.firmware = [ pkgs.sof-firmware ];
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    extraConfig = {
      pipewire."92-low-latency" = {
        context.properties = {
          default.clock.rate = 48000;
          default.clock.quantum = 32;
          default.clock.min-quantum = 32;
          default.clock.max-quantum = 32;
        };
      };
      pipewire-pulse."92-low-latency" = {
        context.modules = [
          {
            name = "libpipewire-module-protocol-pulse";
            args = {
              pulse.min.req = "32/48000";
              pulse.default.req = "32/48000";
              pulse.max.req = "32/48000";
              pulse.min.quantum = "32/48000";
              pulse.max.quantum = "32/48000";
            };
          }
        ];
        stream.properties = {
          node.latency = "32/48000";
          resample.quality = 1;
        };
      };
    };
  };

  environment.etc."wireplumber/wireplumber.conf.d/50-alsa-config.conf".text = ''
    monitor.alsa.rules = [
      {
        matches = [
          {
            node.name = "~alsa_output.*"
          }
        ]
        actions = {
          update-props = {
            api.alsa.period-size   = 1024
            api.alsa.headroom      = 8192
          }
        }
      }
    ]
  '';
}
