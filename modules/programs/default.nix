{ self, inputs, ... }: {

  flake.nixosModules.defaultPrograms = { pkgs, ... }: {

    imports = [
      self.nixosModules.myWf-recoder
      self.nixosModules.zen
      self.nixosModules.developPackage
    ];
    
    environment.systemPackages = with pkgs; [
      obs-studio

      self.packages.${stdenv.hostPlatform.system}.myTerminalKitty
      self.packages.${stdenv.hostPlatform.system}.myBtop
      self.packages.${stdenv.hostPlatform.system}.myGit
    ];

  };

}
