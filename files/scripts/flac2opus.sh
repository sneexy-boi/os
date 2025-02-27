#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail
# if shit breaks i at least know where it is
set -x

#
# flac2opus
#
curl -sL -o /usr/bin/flac2opus "https://raw.githubusercontent.com/SimonTeixidor/flac2opus/master/flac2opus.sh"
chmod +x /usr/bin/flac2opus