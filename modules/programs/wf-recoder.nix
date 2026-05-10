{ self, inputs, ... }: {

  flake.nixosModules.myWf-recoder = { pkgs, lib, ... }: {
    environment.systemPackages = with pkgs; [
      wf-recorder
      slurp
      libnotify
    ];
  };
}