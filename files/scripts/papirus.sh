#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail
# if shit breaks i at least know where it is
set -x

#
# Papirus icon pack (From source)
#
cd /tmp
wget -qO- https://git.io/papirus-icon-theme-install | sh