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
    operation = "boot";
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

  sound.enable = true;
  services = {
    pipewire = {
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
    openssh.enable = true;
    fwupd.enable = true;
    udev.packages = with pkgs; [ game-devices-udev-rules ];
    udisks2.enable = true;
  };

  security = {
    pki.certificateFiles = [ "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt" ];
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
