{ config, ... }:
{
  hardware.graphics.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;

    open = false;
    powerManagement.enable = false;
    powerManagement.finegrained = false;

    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };

  hardware.nvidia.prime = {
    sync.enable = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };
}
