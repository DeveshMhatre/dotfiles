{
  description = "My NixOS Flake Configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    disko,
    home-manager,
    ...
  } @ inputs: {
    nixosConfigurations = {
      itnava = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ({pkgs, ...}: {
            nixpkgs.overlays = [
              (final: prev: {
                unstable = import nixpkgs-unstable {
                  system = prev.system;
                  config.allowUnfree = true;
                };
                pi-coding-agent = final.unstable.pi-coding-agent;
                direnv = final.unstable.direnv;
                nix-direnv = final.unstable.direnv;
              })
            ];
          })
          /etc/nixos/hardware-configuration.nix
          ./configuration.nix
          disko.nixosModules.disko
          ./disko-config.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.dev = ./home.nix;
              backupFileExtension = "backup";
            };
          }
        ];
      };
    };
  };
}
