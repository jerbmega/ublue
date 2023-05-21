#!/bin/bash

pip install --prefix=/usr pywal

chmod +x /usr/etc/polybar/launch.sh
chmod +x /usr/etc/ublue-lightdm-workaround.sh
chmod +x /usr/etc/ublue-libvirt-workaround.sh

systemctl enable lightdm
systemctl enable tailscaled

systemctl enable ublue-lightdm-workaround
systemctl enable ublue-libvirt-workaround