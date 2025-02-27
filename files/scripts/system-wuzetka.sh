#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail
# if shit breaks i at least know where it is
set -x

#
# Blender fixes
#
sed -i 's@Exec=blender %f@Exec=env INTEL_DEBUG=reemit blender %f@g' /usr/share/applications/blender.desktop

#
# Catppuccinify SDDM theme
#
sed -i 's@TextColor="#F8F8F2"@TextColor="#cdd6f4"@g' /usr/share/sddm/themes/sddm-astronaut-theme/Themes/astronaut.conf
sed -i 's@HighlightColor="#343746"@HighlightColor="#a6e3a1"@g' /usr/share/sddm/themes/sddm-astronaut-theme/Themes/astronaut.conf
sed -i 's@BackgroundColor="#21222C"@BackgroundColor="#1e1e2e"@g' /usr/share/sddm/themes/sddm-astronaut-theme/Themes/astronaut.conf
sed -i 's@PlaceholderColor="#bbbbbb"@PlaceholderColor="#6c7086"@g' /usr/share/sddm/themes/sddm-astronaut-theme/Themes/astronaut.conf
sed -i 's@SystemButtonsIconColor="#ffffff"@SystemButtonsIconColor="#cdd6f4"@g' /usr/share/sddm/themes/sddm-astronaut-theme/Themes/astronaut.conf

#
# MPD Discord RPC systemd service
#
curl -sL -o /usr/lib/systemd/user/mpd-discord-rpc.service https://raw.githubusercontent.com/JakeStanger/mpd-discord-rpc/master/mpd-discord-rpc.service

#
# Rescrobbled systemd service
#
curl -sL -o /usr/lib/systemd/user/rescrobbled.service https://raw.githubusercontent.com/InputUsername/rescrobbled/master/rescrobbled.service
sed -i 's@ExecStart=%h/.cargo/bin/rescrobbled@ExecStart=/usr/bin/rescrobbled@g' /usr/lib/systemd/user/rescrobbled.service

#
# tlrc files
#
curl -sL -o /usr/share/bash-completion/completions/tldr https://raw.githubusercontent.com/tldr-pages/tlrc/main/completions/tldr.bash
curl -sL -o /usr/share/zsh/site-functions/_tldr https://raw.githubusercontent.com/tldr-pages/tlrc/main/completions/_tldr
curl -sL -o /usr/share/fish/vendor_completions.d/tldr.fish https://raw.githubusercontent.com/tldr-pages/tlrc/main/completions/tldr.fish
curl -sL -o /usr/share/man/man1/tldr.1 https://raw.githubusercontent.com/tldr-pages/tlrc/main/tldr.1