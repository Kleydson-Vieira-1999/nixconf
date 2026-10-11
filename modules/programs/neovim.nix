{ ... }: {

  # Neovim com LazyVim (https://www.lazyvim.org)
  # A configuração do LazyVim fica em ~/.config/nvim (starter oficial) e os plugins
  # são gerenciados pelo lazy.nvim. Aqui o Nix só fornece o Neovim e as dependências.
  flake.nixosModules.myNeovim = { pkgs, ... }: {

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
    
    # Permite que binários baixados pelo Mason (LSPs, formatters) rodem no NixOS
    programs.nix-ld.enable = true;
    
    environment.systemPackages = with pkgs; [
      # Dependências do LazyVim
      git
      lazygit
      ripgrep      # live grep
      fd           # busca de arquivos
      fzf
      tree-sitter  # CLI usada pelo nvim-treesitter
      gcc          # compilar parsers do treesitter
      gnumake
      unzip        # usado pelo Mason
      curl
      wget
      nodejs_24
      python3

      # LSPs/ferramentas instaladas via Nix (dispensam o Mason para estas linguagens)
      cmake
      clang-tools  # clangd
      nixd
      lua-language-server
      stylua

      # Clipboard
      xclip        # X11
      wl-clipboard # Wayland
    ];
  };
}
