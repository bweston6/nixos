# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # boot
  boot = {
    initrd.systemd.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.systemd-boot.editor = false;
    loader.systemd-boot.enable = true;
    loader.timeout = 0;
    plymouth.enable = true;
  };

  # networking
  networking = {
    hostName = "Bens-Laptop-NixOS";
    firewall.enable = false;
    networkmanager.enable = true;
  };

  # locale
  console.keyMap = "uk";
  i18n = {
    defaultLocale = "en_GB.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_GB.UTF-8";
      LC_IDENTIFICATION = "en_GB.UTF-8";
      LC_MEASUREMENT = "en_GB.UTF-8";
      LC_MONETARY = "en_GB.UTF-8";
      LC_NAME = "en_GB.UTF-8";
      LC_NUMERIC = "en_GB.UTF-8";
      LC_PAPER = "en_GB.UTF-8";
      LC_TELEPHONE = "en_GB.UTF-8";
      LC_TIME = "en_GB.UTF-8";
    };
  };
  time.timeZone = "Europe/London";

  # gnome
  security.pam.services = {
    login.fprintAuth = false;
    gdm-fingerprint.fprintAuth = true;
  };
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    xkb = {
      layout = "gb";
      variant = "";
    };
  };

  # sound
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };


  # packages
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    awscli2
    cargo
    devspace
    easyeffects
    firefox
    gcc
    git
    gnome.gnome-tweaks
    home-manager
    kubectl
    neovim
    nodejs
    oh-my-zsh
    python3Packages.pip
    python3Packages.pipx
    ripgrep
    rsync
    rubyripper
    s-tui
    wl-clipboard
  ];
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    (nerdfonts.override { fonts = [ "SourceCodePro" ]; })
  ];

  # package config
  programs = {
    zsh = {
      enable = true;
      autosuggestions.enable = true;
      ohMyZsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "agnoster";
      };
      syntaxHighlighting.enable = true;
    };
  };
  environment.variables.EDITOR = "nvim";

  # services
  services = {
    flatpak.enable = true;
    fprintd.enable = true;
    fwupd.enable = true;
    printing.enable = true;
  };
  virtualisation = {
    docker.enable = true;
  };

  # user config
  users.users.ben = {
    description = "Ben Weston";
    extraGroups = [ "docker" "networkmanager" "wheel" ];
    isNormalUser = true;
    shell = pkgs.zsh;
  };

  system.stateVersion = "23.11";
}
