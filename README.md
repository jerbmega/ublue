# Starting point

[![build-ublue](https://github.com/jerbmega/ublue/actions/workflows/build.yml/badge.svg)](https://github.com/jerbmega/ublue/actions/workflows/build.yml)

This is my personal uBlue derivative with i3 and extra system utilities.

For more info, check out the [uBlue homepage](https://ublue.it/) and the [main uBlue repo](https://github.com/ublue-os/main/)

## Verification

These images are signed with sigstore's [cosign](https://docs.sigstore.dev/cosign/overview/). You can verify the signature by downloading the `cosign.pub` key from this repo and running the following command:

    cosign verify --key cosign.pub ghcr.io/jerbmega/custom-ublue

If you're forking this repo, the uBlue website has [instructions](https://ublue.it/making-your-own/) for setting up signing properly.
