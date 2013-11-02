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
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless.

  # Select internationalisation properties.
  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "fr";
    defaultLocale = "fr_FR.UTF-8";
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  # services.xserver.layout = "fr";
  # services.xserver.xkbOptions = "eurosign:e";

  services.xserver = {
	enable = true;
	layout = "fr";
	xkbOptions = "eurosign:e";


	videoDrivers = [ "nvidia" ];

	monitorSection = ''
		VendorName	"Samsung"
		ModelName	"SyncMaster P2450"
		HorizSync	30.0 - 75.0
		VertRefresh	60.0
		Option		"DPMS"
	'';

	defaultDepth=24;
  };

  services.dbus.packages = [ pkgs.gnome.GConf ];

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.kdm.enable = true;
  services.xserver.desktopManager.kde4.enable = true;
  
  swapDevices= [ {device="/dev/disk/by-label/Swap";} ];

  environment.systemPackages = with pkgs; [
   firefoxWrapper
   libreoffice
   mplayer
   smplayer
   gimp
   inkscape
   kde4.digikam
   vlc
   audacity
   emacs
   gitAndTools.gitFull
   (let myTexLive = 
        pkgs.texLiveAggregationFun {
           paths = [ pkgs.texLive pkgs.texLiveExtra pkgs.texLiveBeamer pkgs.texLiveContext
                     pkgs.texLiveCMSuper pkgs.texLiveLatexXColor pkgs.texLivePGF pkgs.texLiveFull ];
        };
      in myTexLive)
   blender
   zsh
   linuxPackages.virtualbox
   wget
   kde4.kdemultimedia
   kde4.kdegraphics
   kde4.kdeutils
   kde4.applications
   kde4.kdegames
   kde4.kdeedu
   kde4.kdebindings
   kde4.kdeaccessibility
   #kde4.kde_baseapps
   kde4.kactivities
   kde4.kdeadmin
   kde4.kdeartwork
   #kde4.kde_base_artwork
   kde4.kdenetwork
   kde4.kdepim
   kde4.kdepimlibs
   kde4.kdeplasma_addons
   kde4.kdesdk
   kde4.kdetoys
   #kde4.kde_wallpapers
   kde4.kdewebdev
   #kde4.oxygen_icons
   kde4.kdebase_workspace
   kde4.kdelibs
   kde4.kdevelop
   kde4.kdevplatform
   kde4.l10n.fr
 ];
}
