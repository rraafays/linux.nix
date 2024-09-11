{ pkgs, ... }:

{
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
    dates = "12:00";
  };

  boot = {
    kernelModules = [ "cpufreq_ondemand" ];
    kernelParams = [
      "quiet"
      "threadirqs"
      "usbhid"
      "uinput"
      "joydev"
      "mitigations=off"
      "smt=on"
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

  sound.enable = true;
  services = {
    openssh.enable = true;
    fwupd.enable = true;
    udev.packages = with pkgs; [ game-devices-udev-rules ];
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
    udisks2.enable = true;
  };

  security = {
    rtkit.enable = true;
    sudo = {
      enable = true;
      execWheelOnly = true;
      wheelNeedsPassword = true;
      extraConfig = ''
        Defaults pwfeedback
        Defaults timestamp_timeout = 0
        Defaults lecture = always
        Defaults passprompt = "> "
      '';
    };
  };

  hardware = {
    uinput.enable = true;
    pulseaudio.enable = false;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      input.General.ClassicBondedOnly = false;
      input.General.UserspaceHID = true;
    };
  };

  programs = {
    fish.enable = true;
    starship.enable = true;
    steam = {
      enable = true;
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
    };
  };

  console.colors = [
    "000000"
    "cc241d"
    "98971a"
    "d79921"
    "458588"
    "b16286"
    "689d6a"
    "a89984"
    "928374"
    "fb4934"
    "b8bb26"
    "fabd2f"
    "83a598"
    "d3869b"
    "8ec07c"
    "ebdbb2"
  ];
}
