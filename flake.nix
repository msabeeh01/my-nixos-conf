{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #TODO:no idea what this does, checkout the github page and remove if requried
nix-ld.url = "github:Mic92/nix-ld"; 
 nix-ld.inputs.nixpkgs.follows = "nixpkgs";
};
  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      nix-ld,
      ...
    }:
    #this let/in statement is only if you want to do something like /modules/steam.nix or /modules/firefox.nvim and is not required
    let
      lib = nixpkgs.lib;
      importAll =
        paths: # Imports a list of both of nix files and folders, importing all nix files within the folders automatically. Non-recursive.
        lib.concatMap (
          path:
          if lib.pathIsDirectory path then
            map (file: path + "/${file}") (
              lib.attrNames (
                lib.filterAttrs (name: type: lib.hasSuffix ".nix" name && type == "regular") (builtins.readDir path)
              )
            )

          else if lib.pathIsRegularFile path && lib.hasSuffix ".nix" path then
            lib.singleton path
          else
            [ ]
        ) paths;
    in
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
	  nix-ld.nixosModules.nix-ld

          #home-manager
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.sabeeh = import ./home.nix;
            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];
      };
    };

}
