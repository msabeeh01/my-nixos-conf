{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };
  outputs = { self, nixpkgs, ... }@inputs: {
    # replace 'joes-desktop' with your hostname here.
    myModules = import ./modules { inherit nixpkgs; };

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs; };
      system = "x86_64-linux";
      modules = [ 
        ./configuration.nix
        self.myModules
      ];
    };
  };
}
