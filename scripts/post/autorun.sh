#!/bin/bash

pip install --prefix=/usr pywal

chmod +x /usr/etc/polybar/launch.sh
chmod +x /usr/etc/ublue-lightdm-workaround.sh

# Until Distrobox 1.5.0 lands in Fedora 38, install Distrobox manually.
# Normally I would say this is disgusting but Distrobox is just a bunch of bash scripts so it's... fine?
rpm-ostree override remove distrobox
git clone https://github.com/89luca89/distrobox/
pushd distrobox
git checkout main -b v1.5.0
./install --prefix /usr
popd
yes | rm -r distrobox

systemctl enable lightdm
systemctl enable tailscaled

systemctl enable ublue-lightdm-workaround
