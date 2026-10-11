{ self, inputs, config, ... }:
let
  user = config.my.user;
in
{

  perSystem =  { pkgs, system, ... }: {

    packages.myBtop = inputs.wrapper-modules.wrappers.btop.wrap {
      inherit pkgs;

      package = pkgs.btop;

      settings = {
        
        color_theme = "${user.home}/.config/btop/themes/noctalia.theme";

      };
    };

  };
}