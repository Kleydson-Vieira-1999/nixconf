{ self, inputs, ... }: {

  flake.nixosModules.defaultFeatures = { config, pkgs, lib, ... }: {

    imports = [
      self.nixosModules.gnome
      self.nixosModules.niri
      self.nixosModules.myShell
      self.nixosModules.mySecurityConfig
      self.nixosModules.myVirtualisation
    ];
  };
}