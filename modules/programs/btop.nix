{ self, inputs, ... }: {

  perSystem =  { pkgs, system, ... }: {

    packages.myBtop = inputs.wrapper-modules.wrappers.btop.wrap {
      inherit pkgs;

      package = pkgs.btop;

      settings = {
        
        color_theme = "/home/doctor/.config/btop/themes/noctalia.theme";

      };
    };

  };
}