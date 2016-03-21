# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  virtualisation.virtualbox.guest.enable = true;

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda";

  boot.initrd.checkJournalingFS = false;

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    git
    haskellPackages.ghc
    sudo
    tig
    vim
    wget
    zsh

    xcompmgr
    xlibs.xmessage
    haskellPackages.xmobar
    haskellPackages.xmonad
    haskellPackages.xmonad-contrib
    haskellPackages.xmonad-extras
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";
  services.xserver.windowManager.default = "xmonad";
  services.xserver.windowManager.xmonad.enable = true;
  services.xserver.windowManager.xmonad.enableContribAndExtras = true;
  services.xserver.windowManager.xmonad.extraPackages = self: [ self.xmonad-contrib ];
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.desktopManager.default = "none";

  # Enable the desktop environment.
  #services.xserver.displayManager.auto.enable = true;
  services.xserver.displayManager.auto.enable = false;
  services.xserver.displayManager.auto.user = "ashley";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.ashley = {
    isNormalUser = true;
    group = "users";
    extraGroups = ["wheel"]; # Enable SUDO usage
    uid = 1000;
    createHome = true;
    home = "/home/ashley";
    shell = "/run/current-system/sw/bin/zsh";
  };

  programs.zsh.enable = true;

  # Make Zsh the default shell system-wide, add
  users.defaultUserShell = "/run/current-system/sw/bin/zsh";

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "15.09";

}
