{ self, inputs, ... }: {

  flake.nixosModules.niri = { pkgs, lib, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };

  perSystem = { pkgs, lib, self', system, ... }: {

    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;

      settings = {
        spawn-at-startup = [ (lib.getExe self'.packages.myNoctalia)  ];
        input = {
          keyboard = { xkb.layout = "br"; };
          touchpad = {
            tap = { };
            natural-scroll = { };
          };
        };
        binds = {
          "Mod+Return".spawn-sh = lib.getExe self'.packages.myTerminalKitty;
          "Mod+Q".close-window = [ ];

          "Mod+D".spawn = "fuzzel";
          "Mod+F".maximize-column = [ ];
          "Mod+Shift+Q".quit = [ ];
          "Mod+Comma".consume-window-into-column = [ ];
          "Mod+Period".expel-window-from-column = [ ];
          
          "Mod+Left".focus-column-left = [ ];
          "Mod+Right".focus-column-right = [ ];
          "Mod+Up".focus-window-up = [ ];
          "Mod+Down".focus-window-down = [ ];

          "Mod+Shift+Left".move-column-left = [ ];
          "Mod+Shift+Right".move-column-right = [ ];
          "Mod+Shift+Up".move-window-up = [ ];
          "Mod+Shift+Down".move-window-down = [ ];
        };
      };

    };  

  };

}
