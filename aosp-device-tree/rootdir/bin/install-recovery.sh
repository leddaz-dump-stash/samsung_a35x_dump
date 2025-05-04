#!/vendor/bin/sh
if ! applypatch --check EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):100663296:7ab56b3fa6ac9429e790b0736a72a93064dd81ce; then
  applypatch \
          --patch /vendor/recovery-from-boot.p \
          --source EMMC:/dev/block/by-name/boot$(getprop ro.boot.slot_suffix):67108864:81c1f9ba6c65d0c41843a809bafad340abe31d2c \
          --target EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):100663296:7ab56b3fa6ac9429e790b0736a72a93064dd81ce && \
      (log -t install_recovery "Installing new recovery image: succeeded" && setprop vendor.ota.recovery.status 200) || \
      (log -t install_recovery "Installing new recovery image: failed" && setprop vendor.ota.recovery.status 454)
else
  log -t install_recovery "Recovery image already installed" && setprop vendor.ota.recovery.status 200
fi

