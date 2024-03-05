{ config, lib, pkgs, modulesPath, ... }:

{
	imports = [ ( modulesPath + "/installer/scan/not-detected.nix" ) ];

	boot = {
		initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" ];
		kernelModules = [ "kvm-intel" ];
	};

	fileSystems = {
		"/" = {
			device = "/dev/disk/by-uuid/60409056-e4eb-466e-87bd-e3c3672a1b18";
			fsType = "f2fs";
		};
		"/boot" = {
			device = "/dev/disk/by-uuid/90E4-C3DA";
			fsType = "vfat";
		};
	};

	swapDevices = [ ];

	networking.useDHCP = lib.mkDefault true;

	nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

	hardware = {
		cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
		opengl = {
			enable = true;
			extraPackages = with pkgs; [
				intel-media-driver
			];
		};
		trackpoint.sensitivity = 80;
	};
}
