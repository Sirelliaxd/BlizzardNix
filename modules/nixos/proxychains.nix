{ pkgs, ... }: {
  programs.proxychains = {
    enable = true;
    # Use standard proxychains instead of proxychains-ng if you experience issues with custom proxies
    package = pkgs.proxychains; 
    quietMode = false;
    proxyDNS = true;
    localnet = "127.0.0.1/8";
    proxies = {
      myproxy = {
        enable = true;
        type = "socks5";
        host = "127.0.0.1";
        port = 9050;
      };
    };
  };
}

