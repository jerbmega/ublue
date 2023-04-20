# My uBlue image

[![build-ublue](https://github.com/jerbmega/ublue/actions/workflows/build.yml/badge.svg)](https://github.com/jerbmega/ublue/actions/workflows/build.yml)

This is my personal uBlue image with i3 and extra system utilities. For better or worse, it's i3 and not Sway because some programs I use (looking at you, Discord) don't currently work properly over Wayland.

It is designed to be used in cojunction with [my Boxkit image](https://github.com/jerbmega/boxkit), and this is the default setup, providing an ephemeral environment at all times in the CLI that can easily be nuked and reprovisioned if desired.

**This image is *unfinished*** and is not stable for daily use. Contents can and will rapidly change. I do not use this in production yet, you shouldn't either.

For more info, check out the [uBlue homepage](https://ublue.it/) and the [main uBlue repo](https://github.com/ublue-os/main/)

## Customization

Even though this is a personal image, I added some options to allow for customization of what starts at startup and what is run when taking a screenshot.

### Autostart

Use `~/.config/ublue/i3_autostart.sh` for programs that i3 should start once, and `~/.config/ublue/i3_autostart_always.sh` for programs i3 should run on every WM reload.

### Screenshots

Maim is included in the base image which allows for custom screenshot scripts. This allows the user to choose the exact behavior of the Print Screen key.

Place a screenshot script at `~/.config/ublue/i3_screenshot.sh`. This is executed by i3 when pressing Shift + Print Screen simultaneously.

Place a regional screenshot script at `~/.config/ublue/i3_screenshot_region.sh`. This is executed by i3 when pressing Print Screen.

## Verification

These images are signed with sigstore's [cosign](https://docs.sigstore.dev/cosign/overview/). You can verify the signature by downloading the `cosign.pub` key from this repo and running the following command:

    cosign verify --key cosign.pub ghcr.io/jerbmega/custom-ublue

If you're forking this repo, the uBlue website has [instructions](https://ublue.it/making-your-own/) for setting up signing properly.
