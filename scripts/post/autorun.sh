#!/bin/bash

pip install --prefix=/usr pywal

chmod +x /usr/etc/polybar/launch.sh

systemctl enable lightdm
systemctl enable tailscaled