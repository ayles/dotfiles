{ config, pkgs, inputs, lib, user, modulesPath, ... }:

{
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  fileSystems."/" =
    {
      device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  security.sudo.wheelNeedsPassword = false;

  programs.hyprland = {
    enable = true;
  };

  home-manager.users.${user} = {
    home = {
      pointerCursor = {
        gtk.enable = true;
        x11.enable = true;
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 24;
      };
    };
    gtk.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    (self: super: {
      google-chrome = super.google-chrome.override {
        commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland --enable-features=WebUIDarkMode --force-dark-mode";
      };
    })
  ];

  fonts = {
    packages = with pkgs; [
      noto-fonts
      (nerdfonts.override { fonts = [ "Meslo" ]; })
    ];
  };

  # Use the grub EFI boot loader.
  boot.kernelParams = [ "nomodeset" ];
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
      default = "saved";
    };
  };

  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "ayles-pc";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Moscow";

  i18n.defaultLocale = "en_US.UTF-8";

  hardware.openrazer.enable = true;
  hardware.opengl.enable = true;
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.production;
    modesetting.enable = true;
    open = true;
  };
  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };

  services.hardware.openrgb.enable = true;
  services.blueman.enable = true;
  services.openvpn.servers = {
    butter = {
      config = ''
        config /home/${user}/.openvpn/butter.conf
        connect-retry 15
      '';
      autoStart = false;
    };
  };

  # Enable the X11 windowing system.
  # Needed only for sddm, just for now
  services.xserver = {
    videoDrivers = [ "nvidia" ];
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${lib.makeBinPath [pkgs.greetd.tuigreet] }/tuigreet --time --user-menu --cmd Hyprland";
        user = user;
      };
    };
  };

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal";
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = true;


  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    extraConfig = "
      load-module module-switch-on-connect
    ";
    package = pkgs.pulseaudioFull;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" "openrazer" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
    ];
  };

  # Fix for gamescope
  # https://github.com/NixOS/nixpkgs/issues/162562#issuecomment-1523177264
  nixpkgs.config.packageOverrides = pkgs: {
    steam = pkgs.steam.override {
      extraPkgs = pkgs: with pkgs; [
        xorg.libXcursor
        xorg.libXi
        xorg.libXinerama
        xorg.libXScrnSaver
        libpng
        libpulseaudio
        libvorbis
        stdenv.cc.cc.lib
        libkrb5
        keyutils
      ];
    };
  };

  programs.gamescope = {
    enable = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };
  programs.neovim.defaultEditor = true;

  programs.waybar.enable = true;

  virtualisation.docker.enable = true;

  # Some Windows dualboot compat
  time.hardwareClockInLocalTime = true;

  environment.defaultPackages = [ ];
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    libevdev
    strace
    sysbench
    xorg.xwininfo
    evhz
    lsof
    stress
    vmtouch
    discord

    curl
    dunst
    file
    fuzzel
    fzf
    gdb
    git
    git-lfs
    google-chrome
    htop
    hyprpaper
    iftop
    jq
    config.boot.kernelPackages.perf
    neofetch
    nix-tree
    nixpkgs-fmt
    nodePackages.pyright
    nodejs
    openrazer-daemon
    pavucontrol
    perf-tools
    perl
    polychromatic
    ripgrep
    rnix-lsp
    sumneko-lua-language-server
    sway-contrib.grimshot
    tdesktop
    tmux
    unzip
    wl-clipboard

    lm_sensors
    xorg.xlsclients
    vulkan-tools
  ];

  # For Hyprland
  environment.sessionVariables = rec {
    LIBVA_DRIVER_NAME = "nvidia";
    EGL_PLATFORM = "wayland";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  system.stateVersion = "23.11";
}

