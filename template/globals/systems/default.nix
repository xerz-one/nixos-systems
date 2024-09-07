args@{
  config,
  lib,
  pkgs,
  ...
}:

with builtins // lib;

{
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  fileSystems."/tmp" = {
    fsType = "tmpfs";
    device = "tmpfs";
    options = [
      "nosuid"
      "nodev"
    ];
  };

  environment.systemPackages = with pkgs; [
    sbctl

    psmisc
    file
    lsof
    inetutils
    git
    nano
  ];
}
