#!/bin/bash

pip install --prefix=/usr pywal

systemctl enable lightdm
systemctl enable tailscaled

systemctl enable ublue-lightdm-workaround
systemctl enable ublue-libvirt-workaround