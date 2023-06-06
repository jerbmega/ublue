#!/bin/bash

pip install --prefix=/usr pywal

chmod +x /usr/etc/polybar/launch.sh
chmod +x /usr/etc/ublue-lightdm-workaround.sh

systemctl enable lightdm
systemctl enable tailscaled

systemctl enable ublue-lightdm-workaround
