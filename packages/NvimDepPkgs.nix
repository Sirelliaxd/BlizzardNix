{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
  	stylua
	ripgrep
	ast-grep
	python3
	luarocks
	lazygit
	fzf
	fd
	gcc
	unzip
	go
	ruby
	php
	pipx
  ];
}
