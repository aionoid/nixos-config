{lib, ...}: {
  disko.devices = {
    disk.main = {
      type = "disk";
      device = lib.mkDefault "/dev/nvme1n1";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            priority = 1;
            end = "512M";
            type = "EF00"; # EFI System Partition
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot/efi";
              mountOptions = [
                "umask=0077"
              ];
            };
          };
          BOOT = {
            size = "2G"; # 2016MiB
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/boot";
              mountOptions = [
                "defaults"
              ];
            };
          };
          SYSTEM = {
            size = "250G"; # 250GB
            content = {
              type = "btrfs";
              extraArgs = ["-f"]; # Force overwrite
              subvolumes = {
                "@nixos" = {
                  mountpoint = "/";
                  mountOptions = ["compress=zstd:1" "noatime" "ssd"];
                };
                "@home" = {
                  mountpoint = "/home";
                  mountOptions = ["compress=zstd:1" "noatime" "ssd"];
                };
                "@nix" = {
                  mountpoint = "/nix";
                  mountOptions = ["compress=zstd:1" "noatime" "ssd"];
                };
                "@persist" = {
                  mountpoint = "/persist";
                  mountOptions = ["compress=zstd:1" "noatime" "ssd"];
                };
                "@log" = {
                  mountpoint = "/var/log";
                  mountOptions = ["compress=zstd:1" "noatime" "ssd"];
                };
                "@snapshots" = {
                  mountpoint = "/.snapshots";
                  mountOptions = ["compress=zstd:1" "noatime" "ssd"];
                };
              };
            };
          };
          DATA = {
            size = "100%"; # Rest of the disk
            content = {
              type = "btrfs";
              extraArgs = ["-f"];
              subvolumes = {
                "@data" = {
                  mountpoint = "/data";
                  mountOptions = ["compress=zstd:1" "noatime" "ssd"];
                };
              };
            };
          };
        };
      };
    };
  };
}
