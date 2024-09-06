# bluebuild-custom &nbsp; [![bluebuild build badge](https://github.com/sneexy-boi/bluebuild-custom/actions/workflows/build.yml/badge.svg)](https://github.com/sneexy-boi/bluebuild-custom/actions/workflows/build.yml) [![containers build badge](https://github.com/sneexy-boi/bluebuild-custom/actions/workflows/containers.yml/badge.svg)](https://github.com/sneexy-boi/bluebuild-custom/actions/workflows/containers.yml)

Custom [BlueBuild](https://blue-build.org) image builds for myself, which is based on [Universal Blue](https://universal-blue.org) which is based on Immutable [Fedora](https://fedoraproject.org) images.

These images are heavily opinionated and customized, but descriptions of each image is below if you want to use them or fork them.

Common features shared between these images:

- DNS server/settings overrides
- Completely customized desktops/setups
- Custom extensions and a lot of additional software (that I use daily)

## Wuzetka

Image name: `wuzetka`

Customized image based on Fedora Kinoite, which uses the KDE Plasma desktop.

## Mazurek

Image name: `mazurek`

Customized image based on the Fedora base image, which includes the niri window manager and an entirely customized and personal experience.

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
