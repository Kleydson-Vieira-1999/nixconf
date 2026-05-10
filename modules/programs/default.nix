{ self, inputs, ... }: {

  flake.nixosModules.defaultPrograms = { config, pkgs, lib, ... }: {

    imports = [
      self.nixosModules.myWf-recoder
    ];

    environment.systemPackages = with pkgs; [
      vim
      vscode

      self.packages.${stdenv.hostPlatform.system}.myTerminalKitty
      self.packages.${stdenv.hostPlatform.system}.myBtop
      self.packages.${stdenv.hostPlatform.system}.myGit
    ];

  };

}