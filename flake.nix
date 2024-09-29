{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };
  outputs = { self, nixpkgs,  ... }: 
    let
      lib = nixpkgs.lib;
      importAll = paths: # Imports a list of both of nix files and folders, importing all nix files within the folders automatically. Non-recursive.
      lib.concatMap
      (
        path:
        if lib.pathIsDirectory path
        then map
          ( file: path + "/${file}" )
          (
            lib.attrNames
            (
              lib.filterAttrs
              (
                name: type:
                lib.hasSuffix ".nix" name
                && type == "regular"
              )
              ( builtins.readDir path )
            )
          )

        else if lib.pathIsRegularFile path && lib.hasSuffix ".nix" path
        then lib.singleton path
        else []
  )
  paths;
    in
    {
    # replace 'joes-desktop' with your hostname here.
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = importAll [ 
        ./configuration.nix
        ./modules/programs
      ];
    };
  };

}
