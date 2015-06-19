# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  # Define on which hard drive you want to install Grub.
  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda";
    #extraEntries = ''
    #  menuentry 'Ubuntu' {
    #    insmod ext4
    #    set root='(hd1,4)
    #  }
    #'';
  };

  networking.hostName = "nixos"; # Define your hostname.
  networking.hostId = "81c4ff94";
  # networking.wireless.enable = true;  # Enables wireless.

  # Select internationalisation properties.
  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    git
    stalonetray
    sudo
    vim
    wget
    zsh
    xcompmgr
    xlibs.xmessage
    haskellPackages.ghc
    haskellPackages.xmobar
    haskellPackages.xmonad
    haskellPackages.xmonadContrib
    haskellPackages.xmonadExtras
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "eurosign:e";
    windowManager.xmonad.enable = true;
    windowManager.default = "xmonad";
    windowManager.xmonad.enableContribAndExtras = true;
    windowManager.xmonad.extraPackages = self: [ self.xmonadContrib ];
    desktopManager.xterm.enable = false;
    desktopManager.default = "none";
    displayManager = {
      slim = {
        enable = true;
        defaultUser = "ashley";
      };
    };
  };

  programs.ssh.startAgent = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.kdm.enable = true;
  # services.xserver.desktopManager.kde4.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.ashley = {
    isNormalUser = true;
    group = "users";
    extraGroups = [ "wheel" ]; # Enable SUDO usage
    uid = 1000;
    createHome = true;
    home = "/home/ashley";
    shell = "/run/current-system/sw/bin/zsh";
  };

}
