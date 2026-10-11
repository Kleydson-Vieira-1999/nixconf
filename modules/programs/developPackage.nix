{ self, inputs, ... }: {

  flake.nixosModules.developPackage = { pkgs, ... }: {

    programs.tmux = {
      enable = true;
      clock24 = true;
      keyMode = "vi";
    };

    users.users.doctor.extraGroups = [ "dialout" ];

    environment.systemPackages = with pkgs; [
      vim
      vscode-fhs
      insomnia
      nerd-fonts.fira-code

      nixd # for lsp 
      nil # for lsp
      nixpkgs-fmt # for lsp

      zed-editor

      # go stack
      go
      gopls
      delve

      nodejs_24

      gcc
      gdb
      gnumake

      arduino-cli
      avrdude


      google-cloud-sdk
      gemini-cli

      inputs.antigravity-nix.packages."${pkgs.stdenv.hostPlatform.system}".default
      inputs.antigravity-nix.packages."${pkgs.stdenv.hostPlatform.system}".google-antigravity-ide
      inputs.antigravity-nix.packages."${pkgs.stdenv.hostPlatform.system}".google-antigravity-cli
    ];
  };

}
