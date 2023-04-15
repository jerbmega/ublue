#!/bin/bash
# remove the default firefox (from fedora) in favor of the flatpak
rpm-ostree override remove firefox firefox-langpacks

# add extra repositories
cd /etc/yum.repos.d
wget https://pkgs.tailscale.com/stable/fedora/tailscale.repo
# don't forget to s/37/38 when we switch
wget https://copr.fedorainfracloud.org/coprs/david35mm/pamixer/repo/fedora-37/david35mm-pamixer-fedora-37.repo
wget https://copr.fedorainfracloud.org/coprs/fnux/ly/repo/fedora-37/fnux-ly-fedora-37.repo

echo "-- Installing RPMs defined in recipe.yml --"
rpm_packages=$(yq '.rpms[]' < /tmp/ublue-recipe.yml)
for pkg in $(echo -e "$rpm_packages"); do \
    echo "Installing: ${pkg}" && \
    rpm-ostree install $pkg; \
done
echo "---"

# By default, greetd will fail to work due to SELinux. This works around that problem.
semanage fcontext -m -ff -t xdm_exec_t /usr/bin/greetd
restorecon /usr/bin/greetd

pip install --prefix=/usr yafti
pip install --prefix=/usr pywal


# add a package group for yafti using the packages defined in recipe.yml
yq -i '.screens.applications.values.groups.Custom.description = "Flatpaks defined by the image maintainer"' /etc/yafti.yml
yq -i '.screens.applications.values.groups.Custom.default = true' /etc/yafti.yml
flatpaks=$(yq '.flatpaks[]' < /tmp/ublue-recipe.yml)
for pkg in $(echo -e "$flatpaks"); do \
    yq -i ".screens.applications.values.groups.Custom.packages += [{\"$pkg\": \"$pkg\"}]" /etc/yafti.yml
done
