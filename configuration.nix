# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices = [
    { 
      name = "root";
      device = "/dev/sda2";
      preLVM = true;
    }
  ];
  boot.resumeDevice = "/dev/mapper/root";


  networking.hostName = "zen"; # Define your hostname.
  networking.networkmanager.enable = true;
  networking.wireless.enable = false;  # Enables wireless support via wpa_supplicant.

  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" ];

  # Set your time zone.
  time.timeZone = "Europe/Kiev";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    firefox
    git
    htop
    networkmanagerapplet
    vim
    wget
    which
    vlc
    ntfs3g
    icedtea_web
    libreoffice
    qbittorrent
    tdesktop # Telegram
    rxvt_unicode
    python3
    python
    p7zip
    unzip
    unrar
    (vim_configurable.override { python3 = true; })
    neovim
    qtile
    ranger 
    nix-prefetch-scripts
    cmake
    gcc
  ] ;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us,ua";

  # Use same config for linux console
  i18n.consoleUseXkbConfig = true;

  services.xserver.xkbOptions = "grp:lctrl_toggle,grp_led:caps,ctrl:nocaps";

  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  services.xserver.displayManager.slim.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.pulseaudio = {
    enable = true;

    # NixOS allows either a lightweight build (default) or full build
    # of PulseAudio to be installed.  Only the full build has
    # Bluetooth support, so it must be selected here.
    package = pkgs.pulseaudioFull;
  };
 
  # Qtile
  services.xserver.windowManager = {
    default = "qtile";
    qtile.enable = true;
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.felytic = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = ["users" "wheel" "input" "audio" "networkmanager" "video"];
    initialPassword = "password";
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?

  # Redshift
  services.redshift = {
    enable = true;
    latitude = "50.4500";
    longitude = "30.5233";
  };

  # Fonts
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = false;

    fonts = with pkgs; [
      inconsolata
      dejavu_fonts
      source-code-pro
      ubuntu_font_family
      unifont
      terminus_font
      powerline-fonts
    ];
  };

  programs.slock.enable = true;

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  programs.zsh.enable = true;

  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;
}
