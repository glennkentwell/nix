{ inputs, pkgs, ... }: {

  # install packages from nix official nixpkgs
  environment.systemPackages = with pkgs; [
    git
    nil # nix language server
    nixfmt-rfc-style # https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-fmt#examples
		# nixfmt-classic

    jq
    xq
    just

    direnv

    kitty
    # jetbrains-toolbox
    discord
    slack
    google-chrome
    rectangle

    pulumi-bin

		node2nix
		pnpm
		dum
		typescript
		deno
		ezno
		rslint		# rust linter
		yamllint
		gh

    iterm2
		# sublime # not on aarch64

    tailscale

    kubectl
	  kubectl
	  kubectl-neat
	  kubectl-explore
    tubekit # but also: $ nix profile install github:reconquest/tubekit

  ];
  environment.extraInit = "export PATH=$HOME/bin:$PATH\n";
  environment.variables.EDITOR = "nvim";

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup =
        "zap"; # uninstalls all formulae not listed in generated Brewfile
    };

    masApps = { Xcode = 497799835; };

    # taps = [ "homebrew/services" ];

    brews = [
      # "wget"
      # "curl"
      # "httpie"
      # "aria"
      "jetbrains-toolbox"
    ];

    casks = [ ];
  };
}
