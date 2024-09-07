{ nixpkgs }:

let
  lib = nixpkgs.lib;
in
with builtins // lib;

rec {
  recursiveMerge =
    attrs:
    zipAttrsWith (
      n: values:
      if tail values == [ ] then
        head values
      else if all isList values then
        unique (concatLists values)
      else if all isAttrs values then
        f [ n ] values
      else
        last values
    ) attrs;

  forAllSystems = f: genAttrs systems.flakeExposed (system: f system);

  mkNixosConfig =
    {
      name,
      root,
      inputs ? null,
      extraModules ? [ ],
    }:
    recursiveMerge [
      {
        modules =
          let
            globals = "${root}/globals/systems";
          in
          (if pathIsDirectory globals then [ globals ] else [ ]) ++ extraModules;
      }
      (import "${root}/systems/${name}" { inherit root inputs; })
    ]
    |> nixosSystem;

  mapNamed =
    f: list:
    map (x: {
      name = x.name;
      value = f x;
    }) list
    |> listToAttrs;

  mkNixosConfigs = configs: mapNamed mkNixosConfig configs;

  listDirs = path: readDir path |> filterAttrs (name: type: type == "directory") |> attrNames;
  getNixosSystems = listDirs;
}
