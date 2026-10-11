{ lib, ... }: {

  # Dados do usuário compartilhados entre os módulos (NixOS e wrappers)
  options.my.user = lib.mkOption {
    type = lib.types.attrsOf lib.types.str;
    default = rec {
      name = "doctor";
      home = "/home/${name}";
      fullName = "Kleydson Vieira";
      email = "kleydson122@gmail.com";
    };
  };

  config = {
    systems = [
      "x86_64-linux"
    ];
  };
}
