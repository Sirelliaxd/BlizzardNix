{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
	wget
	kitty
	neovim
	git
	spice-vdagent
	fish
	librewolf
	yazi
	nerd-fonts.jetbrains-mono
	fastfetch
	eza
	bat
	curl
	btop
	keepassxc
	wl-clipboard
	spice-vdagent
	xclip
  github-cli
  ];
}
