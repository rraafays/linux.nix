{ pkgs, ... }:

{
  system.autoUpgrade = {
    enable = true;
    persistent = true;
    allowReboot = true;
    randomizedDelaySec = "0";
    dates = "12:00";
  };

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

  security.sudo = {
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

  hardware.uinput.enable = true;
  services.udev.packages = with pkgs; [
    game-devices-udev-rules
  ];

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  programs.fish.enable = true;
  programs.command-not-found.enable = true;
  programs.starship.enable = true;
  programs.steam.enable = true;
  users.defaultUserShell = pkgs.fish;
  services.getty.autologinUser = "raf";
  services.udisks2.enable = true;
  users.users.raf = {
    isNormalUser = true;
    description = "raf";
    extraGroups = [
      "networkmanager"
      "wheel"
      "input"
      "docker"
    ];
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    zlib
    fuse3
    icu
    zlib
    nss
    openssl
    curl
    expat
    SDL2
  ];
}
