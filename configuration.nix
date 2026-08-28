
{ config, pkgs, lib, inputs, ... }:

let
  username = import ./user.nix;
in
{
  imports =
    [ 
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
      ./packages/CorePkgs.nix
      ./packages/ScannersPkgs.nix
      ./packages/CrackingPkgs.nix
      ./packages/OPSECPkgs.nix
      ./packages/OSINTPkgs.nix
      ./packages/ToolsPkgs.nix
      ./packages/NvimDepPkgs.nix
      ./modules/nixos/proxychains.nix
    ];

  # Bootloader.
  # test
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Warsaw";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  services.xserver.enable = true;

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.defaultSession = "plasmax11";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "pl";
    variant = "";
  };

  console.keyMap = "pl2";

  # services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #media-session.enable = true;
  };

  services.xserver.libinput.enable = true;

  users.users."${username}" = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = [ "networkmanager" "wheel" "wireshark" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  programs.firefox.enable = true;
  programs.fish.enable = true;

  nixpkgs.config.allowUnfree = true;

  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  boot.initrd.availableKernelModules = [ "virtio_net" "virtio_pci" "virtio_blk" "virtio_scsi" "9p" "9pnet_virtio" ];

  virtualisation.hypervGuest.enable = false;

  virtualisation.libvirtd = {
    enable = true;
    qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
    };

  environment.sessionVariables = {
	SPICE_VDAGENT_QUIET = "0";
  };


  systemd.user.services.spice-vdagent-wayland-bridge = {
  description = "XWayland to Wayland Spice Clipboard Sync";
  wantedBy = [ "graphical-session.target" ];
  partOf = [ "graphical-session.target" ];
  environment = {
    QT_QPA_PLATFORM = "wayland";
    GDK_BACKEND = "wayland,x11";
  };
  serviceConfig = {
    # Run the agent in foreground mode (-x avoids daemonizing, -d provides logging)
    ExecStart = "${pkgs.spice-vdagent}/bin/spice-vdagent -x -d";
    Restart = "always";
    RestartSec = 2;
  };
};


  fileSystems."/home/${username}/Shared" = {
    device = "Shared";
    fsType = "virtiofs";
    options = [
    	"rw"
	"nofail"
	"user"
	];
  };


  home-manager = {
  # also pass inputs to home-manager modules
  extraSpecialArgs = { inherit inputs; };
  users = {
  	"${username}" = import ./home.nix;
	};
  };

  system.activationScripts.securityAssets = {
  text = ''
      # Create the traditional directory structure
      mkdir -p /usr/share/wordlists
      mkdir -p /usr/share/payloads

      # Symlink SecLists
      ln -sfn ${pkgs.seclists}/share/wordlists/seclists /usr/share/wordlists/seclists
    
      # Symlink PayloadsAllTheThings
      ln -sfn ${pkgs.payloadsallthethings}/share/payloadsallthethings /usr/share/payloads/payloadsallthethings
    '';
  };

  nix.nixPath = [ 
	"nixos-config=/home/${username}/Nix/configuration.nix"
	"nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
  ];

  programs.wireshark.enable = true;

  programs.wireshark.usbmon.enable = true;


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  system.stateVersion = "26.05";
}
