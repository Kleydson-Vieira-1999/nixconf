{ self, inputs, ... }: {

  flake.nixosModules.developPackage = { config, pkgs, lib, ... }: {
    environment.systemPackages = with pkgs; [
      vim
      vscode
      zed-editor

      insomnia
      nerd-fonts.fira-code

      # google-cloud-sdk
    ];
  };

}
