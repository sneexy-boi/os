#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail
# if shit breaks i at least know where it is
set -x

#
# KDE Theme
#
cd /tmp
git clone https://github.com/catppuccin/kde.git catppuccinkde
cd catppuccinkde
rm -f install.sh
curl -sL -o /tmp/catppuccinkde/install.sh https://raw.githubusercontent.com/sneexy-boi/bluebuild-custom/refs/heads/main/files/scripts/catppuccin-plasma.sh
chmod +x install.sh
# Latte
cd /tmp/catppuccinkde && /tmp/catppuccinkde/install.sh 1 9 1
# Mocha
cd /tmp/catppuccinkde && /tmp/catppuccinkde/install.sh 4 9 1