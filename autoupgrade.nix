{ ... }:

{
  system.autoUpgrade = {
    enable = true;
    persistent = true;
    allowReboot = false;
    randomizedDelaySec = "0";
    operation = "boot";
    dates = "20:00";
  };
}
