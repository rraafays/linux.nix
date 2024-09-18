{ ... }:

{
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
}
