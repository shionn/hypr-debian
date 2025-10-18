#!/bin/bash
version="0.51.1"
project="hyprland"
revision="1"

apt install libgles2-mesa-dev libcairo2-dev libinput-dev wayland-protocols libdrm-dev libpixman-1-dev libxkbcommon-dev libre2-dev libwayland-dev libgbm-dev libpango1.0-dev libxcursor-dev libxcb-xfixes0-dev libxcb-icccm4-dev libxcb-composite0-dev libxcb-res0-dev libxcb-errors-dev libtomlplusplus-dev libpugixml-dev libseat-dev libzip-dev librsvg2-dev librsvg2-dev libwebp-dev libglaze-dev -y

cd build
rm -Rf $project*	

git clone --recursive -b v$version https://github.com/hyprwm/${project}.git ${project}
cd ${project} 

make all
make install

# TODO split pour les wallpapers

mkdir ${project}-${version}-${revision}
cd ${project}-${version}-${revision}

mkdir -p usr/local/bin/
mkdir -p usr/local/share/bash-completion/completions
mkdir -p usr/local/share/hypr/
mkdir -p usr/local/share/fish/vendor_completions.d/
mkdir -p usr/local/share/man/man1/
mkdir -p usr/local/share/wayland-sessions/
mkdir -p usr/local/share/xdg-desktop-portal/
mkdir -p usr/local/share/zsh/site-functions/
cp ../build/Hyprland                usr/local/bin/
cp ../build/hyprctl/hyprctl         usr/local/bin/
cp ../build/hyprpm/hyprpm           usr/local/bin/
cp ../hyprctl/hyprctl.bash          usr/local/share/bash-completion/completions/hyprctl
cp ../hyprpm/hyprpm.bash            usr/local/share/bash-completion/completions/hyprpm
cp ../hyprctl/*.fish                usr/local/share/fish/vendor_completions.d/
cp ../hyprpm/*.fish                 usr/local/share/fish/vendor_completions.d/
cp ../hyprctl/hyprctl.zsh           usr/local/share/zsh/site-functions/_hyprctl
cp ../hyprpm/hyprpm.zsh             usr/local/share/zsh/site-functions/_hyprpm
cp ../assets/install/*.png          usr/local/share/hypr/
cp ../example/hyprland.conf         usr/local/share/hypr/
cp ../docs/Hyprland.1               usr/local/share/man/man1/ 
cp ../docs/hyprctl.1                usr/local/share/man/man1/ 
cp ../example/hyprland.desktop      usr/local/share/wayland-sessions/
cp ../systemd/hyprland-uwsm.desktop usr/local/share/wayland-sessions/
cp ../assets/hyprland-portals.conf  usr/local/share/xdg-desktop-portal/


mkdir DEBIAN

echo "Source: ${project}
Section: graphics
Priority: optional
Maintainer: Shionn<shionn@gmail.com>
Homepage: https://github.com/hyprwm/${project}
Package: ${project}
Version: ${version}-${revision}
Architecture: amd64
Depends: aquamarine (>=0.9.3), hyprlang (>=0.3.2), hyprcursor (>=0.1.7), hyprutils (>=0.8.2), hyprgraphics (>=0.1.3), hyprwayland-scanner (>=0.3.10), libxkbcommon0, libre2-11, libgbm1, pango1.0-tools, libxcursor1, libxcb-xfixes0, libxcb-icccm4, libxcb-composite0, libxcb-res0, libxcb-errors0, libwayland-bin
Description: Hyprland is a 100% independent, dynamic tiling Wayland compositor that doesn't sacrifice on its looks.
 It provides the latest Wayland features, is highly customizable, has all the eyecandy, the most powerful plugins, easy IPC, much more QoL stuff than other compositors and more..." >> DEBIAN/control

echo "Format: https://www.debian.org/doc/packaging-manuals/copyright-format/1.0/
Upstream-Name: ${project}
Source: https://github.com/hyprwm/${project}/tree/v${version}
Files: *
Copyright: 2024, Hypr Development
Licence: BSD 3-Clause License" >> DEBIAN/copyright

cd .. 
dpkg -b ${project}-${version}-${revision}

mv ${project}-${version}-${revision}.deb ../

