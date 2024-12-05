{
  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
  };

  outputs =
    { systems, nixpkgs, ... }@inputs:
    let
      eachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f nixpkgs.legacyPackages.${system});
    in
    {
      devShells = eachSystem (pkgs: {
        default = pkgs.mkShell {
          buildInputs = [


            # You can set the major version of Node.js to a specific one instead
            # of the default version
            # pkgs.nodejs-22_x

            # Comment out one of these to use an alternative package manager.
            # pkgs.yarn
            # pkgs.pnpm
            # pkgs.bun


            pkgs.nodePackages.typescript
            pkgs.nodePackages.typescript-language-server
            pkgs.kubectl
            pkgs.kubectx
            # pkgs.kafkacat
            pkgs.curl
            pkgs.git
            pkgs.docker
            pkgs.vim
            pkgs.fzf
            pkgs.jq
            pkgs.yq
            pkgs.coreutils
            pkgs.ripgrep
            pkgs.postgresql
            pkgs.netcat
            pkgs.inetutils
            pkgs.tmux
            pkgs.screen
            pkgs.github-cli
            pkgs.act
            pkgs.direnv
            pkgs.tailscale
            pkgs.angle-grinder
            pkgs.redis
            pkgs.zsh

            pkgs.nodejs-18_x
            # pkgs.pulumi-bin
            pkgs.pnpm

            pkgs.python3
                        # (pkgs.callPackage ({ fetchFromGitHub, buildGoModule }: buildGoModule {
                        #   pname = "gmh-cli";
                        #   version = "latest";
                        #   src = fetchFromGitHub {
                        #     owner = "gemhome";
                        #     repo = "gmh-cli";
                        #     rev = "main";
                        #     sha256 = "sha256-1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef";
                        #   };
                        #   vendorSha256 = null;
                        # }) {})
          ];

          shellHook = ''
              export AWS_CONFIG_FILE=
          '';
        };
      });
    };

}
