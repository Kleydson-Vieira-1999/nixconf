{ self, inputs, ... }: {

  flake.nixosModules.defaultPrograms = { config, pkgs, lib, ... }: {

    imports = [
      self.nixosModules.myWf-recoder
      self.nixosModules.zen
      self.nixosModules.developPackage
    ];
    
    environment.systemPackages = with pkgs; [

      self.packages.${stdenv.hostPlatform.system}.myTerminalKitty
      self.packages.${stdenv.hostPlatform.system}.myBtop
      self.packages.${stdenv.hostPlatform.system}.myGit
    ];

  };

}
