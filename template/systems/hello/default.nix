{ root, inputs }:

let
  lib = inputs.nixpkgs.lib;
in
with inputs // builtins // lib;

{
  pkgs = import nixpkgs { system = "x86_64-linux"; };
  modules = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }:
      {
        fileSystems."/" = {
          device = "LABEL=NixOS";
          fsType = "xfs";
        };
        fileSystems."/boot" = {
          device = "LABEL=ESP";
          fsType = "vfat";
          options = [
            "fmask=0077"
            "dmask=0077"
            "defaults"
          ];
        };

        services.getty = {
          greetingLine = "hello there~!";
          autologinUser = "root";
        };

        environment.systemPackages = with pkgs; [ hello ];

        system.stateVersion = "24.05";
      }
    )
  ];
}
