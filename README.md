# OS &nbsp; [![bluebuild build badge](https://github.com/SnenxyTengoku/os/actions/workflows/build.yml/badge.svg)](https://github.com/SnenxyTengoku/os/actions/workflows/build.yml) [![bluebuild validity build badge](https://github.com/SnenxyTengoku/os/actions/workflows/build-validity.yml/badge.svg)](https://github.com/SnenxyTengoku/os/actions/workflows/build-validity.yml) [![containers build badge](https://github.com/SnenxyTengoku/os/actions/workflows/containers.yml/badge.svg)](https://github.com/SnenxyTengoku/os/actions/workflows/containers.yml)

Custom [Atomic](https://docs.fedoraproject.org/en-US/emerging) [Fedora](https://fedoraproject.org) images built using [BlueBuild](https://blue-build.org), based on the extra works of [Universal Blue](https://universal-blue.org)

These images are heavily opinionated and customized, mainly only meant for personal use, but are available for others' use if preferred.

I don't provide support or anything - these are for myself, anyways.

## Wuzetka <sub>`wuzetka`</sub>

My main customized image, based on Fedora Kinoite (KDE Plasma). Focused on a fully personalized custom experience, themed around based on the Catppuccin Mocha theme with the Green accent color. Given a modern, flat look out of the box.

Features many extensions on the Plasma desktop and custom utilities and tools for general use and gaming.

> [!CAUTION]
> [Generating an ISO](https://blue-build.org/how-to/generate-iso/) to use to install this image <b>may not work or function/install correctly</b>. I recommend installing vanilla Fedora Kinoite first then [rebasing](#installation) to this image afterwards.

### Wuzetka Validity <sub>`wuzetka-validity`</sub>

The same image as Wuzetka, but it replaces `fprintd` packages with [python-validity](https://github.com/uunicorn/python-validity) to allow support for using "unsupported" fingerprint sensors on certain devices, such as the Thinkpad T480.

### `arch-wuzetka`

Custom Arch Linux image made for use <i>strictly</i> with Distrobox. Just includes most of the same CLI utilities from Wuzetka to provide a more seamless, integrated experience.

## Mazurek <sub>`mazurek`</sub>

<b>[WIP: Non existent currently.]</b>

Another customized image in the same flavor of Wuzetka, but based on Fedora Silverblue and focusing on customizing and extending the GNOME desktop environment.

## Installation

> [!WARNING]  
> [This is an experimental feature](https://www.fedoraproject.org/wiki/Changes/OstreeNativeContainerStable), try at your own discretion.

To rebase an existing atomic Fedora installation to the latest build:

- First rebase to the unsigned image, to get the proper signing keys and policies installed:
  ```
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/SnenxyTengoku/<image>:latest
  ```
- Reboot to complete the rebase:
  ```
  systemctl reboot
  ```
- Then rebase to the signed image, like so:
  ```
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/SnenxyTengoku/<image>:latest
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
cosign verify --key cosign.pub ghcr.io/SnenxyTengoku/<image>
```