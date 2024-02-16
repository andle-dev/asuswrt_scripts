#!/bin/sh
# Made by andlespace <andlespace.github.io>

mkdir -p /jffs/scripts && \
echo -e "#!/bin/sh\nnvram set territory_code=KR/01\nnvram set preferred_lang=KR\nnvram commit\nservice restart_httpd" > /jffs/scripts/usb_mount.sh && \
chmod 755 /jffs/scripts/usb_mount.sh && \
cd /mnt/*/asusware.arm/etc/init.d/ && \
if [ ! -f ./S50usb-mount-script ]; then \
  echo -e '#!/bin/sh\n\nTARGET_SCRIPT="/jffs/scripts/usb_mount.sh"\n\ncase "$1" in\n  "start")\n    NVRAM_SCRIPT="$(nvram get script_usbmount)"\n\n    if [ -n "$NVRAM_SCRIPT" ]; then\n      logger -t "$(basename "$0")" "Executing command in \"script_usbmount\"..."\n      eval "$NVRAM_SCRIPT"\n    else\n      if [ -x "$TARGET_SCRIPT" ]; then\n        /bin/sh "$TARGET_SCRIPT" start\n      fi\n    fi\n    ;;\n  "stop")\n    NVRAM_SCRIPT="$(nvram get script_usbumount)"\n\n    if [ -n "$NVRAM_SCRIPT" ]; then\n      logger -t "$(basename "$0")" "Executing command in \"script_usbumount\"..."\n      eval "$NVRAM_SCRIPT"\n    else\n      if [ -x "$TARGET_SCRIPT" ]; then\n        /bin/sh "$TARGET_SCRIPT" stop\n      fi\n    fi\n    ;;\nesac' >> S50usb-mount-script; fi && \
cd /mnt/*/asusware.arm//lib/ipkg/ && \
if ! grep -qxF "Package: usb-mount-script" ./status; then \
  echo -e "Package: usb-mount-script\nVersion: 1.0.0.0\nStatus: install user installed\nArchitecture: arm\nInstalled-Time: 0" >> ./status; fi && \
cd /mnt/*/asusware.arm/lib/ipkg/info/ && \
if [ ! -f ./usb-mount-script.control ] || ! grep -qxF "Package: usb-mount-script" ./usb-mount-script.control; then \
  echo -e "Package: usb-mount-script\nArchitecture: arm\nPriority: optional\nSection: libs\nVersion: 1.0.0.0\nDepends:\nSuggests:\nConflicts:\nEnabled: yes\nInstalled-Size: 1" >> ./usb-mount-script.control; fi && \
cd /mnt/*/asusware.arm/lib/ipkg/lists && \
if [ ! -f ./optware.asus ] || ! grep -qxF "Package: usb-mount-script" ./optware.asus; then \
  echo -e "\nPackage: usb-mount-script\nVersion: 1.0.0.0\nArchitecture: arm" >> ./optware.asus; fi