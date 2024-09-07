{
  description = "My comfy NixOS systems 🌨️";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs =
    inputs@{ self, nixpkgs, ... }:
    let
      lib = nixpkgs.lib // import ./lib { inherit nixpkgs; };
    in
    with builtins // lib;
    {
      inherit lib;

      nixosConfigurations =
        let
          root = ./.;
        in
        getNixosSystems "${root}/systems"
        |> map (x: {
          name = x;
          inherit root inputs;
        })
        |> mkNixosConfigs;
    };
}
