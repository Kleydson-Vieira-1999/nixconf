{ self, inputs, ... }: {

  flake.nixosModules.myShell = { pkgs, lib, ... }: {

    users.users.doctor.shell = pkgs.zsh;

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;

      # promptInit = ""; 

      # Oh My Zsh configuration
      # ohMyZsh = {
      #   enable = true;
      #   theme = "robbyrussell";  # "kafeitu";
      #   plugins = [ "git" ];
      # };
    };
    programs.starship = { # Enable the Starship prompt.
      enable = true;
      settings = {
        add_newline = false;
        
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };
      };
    };
  };

}