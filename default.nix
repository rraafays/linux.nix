{ pkgs, ... }:

{
  imports = [
    ./autoupgrade.nix
    ./bluetooth.nix
    ./colours.nix
    ./shell.nix
    ./sound.nix
    ./sudo.nix
  ];

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

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };

  users = {
    groups.nixosvmtest = { };
    users.nixosvmtest = {
      isSystemUser = true;
      initialPassword = "password";
      group = "nixosvmtest";
    };
  };

  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 2048;
      cores = 3;
    };
  };
}
