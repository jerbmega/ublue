ARG FEDORA_MAJOR_VERSION=37
ARG BASE_IMAGE_URL=ghcr.io/ublue-os/silverblue-main

FROM ${BASE_IMAGE_URL}:${FEDORA_MAJOR_VERSION}
ARG RECIPE

COPY ${RECIPE} /tmp/ublue-recipe.yml

# copy over configuration files
# etc is copied to /usr/etc/ to prevent "merge conflicts"
# as it is the proper directory for "system" configuration files
# and /etc/ is for editing by the local admin
# see issue #28 (https://github.com/ublue-os/startingpoint/issues/28)
COPY usr /usr
COPY etc /usr/etc

# copy scripts
RUN mkdir /tmp/scripts
COPY scripts /tmp/scripts
RUN find /tmp/scripts -type f -exec chmod +x {} \;

COPY ${RECIPE} /usr/etc/ublue-recipe.yml

# yq used in build.sh and the setup-flatpaks recipe to read the recipe.yml
# copied from the official container image as it's not avaible as an rpm
COPY --from=docker.io/mikefarah/yq /usr/bin/yq /usr/bin/yq

RUN mkdir -p /var/lib/alternatives

# copy and run the build script
COPY build.sh /tmp/build.sh
RUN chmod +x /tmp/build.sh && /tmp/build.sh

COPY late-etc /usr/etc
RUN chmod +x /usr/etc/polybar/launch.sh
RUN chmod +x /usr/etc/ublue-lightdm-workaround.sh
RUN chmod +x /usr/etc/ublue-libvirt-workaround.sh

# clean up and finalize container build
RUN rm -rf \
        /tmp/* \
        /var/* && \
    ostree container commit
