{ self, inputs, ... }: {

  flake.nixosModules.mySecurityConfig = { pkgs, lib, ... }: {

    services.resolved.enable = true;
    services.cloudflare-warp.enable = true; # Enable Cloudflare Warp

    networking.firewall.enable = true;
    networking.nftables.enable = true;

  };

}