# My uBlue image

[![build-ublue](https://github.com/jerbmega/ublue/actions/workflows/build.yml/badge.svg)](https://github.com/jerbmega/ublue/actions/workflows/build.yml)

This is my personal uBlue image with i3 and extra system utilities. For better or worse, it's i3 and Sway because some programs I use (looking at you, Discord) don't currently work properly over Wayland.

It is designed to be used in cojunction with [my Boxkit image](https://github.com/jerbmega/boxkit), and this is the default setup, providing an ephemeral environment at all times in the CLI that can easily be nuked and reprovisioned if desired.

This image is *unfinished* and is not stable for daily use. I do not use this in production yet, you shouldn't either.

For more info, check out the [uBlue homepage](https://ublue.it/) and the [main uBlue repo](https://github.com/ublue-os/main/)

## Verification

These images are signed with sigstore's [cosign](https://docs.sigstore.dev/cosign/overview/). You can verify the signature by downloading the `cosign.pub` key from this repo and running the following command:

    cosign verify --key cosign.pub ghcr.io/jerbmega/custom-ublue

If you're forking this repo, the uBlue website has [instructions](https://ublue.it/making-your-own/) for setting up signing properly.
