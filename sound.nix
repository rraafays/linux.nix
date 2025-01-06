{ pkgs, ... }:

{
  services.pipewire.enable = false;
  hardware = {
    firmware = [ pkgs.sof-firmware ];
    pulseaudio = {
      enable = true;
      extraConfig = "load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1";
    };
  };
}
