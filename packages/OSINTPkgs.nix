{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
  	theharvester
	whatweb
	dnsrecon
	enum4linux
	enum4linux-ng
	maltego
	sherlock
	social-engineer-toolkit
	socialscan
	python313Packages.shodan
	username-anarchy
  ];
}
