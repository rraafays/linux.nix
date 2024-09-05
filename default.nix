{ pkgs, ... }:

{
  system.autoUpgrade = {
    enable = true;
    persistent = true;
    allowReboot = false;
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

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };


  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    input.General.ClassicBondedOnly = false;
    input.General.UserspaceHID = true;
  };

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  programs.fish.enable = true;
  programs.starship.enable = true;
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

  services.postgresql = {
    enable = true;
    authentication =
      pkgs.lib.mkOverride 10 ''
        local all all              trust
        host  all all 127.0.0.1/32 trust
        host  all all ::1/128      trust
      '';
  };

  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  services.fwupd.enable = true;
  services.power-profiles-daemon.enable = true;
}
