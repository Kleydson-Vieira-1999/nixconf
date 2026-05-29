{ self, inputs, ...}: {

  flake.nixosModules.gnome = { pkgs, ... }: {

    environment.systemPackages = with pkgs; [
      gnomeExtensions.desktop-cube
      gnome-extension-manager
      gnomeExtensions.coverflow-alt-tab
      gnomeExtensions.blur-my-shell
    ];

    
  };

}