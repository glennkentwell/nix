{
  description = "Example Darwin system flake";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-darwin.url = "github:LnL7/nix-darwin";
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs-darwin, darwin, nixpkgs, nix-homebrew
    , homebrew-core, homebrew-cask }:
    let
      username = "glenn";
      system = "aarch64-darwin"; # or x86_64_darwin
      hostname = "dabble-K4QRVMFV4H";

      specialArgs = inputs // { inherit username hostname; };
    in {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#g3k
      # darwinConfigurations."${hostname}" = darwin.lib.darwinSystem {
			darwinConfigurations.dabble-K4QRVMFV4H = darwin.lib.darwinSystem {
        inherit system specialArgs;
        modules = [
          ./modules/nix-core.nix
          ./modules/system.nix
          ./modules/apps.nix

          # ./modules/host-users.nix

          # home-manager.darwin-modules.home-manager
          # {
          #	home-manager.useGlobalPkgs = true;
          #	home-manager.useUserPackages = true;
          #	home-manager.users.glenn = import ./home.nix
          #};
        ];
      };

      # Expose the package set, including overlays, for convenience.
      # darwinPackages = self.darwinConfigurations."$hostname".pkgs;
      darwinPackages.buggery = self.darwinConfigurations.dabble-K4QRVMFV4H.pkgs;
    };
}
