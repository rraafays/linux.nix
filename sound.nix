{ pkgs, ... }:

{
  hardware.firmware = [ pkgs.sof-firmware ];
  services.pipewire = {
    enable = false;
    extraConfig = {
      pipewire."92-low-latency" = {
        "context.properties" = {
          "default.clock.rate" = 96000;
          "default.clock.quantum" = 1024;
          "default.clock.min-quantum" = 1024;
          "default.clock.max-quantum" = 1024;
        };
      };

      pipewire-pulse."92-low-latency" = {
        "context.properties" = [
          {
            name = "libpipewire-module-protocol-pulse";
            args = { };
          }
        ];
        "pulse.properties" = {
          "pulse.min.req" = "1024/96000";
          "pulse.default.req" = "1024/96000";
          "pulse.max.req" = "1024/96000";
          "pulse.min.quantum" = "1024/96000";
          "pulse.max.quantum" = "1024/96000";
        };
        "stream.properties" = {
          "node.latency" = "1024/96000";
          "resample.quality" = 1;
        };
      };
    };

    wireplumber.extraConfig."99-disable-suspend" = {
      "monitor.alsa.rules" = [
        {
          matches = [
            {
              "node.name" = "alsa_output.usb-ASUSTeK_Xonar_SoundCard-00.iec958-stereo";
            }
          ];
          actions = {
            update-props = {
              "session.suspend-timeout-seconds" = 0;
            };
          };
        }
      ];
    };
  };
}
