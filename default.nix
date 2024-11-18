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
    openssh.enable = true; # remote access via SSH
    fwupd.enable = true; # firmware updater
    udisks2.enable = true; # disk management & automatic mounting
    preload.enable = true; # preload to improve application startup time
    earlyoom.enable = true; # kill processes when memory is low
    ananicy.enable = true; # automatic process priority management
    fstrim.enable = true; # trim unused blocks on a mounted filesystem
    logrotate.enable = true; # manage and rotate log files
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
}
