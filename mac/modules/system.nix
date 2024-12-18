{
  system = {
    stateVersion = 5;

    # activationScripts are executed every time you boot the system or run `nixos-rebuild` / `darwin-rebuild`.
    activationScripts.postUserActivation.text = ''
            # activateSettings -u will reload the settings from the database and apply them to the current session,
            # so we do not need to logout and login again to make the changes take effect.
            /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
      		'';

    # Set Git commit hash for darwin-version.
    # configurationRevision = self.rev or self.dirtyRev or null;

    defaults = {
      menuExtraClock.Show24Hour = true; # show 24 hour clock

      # com.apple.HIToolbox AppleFnUsageType -int "2"
      com.apple.HIToolbox.AppleFnUsageType = 2;

     	# F keys normal
    	# defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true
      com.apple.keyboard.fnState = true;

      # keyboard delays to second-fastest settings
      # defaults write NSGlobalDomain InitialKeyRepeat -int 25
      # defaults write NSGlobalDomain KeyRepeat -int 2
      InitialKeyRepeat = 25;
      KeyRepeat = 2;
    };
  };

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  # this is required if you want to use darwin's default shell - zsh
  programs.zsh.enable = true;
}
