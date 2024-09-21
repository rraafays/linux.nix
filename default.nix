{ pkgs, ... }:

{
  imports = [
    ./colours.nix
    ./bluetooth.nix
    ./sudo.nix
    ./sound.nix
    ./shell.nix
  ];

  nix = {
    optimise = {
      dates = [ "daily" ];
      automatic = true;
    };
    gc = {
      dates = "daily";
      options = "--delete-older-than 5d";
      automatic = true;
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  system.autoUpgrade = {
    enable = true;
    persistent = true;
    allowReboot = false;
    randomizedDelaySec = "0";
    operation = "boot";
    dates = "12:00";
  };

  boot = {
    kernelModules = [
      "usbhid"
      "uinput"
      "joydev"
    ];
    kernelParams = [
      "quiet"
      "threadirqs"
      "pci=realloc"
    ];
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        consoleMode = "max";
        configurationLimit = 20;
      };
    };
    supportedFilesystems = [ "ntfs" ];
  };

  services = {
    openssh.enable = true;
    fwupd.enable = true;
    udisks2.enable = true;
    preload.enable = true;
    earlyoom.enable = true;
    ananicy.enable = true;
    fstrim.enable = true;
    logrotate.enable = true;
  };

  security = {
    pki.certificateFiles = [ "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt" ];
    rtkit.enable = true;
  };
}
