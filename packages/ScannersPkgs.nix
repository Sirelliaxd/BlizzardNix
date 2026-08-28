{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
	nmap
	ffuf
	gobuster
	nikto
	naabu
	sqlmap
	rustscan
	wafw00f
	dirb
	gospider
	smbmap
	snmpcheck
	subfinder
	netdiscover
	bloodhound
	bloodhound-py
	dnsenum
  ];
}
