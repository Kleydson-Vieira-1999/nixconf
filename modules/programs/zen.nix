{ self, inputs, ... }: {

  flake.nixosModules.zen = { pkgs, lib, ... }: {

    environment.systemPackages = [
      inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
    ];

  };

}