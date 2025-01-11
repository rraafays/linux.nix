{ pkgs, ... }:

{
  services.pipewire.enable = true;
  hardware.firmware = [ pkgs.sof-firmware ];
}
