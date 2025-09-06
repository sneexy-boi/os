#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail
# if shit breaks i at least know where it is
set -x

#
# moonlight launcher
# Their install script basically does everything for us, so we can just run their script as is.
sh -c "$(curl -fsSL https://github.com/MeguminSama/moonlight-launcher/releases/latest/download/install.sh)"

# their desktop entry is just called "moonlight" which conflicts with icons and uses the moonlight streaming service icon. we rename it to prevent this
mv /usr/share/applications/moonlight.desktop /usr/share/applications/moonlight-stable.desktop
sed -i 's@Name=moonlight@Name=moonlight Desktop@g' /usr/share/applications/moonlight-stable.desktop