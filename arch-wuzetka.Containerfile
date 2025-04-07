FROM quay.io/toolbx/arch-toolbox AS arch-wuzetka

# Pacman Initialization
# Create build user
RUN sed -i 's/#Color/Color/g' /etc/pacman.conf && \
    printf "[multilib]\nInclude = /etc/pacman.d/mirrorlist\n" | tee -a /etc/pacman.conf && \
    sed -i 's/#MAKEFLAGS="-j2"/MAKEFLAGS="-j$(nproc)"/g' /etc/makepkg.conf && \
    pacman-key --init && pacman-key --populate && \
    pacman -Syu --noconfirm && \
    useradd -m --shell=/bin/bash build && usermod -L build && \
    echo "build ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    echo "root ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    pacman -S --clean --clean

# Distrobox Integration
RUN git clone https://github.com/89luca89/distrobox.git --single-branch /tmp/distrobox && \
    cp /tmp/distrobox/distrobox-host-exec /usr/bin/distrobox-host-exec && \
    ln -s /usr/bin/distrobox-host-exec /usr/bin/flatpak && \
    wget https://github.com/1player/host-spawn/releases/download/$(cat /tmp/distrobox/distrobox-host-exec | grep host_spawn_version= | cut -d "\"" -f 2)/host-spawn-$(uname -m) -O /usr/bin/host-spawn && \
    chmod +x /usr/bin/host-spawn && \
    rm -drf /tmp/distrobox

# Install packages Distrobox adds automatically, this speeds up first launch
RUN pacman -S \
        adw-gtk-theme \
        bash-completion \
        bc \
        curl \
        diffutils \
        findutils \
        glibc \
        gnupg \
        inetutils \
        keyutils \
        less \
        lsof \
        man-db \
        man-pages \
        mlocate \
        mtr \
        ncurses \
        nss-mdns \
        openssh \
        pigz \
        pinentry \
        procps-ng \
        rsync \
        shadow \
        sudo \
        tcpdump \
        time \
        traceroute \
        tree \
        tzdata \
        unzip \
        util-linux \
        util-linux-libs \
        vte-common \
        wget \
        words \
        xorg-xauth \
        zip \
        mesa \
        opengl-driver \
        vulkan-intel \
        vte-common \
        vulkan-radeon \
        --noconfirm && \
    rm -rf /var/cache/pacman/pkg/*

# Change default pacman config
RUN sed -i 's@#Color@Color@g' /etc/pacman.conf && \
    sed -i '/DisableSandbox/a\ILoveCandy' /etc/pacman.conf

# Add choatic-aur and paru
RUN pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com && \
    pacman-key --lsign-key 3056513887B78AEB && \
    pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' && \
    echo '[chaotic-aur]' >> /etc/pacman.conf && \
    echo 'Include = /etc/pacman.d/chaotic-mirrorlist' >> /etc/pacman.conf && \
    pacman -Syu paru --noconfirm && \
    rm -rf /var/cache/pacman/pkg/*

# Add wuzetka packages for arch to ensure CLI functions out of the box
RUN pacman -S \
        atuin \
        bat \
        btop \
        duf \
        eza \
        fastfetch \
        fd \
        fzf \
        git-delta \
        neovim \
        ripgrep \
        sd \
        starship \
        zoxide \
        zsh \
        --noconfirm && \
    rm -rf /var/cache/pacman/pkg/*

# Add AUR only packages
USER build
WORKDIR /home/build
RUN paru -Syu \
        cod-bin \
        krabby-bin \
        --noconfirm && \
    sudo rm -rf /var/cache/pacman/pkg/* && \
    rm -rf /home/build/.cache/*

USER root
WORKDIR /

# Cleanup
RUN sed -i 's@#en_US.UTF-8@en_US.UTF-8@g' /etc/locale.gen && \
    userdel -r build && \
    rm -drf /home/build && \
    sed -i '/build ALL=(ALL) NOPASSWD: ALL/d' /etc/sudoers && \
    sed -i '/root ALL=(ALL) NOPASSWD: ALL/d' /etc/sudoers && \
    rm -rf /tmp/*

FROM arch-wuzetka AS arch-wuzetka-amdgpupro

# Install amdgpu-pro, remove other drivers
RUN useradd -m --shell=/bin/bash build && usermod -L build && \
    echo "build ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    echo "root ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER build
WORKDIR /home/build
RUN paru -R \
        libglvnd \
        vulkan-intel \
        vulkan-radeon \
        mesa \
        --noconfirm && \
    paru -Syu \
        amdgpu-pro-oglp \
        lib32-amdgpu-pro-oglp \
        vulkan-amdgpu-pro \
        lib32-vulkan-amdgpu-pro \
        amf-amdgpu-pro \
        --noconfirm && \
    sudo rm -rf /var/cache/pacman/pkg/* && \
    rm -rf /home/build/.cache/*

USER root
WORKDIR /

# Cleanup
RUN userdel -r build && \
    rm -drf /home/build && \
    sed -i '/build ALL=(ALL) NOPASSWD: ALL/d' /etc/sudoers && \
    sed -i '/root ALL=(ALL) NOPASSWD: ALL/d' /etc/sudoers && \
    rm -rf \
        /tmp/* \
        /var/cache/pacman/pkg/*
