{ config, pkgs, inputs, ... }:

let
  username = import ./user.nix;
in
{
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";

  home.stateVersion = "26.05"; # Please read the comment before changing.

  home.packages = [
    inputs.burpsuitepro.packages.${pkgs.system}.default
  ];

  home.file = {
  };

  home.sessionVariables = {
     EDITOR = "nvim";
  };

  programs.home-manager.enable = true;

  
  xdg.configFile."nvim" = {
    source = ./modules/home-manager/nvim;
    recursive = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      # Adds nvim-treesitter bundled with all language parsers
      nvim-treesitter.withAllGrammars 
    ];
  };


  imports = [
  ./modules/home-manager/kitty.nix 
  ./modules/home-manager/fish.nix
  ];

}
