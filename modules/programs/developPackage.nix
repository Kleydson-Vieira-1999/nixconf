{ self, inputs, config, ... }:
let
  user = config.my.user;
in
{

  flake.nixosModules.developPackage = { pkgs, ... }: {

    programs.tmux = {
      enable = true;
      clock24 = true;
      keyMode = "vi";
    };

    users.users.${user.name}.extraGroups = [ "dialout" ];

    fonts.packages = [ pkgs.nerd-fonts.fira-code ];

    environment.systemPackages = with pkgs; [
      vscode-fhs
      insomnia

      nixd # for lsp 
      nil # for lsp
      nixfmt # formatter (RFC style)

      zed-editor

      # go stack
      go
      gopls
      delve

      nodejs_24

      gcc
      gdb
      gnumake

      arduino-cli
      avrdude

      google-cloud-sdk

      claude-code

      inputs.antigravity-nix.packages."${pkgs.stdenv.hostPlatform.system}".default
      inputs.antigravity-nix.packages."${pkgs.stdenv.hostPlatform.system}".google-antigravity-ide
      inputs.antigravity-nix.packages."${pkgs.stdenv.hostPlatform.system}".google-antigravity-cli
    ];
  };

}
