# bluebuild-custom &nbsp; [![bluebuild build badge](https://github.com/sneexy-boi/bluebuild-custom/actions/workflows/build.yml/badge.svg)](https://github.com/sneexy-boi/bluebuild-custom/actions/workflows/build.yml) [![bluebuild validity build badge](https://github.com/sneexy-boi/bluebuild-custom/actions/workflows/build-validity.yml/badge.svg)](https://github.com/sneexy-boi/bluebuild-custom/actions/workflows/build-validity.yml) [![containers build badge](https://github.com/sneexy-boi/bluebuild-custom/actions/workflows/containers.yml/badge.svg)](https://github.com/sneexy-boi/bluebuild-custom/actions/workflows/containers.yml)

Custom [BlueBuild](https://blue-build.org) images for myself, based on [Universal Blue](https://universal-blue.org) which are based on immutable [Fedora](https://fedoraproject.org) images.

These images are heavily opinionated and customized, but should also be usable for others.

## Wuzetka <sub>`wuzetka`</sub>

My main customized image, based on Fedora Kinoite (KDE Plasma), also the only one currently with full focus.
customized image based on Fedora Kinoite, which uses the KDE Plasma desktop. mainly featuring a fully customized configuration and desktop to my own tastes and features many extensions on top of Plasma.

> [!CAUTION]
> [Generating an ISO](https://blue-build.org/how-to/generate-iso/) to use to install this image <b>may not work or function/install correctly</b>. I recommend installing vanilla Fedora Kinoite first then [rebasing](https://blue-build.org/learn/universal-blue/#by-rebasing-from-an-existing-installation-of-fedora-atomic-or-a-derivative) to this image afterwards.

### Wuzetka Validity <sub>`wuzetka-validity`</sub>

The same image as Wuzetka, but it replaces `fprintd` packages with [python-validity](https://github.com/uunicorn/python-validity) to allow support for using "unsupported" fingerprint sensors on certain devices, such as the Thinkpad T480.

### `arch-wuzetka`

Custom Arch Linux image made for use <i>strictly</i> with Distrobox. Just includes most of the same CLI utilities from Wuzetka to provide a more seamless, integrated experience.

## Installation

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
