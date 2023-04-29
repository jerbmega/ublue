#!/bin/bash
# run scripts
echo "-- Running scripts defined in recipe.yml --"
buildscripts=$(yq '.scripts[]' < /tmp/ublue-recipe.yml)
for script in $(echo -e "$buildscripts"); do \
    echo "Running: ${script}" && \
    /tmp/scripts/$script; \
done
echo "---"

# remove the default firefox (from fedora) in favor of the flatpak
rpm-ostree override remove firefox firefox-langpacks

# add extra repositories
pushd /etc/yum.repos.d
wget https://pkgs.tailscale.com/stable/fedora/tailscale.repo
wget https://copr.fedorainfracloud.org/coprs/david35mm/pamixer/repo/fedora-37/david35mm-pamixer-fedora-38.repo
wget https://copr.fedorainfracloud.org/coprs/elxreno/bees/repo/fedora-38/elxreno-bees-fedora-38.repo

#TODO: we can make this process much faster if we make rpm-ostree install them all in one shot
echo "-- Installing RPMs defined in recipe.yml --"
rpm_packages=$(yq '.rpms[]' < /tmp/ublue-recipe.yml)
for pkg in $(echo -e "$rpm_packages"); do \
    echo "Installing: ${pkg}" && \
    rpm-ostree install $pkg; \
done
echo "---"


rm david35mm-pamixer-fedora-38.repo
rm elxreno-bees-fedora-38.repo
rm tailscale.repo
popd

pip install --prefix=/usr yafti
pip install --prefix=/usr pywal

systemctl enable lightdm
systemctl enable tailscaled

# LightDM workaround, remove once https://github.com/coreos/rpm-ostree/issues/4369 is fixed
systemctl enable ublue-lightdm-workaround
systemctl enable ublue-libvirt-workaround

# add a package group for yafti using the packages defined in recipe.yml
yq -i '.screens.applications.values.groups.Custom.description = "Flatpaks defined by the image maintainer"' /etc/yafti.yml
yq -i '.screens.applications.values.groups.Custom.default = true' /etc/yafti.yml
flatpaks=$(yq '.flatpaks[]' < /tmp/ublue-recipe.yml)
for pkg in $(echo -e "$flatpaks"); do \
    yq -i ".screens.applications.values.groups.Custom.packages += [{\"$pkg\": \"$pkg\"}]" /etc/yafti.yml
done
