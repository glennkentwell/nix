{ pkgs, ... }:

{
  nix.settings = {

    # enable flakes globally
    experimental-features = [ "nix-command" "flakes" ];

    # substitutions
    #	substituters = [
    #		"https://mirror.sjtu.edu.cn/nix-channels/store"
    #    "https://nix-community.cachix.org"
    #	];
    #  trusted-public-keys = [
    #    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    #  ];
    #	builders-use-substitutes = true;
  };

  # auto upgrade nix package and daemon service
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;
  nixpkgs.config.allowUnfree = true;
}
