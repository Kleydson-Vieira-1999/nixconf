{ self, inputs, config, ... }:
let
  user = config.my.user;
in
{

  flake.nixosModules.myVirtualisation = { config, pkgs, lib, ... }: {

    users.users.${user.name}.extraGroups = [ "libvirtd" "kvm" "podman" ];

    environment.systemPackages = with pkgs; [
      gnome-boxes
      virt-manager
      swtpm
      virtio-win
      dmidecode # For whonix

      podman-compose
    ];

    # Enable libvirt for virtualization
    virtualisation = {
      libvirtd = {
        enable = true;
        allowedBridges = [ "virbr1" "virbr2" ];
        qemu = {
          package = pkgs.qemu_kvm;
          runAsRoot = false;
          swtpm.enable = true; # Enable swtpm for TPM emulation, useful for Windows 11 VMs

          # For windowns 11 setup
          # verbatimConfig = ''
          #   namespaces = [ "mount" ]
          #   tpms_user = "libvirt-qemu"
          #   tpms_group = "libvirt-qemu"
          # '';
        };
      };

      podman = {
        enable = true;
        # Cria um link simbólico para que o comando 'docker' aponte para o 'podman'
        dockerCompat = true;
        # Necessário para que os containers se comuniquem entre si usando nomes de domínio (ex: kibana chamando http://elasticsearch:9200)
        defaultNetwork.settings.dns_enabled = true;
      };

      containers = {
        enable = true;
        # Rejeita imagens por padrão; aceita só registries conhecidos e imagens locais.
        # Para usar outro registry, adicione-o em transports.docker.
        policy = let accept = [ { type = "insecureAcceptAnything"; } ]; in {
          default = [ { type = "reject"; } ];
          transports = {
            docker = {
              "docker.io" = accept;
              "quay.io" = accept;
              "ghcr.io" = accept;
              "docker.elastic.co" = accept;
              "registry.fedoraproject.org" = accept;
            };
            containers-storage."" = accept;
            docker-archive."" = accept;
            oci-archive."" = accept;
            oci."" = accept;
            dir."" = accept;
          };
        };
      };
    };

    security.polkit.enable = true; # Enable polkit for managing permissions related to virtualization

    # Libera só DHCP e DNS do libvirt nas bridges, em vez de confiar totalmente nelas
    networking.firewall.interfaces = lib.genAttrs [ "virbr1" "virbr2" ] (_: {
      allowedUDPPorts = [ 53 67 ];
      allowedTCPPorts = [ 53 ];
    });

  };

}
