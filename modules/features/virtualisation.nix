{ self, inputs, ... }: {

  flake.nixosModules.myVirtualisation = { config, pkgs, lib, ... }: {

    users.users.doctor.extraGroups = [ "libvirtd" "kvm" "podman" ];

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
          runAsRoot = true;
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
    };

    security.polkit.enable = true; # Enable polkit for managing permissions related to virtualization

    networking.firewall.trustedInterfaces = [ "virbr1" "virbr2" ];

  };

}
