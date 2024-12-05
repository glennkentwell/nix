{
  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
  };

  outputs =
    { self, systems, nixpkgs, ... }@inputs:
    let
      eachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f nixpkgs.legacyPackages.${system});
    in
    {
      packages = eachSystem (pkgs: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            # basic
            git
            vim
            fzf
            jq
            yq
            coreutils
            ripgrep
            tmux
            screen
            direnv
            zsh
            angle-grinder

            # net
            curl
            netcat
            inetutils
            nmap

            # db
            postgresql
            sqlite
            duckdb
            redis

            # k8s, container
            kubectl
            kubectx
            helmfile    # but https://nixos.wiki/wiki/Helm_and_Helmfile
            # helm-kubernetes-wrapped
            docker

            # node
            nodejs-18_x
            pnpm
            yarn
            bun
            deno
            nodePackages.typescript
            nodePackages.typescript-language-server

            # python
            python3
            pyenv

            #
            github-cli
            act
            tailscale
            # _1password-cli    # requires export NIXPKGS_ALLOW_UNFREE=1 and --impure

            pulumictl


                # pulumi-bin
                        # (callPackage ({ fetchFromGitHub, buildGoModule }: buildGoModule {
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
              export AWS_PROFILE=sandbox
              export AWS_REGION=ap-southeast-2
          '';
        };
      });
    };

}
