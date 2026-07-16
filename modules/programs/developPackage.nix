{ self, inputs, ... }: {

  flake.nixosModules.developPackage = { pkgs, ... }: {

    programs.tmux = {
      enable = true;
      clock24 = true;
      keyMode = "vi";
    };

    environment.systemPackages = with pkgs; [
      vim
      vscode
      insomnia
      nerd-fonts.fira-code

      nixd # for lsp 
      nil # for lsp
      nixpkgs-fmt # for lsp

      zed-editor

      google-cloud-sdk
      gemini-cli
      inputs.antigravity-nix.packages."${pkgs.stdenv.hostPlatform.system}".default
      inputs.antigravity-nix.packages."${pkgs.stdenv.hostPlatform.system}".google-antigravity-ide
      inputs.antigravity-nix.packages."${pkgs.stdenv.hostPlatform.system}".google-antigravity-cli
    ];
  };

}
