{ pkgs, ... }:

{
  programs.fish = {
  enable = true;
  interactiveShellInit = ''
  	set -g fish_greeting
  '';
  shellAliases = {
  	ls = "eza --icons auto";
	cat = "bat";
	ff = "fastfetch";
	tree = "eza --tree -L 2";
	y = "yazi";
	sy = "sudo yazi";
	};
  functions = {
  	yazi = {
	  body = ''
	    set tmp (mktemp -t "yazi-cwd.XXXXXX")
	    command yazi $argv --cwd-file="$tmp"
	    if read -z cwd <"$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
	      builtin cd -- "$cwd"
	    end
	    rm -f -- "$tmp"
	  '';
	};
  };
  };
}
