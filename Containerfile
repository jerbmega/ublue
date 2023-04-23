ARG FEDORA_MAJOR_VERSION=37
ARG BASE_CONTAINER_URL=ghcr.io/ublue-os/silverblue-main

FROM ${BASE_CONTAINER_URL}:${FEDORA_MAJOR_VERSION}
ARG RECIPE

COPY ${RECIPE} /tmp/ublue-recipe.yml

# copy over configuration files
COPY etc /etc
COPY usr /usr

# yq used in build.sh and the setup-flatpaks recipe to read the recipe.yml
# copied from the official container image as it's not avaible as an rpm
COPY --from=docker.io/mikefarah/yq /usr/bin/yq /usr/bin/yq

RUN mkdir -p /var/lib/alternatives

# copy and run the build script
COPY build.sh /tmp/build.sh
RUN chmod +x /tmp/build.sh && /tmp/build.sh

COPY late-etc /etc
RUN chmod +x /etc/polybar/launch.sh
RUN chmod +x /etc/ublue-lightdm-workaround.sh
RUN chmod +x /etc/ublue-libvirt-workaround.sh

# clean up and finalize container build
RUN rm -rf \
        /tmp/* \
        /var/* && \
    ostree container commit
