{ pkgs, ... }:

{
  hardware.firmware = [ pkgs.sof-firmware ];
  services.pipewire = {
    enable = true;
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
