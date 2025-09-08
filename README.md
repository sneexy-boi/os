# bluebuild-custom &nbsp; [![bluebuild build badge](https://github.com/sneexy-boi/bluebuild-custom/actions/workflows/build.yml/badge.svg)](https://github.com/sneexy-boi/bluebuild-custom/actions/workflows/build.yml) [![bluebuild validity build badge](https://github.com/sneexy-boi/bluebuild-custom/actions/workflows/build-validity.yml/badge.svg)](https://github.com/sneexy-boi/bluebuild-custom/actions/workflows/build-validity.yml) [![containers build badge](https://github.com/sneexy-boi/bluebuild-custom/actions/workflows/containers.yml/badge.svg)](https://github.com/sneexy-boi/bluebuild-custom/actions/workflows/containers.yml)

custom [BlueBuild](https://blue-build.org) images for myself, based on [Universal Blue](https://universal-blue.org) which are based on immutable [Fedora](https://fedoraproject.org) images.

these images are heavily opinionated and customized, but descriptions of each image is below if you want to use them or fork them.

common features shared between these images:

- dns server/settings overrides
- completely customized desktops/setups
- custom desktop extensions and a lot of additional software (that i use daily)
- added rizz and gyatts

## wuzetka

customized image based on Fedora Kinoite, which uses the KDE Plasma desktop. mainly featuring a fully customized configuration and desktop to my own tastes and features many extensions on top of Plasma.

may not install correctly/produce a bad install image if generating an ISO using this image, possibly due to being too large.

### wuzetka-validity

the same image, but replaces fprintd packages with python-validity for use with devices with "unsupported" fingerprint scanners e.g. the Thinkpad T480

### arch-wuzetka

*not* a custom arch linux image. well, it is, but it's meant for distrobox, not to actually be installed on the host or anything. it just includes most of the CLI applications and utilities and some more extras to be able to install within wuzetka to get it fully properly functional without having to deal with anything else.

## Installation

> **Warning**  
> [This is an experimental feature](https://www.fedoraproject.org/wiki/Changes/OstreeNativeContainerStable), try at your own discretion.

First, check which image you want to use by copying its image name from the descriptions above, and use them in place of `<image>` in the commands below.

To rebase an existing atomic Fedora installation to the latest build:

- First rebase to the unsigned image, to get the proper signing keys and policies installed:
  ```
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/sneexy-boi/<image>:latest
  ```
- Reboot to complete the rebase:
  ```
  systemctl reboot
  ```
- Then rebase to the signed image, like so:
  ```
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/sneexy-boi/<image>:latest
  ```
- Reboot again to complete the installation
  ```
  systemctl reboot
  ```

The `latest` tag will automatically point to the latest build. That build will still always use the Fedora version specified in `recipe.yml`, so you won't get accidentally updated to the next major version.

## ISO

If build on Fedora Atomic, you can generate an offline ISO with the instructions available [here](https://blue-build.org/learn/universal-blue/#fresh-install-from-an-iso). These ISOs cannot unfortunately be distributed on GitHub for free due to large sizes, so for public projects something else has to be used for hosting.

## Verification

These images are signed with [Sigstore](https://www.sigstore.dev/)'s [cosign](https://github.com/sigstore/cosign). You can verify the signature by downloading the `cosign.pub` file from this repo and running the following command:

```bash
cosign verify --key cosign.pub ghcr.io/sneexy-boi/bluebuild-custom
```
