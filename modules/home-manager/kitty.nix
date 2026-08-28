{ pkgs, ... }:

{
  programs.kitty = {
  enable = true;
  package = pkgs.kitty;
  font = {
  	name = "JetBrainsMono Nerd Font Mono";
	size = 11;
	};
  settings = {
  	shell = "fish";
	url_style = "curly";
	cursor_shape = "block";
	cursor_trail = 3;
	window_padding_width = 8;
	background_opacity = "0.6";
	dynamic_background_opacity = "yes";
	};
  };
}
