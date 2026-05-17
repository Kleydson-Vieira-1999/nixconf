{ ... }: {

  flake.nixosModules.developPackage = { pkgs, ... }: {

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
