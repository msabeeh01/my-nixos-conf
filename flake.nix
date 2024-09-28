{
  description = "A very basic flake";

  #essentially nix-channels
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
};

    hyprland.url = "github:hyprwm/Hyprland";
    
};

  outputs = { self, nixpkgs,  ... }@inputs:
    let
       system = "x86_64-linux";
       pkgs = nixpkgs.legacyPackages.${system};
    in
{
   	nixosConfigurations = {
		nixos =  nixpkgs.lib.nixosSystem {
			specialArgs = {inherit inputs;};
      			modules = [
        			# Import the previous configuration.nix we used,
        			# so the old configuration file still takes effect
        			./hosts/nixos/configuration.nix
				inputs.home-manager.nixosModules.default
      			];
    		};
	};
  };
}
