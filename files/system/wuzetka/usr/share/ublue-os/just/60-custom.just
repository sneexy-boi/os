# vim: set ft=make :

wuzetka-setup:
    # Wuzetka setup !!! sneexy ah setu p!!! real reeal real!!!!
    echo 'This script will set up everything that I (Sneexy) use and consider for a good experience setup.'
    echo 'Also fixes some things that may be broken out of the box or require additional setup.'
    echo
    echo 'You have 8 seconds to press CTRL + C and stop this script from running. Thanks for using Wuzetka!'
    sleep 8
    # Add user to proper groups
    echo 'Adding user to necessary groups...'
    sudo usermod -aG libvirt $USER
    # Symlink relative theme folders to fix certain issues
    echo 'Symlinking themes...'
    THEME_DIR=${HOME}/.local/share/themes/Catppuccin-Mocha-Compact-Green-Dark
    mkdir -p "${HOME}/.config/gtk-4.0"
    ln -sf "${THEME_DIR}/gtk-4.0/assets" "${HOME}/.config/gtk-4.0/assets"
    ln -sf "${THEME_DIR}/gtk-4.0/gtk.css" "${HOME}/.config/gtk-4.0/gtk.css"
    ln -sf "${THEME_DIR}/gtk-4.0/gtk-dark.css" "${HOME}/.config/gtk-4.0/gtk-dark.css"
    ln -sf "${HOME}/.local/share/themes" "${HOME}/.themes"
    ln -sf "${HOME}/.local/share/icons" "${HOME}/.icons"
    # Create an Bazzite-Arch distrobox container for gaming. Just create the box and export the applications I use
    echo 'Creating Bazzite-Arch distrobox...'
    distrobox-create --unshare-netns --image ghcr.io/ublue-os/bazzite-arch --name bazzite-arch -Y
    distrobox-enter -n bazzite-arch -- sh -c "distrobox-export --app steam && \
        distrobox-export --app lutris && \
        distrobox-export --app protontricks && \
        distrobox-export --bin /usr/bin/steam && \
        distrobox-export --bin /usr/bin/steam-runtime && \
        distrobox-export --bin /usr/bin/steamcmd && \
        distrobox-export --bin /usr/bin/lutris && \
        distrobox-export --bin /usr/bin/protontricks && \
        distrobox-export --bin /usr/bin/protontricks-desktop-install && \
        distrobox-export --bin /usr/bin/protontricks-launch && \
        mkdir -p ~/.steam && distrobox-export --bin /usr/bin/steamcmd --export-path ~/.steam && mv ~/.steam/steamcmd ~/.steam/steamcmd.sh'"
    # Done
    echo 'Done!'