{ ... }:

{
  hardware = {
    uinput.enable = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      input.General.ClassicBondedOnly = false;
      input.General.UserspaceHID = true;
    };
  };
}
