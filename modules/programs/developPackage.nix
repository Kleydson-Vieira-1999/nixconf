{ ... }: {

  flake.nixosModules.developPackage = { pkgs, ... }: {

    programs.tmux = {
      enable = true;
      clock24 = true;
      keyMode = "vi";
    };

    environment.systemPackages = with pkgs; [
      vim
      vscode
      zed-editor

      nixd # for lsp 
      nil # for lsp
      nixpkgs-fmt # for lsp

      insomnia
      nerd-fonts.fira-code

      # google-cloud-sdk
    ];
  };

}
