{ self, inputs, config, ... }:
let
  user = config.my.user;
in
{

  perSystem = { pkgs, lib, ... }: {
    packages.myTerminalKitty = inputs.wrapper-modules.wrappers.kitty.wrap {
      inherit pkgs;

      package = pkgs.kitty;

      settings = {
        enable_audio_bell = "no";

        font_family = "FiraCode Nerd Font Mono"; # fonts.packages em developPackage.nix
        font_size = 15;
        cursor_text_color = "background";

        allow_remote_control = "socket-only";
        listen_on = "unix:@kitty";
        # Cursor sempre em bloco: no-cursor impede a integração com o shell de trocar para barra
        shell_integration = "enabled no-cursor";
        cursor_shape = "block";

        cursor_trail = 3;

        shell = "${lib.getExe pkgs.zsh} --login";

        background_opacity = "0.85";
        dynamic_background_opacity = "yes";
      };

      keybindings = {
        "alt+1" = "goto_tab 1";
        "alt+2" = "goto_tab 2";
        "alt+3" = "goto_tab 3";
        "alt+4" = "goto_tab 4";
        "alt+5" = "goto_tab 5";
        "alt+6" = "goto_tab 6";
        "alt+7" = "goto_tab 7";
        "alt+8" = "goto_tab 8";
        "alt+9" = "goto_tab 9";
        "ctrl+shift+w" = "close_tab";
        "ctrl+t" = "new_tab_with_cwd";
        "ctrl+shift+t" = "new_tab";
      };

      # Tema do noctalia no fim do arquivo (como antes), sobrepondo cores dos settings
      extraConfig = lib.mkOrder 600 ''
        include ${user.home}/.config/kitty/themes/noctalia.conf
      '';
    };
  };
}
