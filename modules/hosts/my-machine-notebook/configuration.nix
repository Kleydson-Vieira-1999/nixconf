{ self, inputs, config, ... }:
let
  user = config.my.user;
in
{

  flake.nixosModules.myMachineConfiguration = { config, pkgs, lib, ... }: {
    imports = [
      self.nixosModules.myMachineHardware
      self.nixosModules.defaultPrograms
      self.nixosModules.defaultFeatures
    ];

    # Bootloader
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Igual ao nome da nixosConfiguration: permite `nixos-rebuild switch --flake .`
    networking.hostName = "myMachine";
    networking.networkmanager.enable = true;

    time.timeZone = "America/Sao_Paulo";

    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "pt_BR.UTF-8";
      LC_IDENTIFICATION = "pt_BR.UTF-8";
      LC_MEASUREMENT = "pt_BR.UTF-8";
      LC_MONETARY = "pt_BR.UTF-8";
      LC_NAME = "pt_BR.UTF-8";
      LC_NUMERIC = "pt_BR.UTF-8";
      LC_PAPER = "pt_BR.UTF-8";
      LC_TELEPHONE = "pt_BR.UTF-8";
      LC_TIME = "pt_BR.UTF-8";
    };

    # Desktop (GNOME + GDM)
    services.xserver.enable = true;
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;

    services.xserver.xkb = {
      layout = "br";
      variant = "";
    };
    console.keyMap = "br-abnt2";

    services.printing.enable = true;

    # Áudio com pipewire
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    users.users.${user.name} = {
      isNormalUser = true;
      description = user.name;
      extraGroups = [ "networkmanager" "wheel" ];
    };

    programs.firefox.enable = true;

    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Não altere sem ler `man configuration.nix` (system.stateVersion)
    system.stateVersion = "26.05";

  };

}
