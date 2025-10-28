#!/bin/bash
version="1.3.11"
project="xdg-desktop-portal-hyprland"
revision="0~pre1"

apt install \
	libgbm-dev \
	libdrm-dev \
	libpipewire-0.3-dev \
	libspa-0.2-dev \
	qt6-base-dev \
	qt6-declarative-dev \
	libsdbus-c++-dev \
	libwayland-dev \
	wayland-protocols \
	libpugixml-dev \
	-y

cd build
rm -Rf $project*	

git clone --recursive -b v$version https://github.com/hyprwm/${project}.git ${project}
cd ${project} 

cmake -DCMAKE_INSTALL_LIBEXECDIR=/usr/lib -DCMAKE_INSTALL_PREFIX=/usr -B build
cmake --build build
cmake --install build

mkdir ${project}-${version}-${revision}
cd ${project}-${version}-${revision}
mkdir -p usr/bin/
mkdir -p usr/lib/
mkdir -p usr/share/xdg-desktop-portal/portals/
mkdir -p usr/share/dbus-1/services/
mkdir -p usr/lib/systemd/user/
cp ../build/hyprland-share-picker usr/bin/
cp ../build/xdg-desktop-portal-hyprland usr/lib/
cp ../hyprland.portal usr/share/xdg-desktop-portal/portals/
cp ../build/org.freedesktop.impl.portal.desktop.hyprland.service usr/share/dbus-1/services/
cp ../build/contrib/systemd/xdg-desktop-portal-hyprland.service usr/lib/systemd/user/

mkdir DEBIAN

echo "Source: ${project}
Section: graphics
Priority: optional
Maintainer: Shionn<shionn@gmail.com>
Homepage: https://github.com/hyprwm/${project}
Package: ${project}
Version: ${version}-${revision}
Architecture: amd64
Depends: libgbm1, 
 libdrm2, 
 libpipewire-0.3-0t64 (>=1.1.82),
 libwayland-client0,
 wayland-protocols,
 hyprlang (>=0.2.0),
 hyprutils (>=0.8.0), 
 hyprwayland-scanner (>=0.4.0),
 libsdbus-c++2,
 libpugixml1v5,
 libc6 (>= 2.40)
Description: An XDG Desktop Portal backend for Hyprland." >> DEBIAN/control

echo "Format: https://www.debian.org/doc/packaging-manuals/copyright-format/1.0/
Upstream-Name: ${project}
Source: https://github.com/hyprwm/${project}/tree/v${version}
Files: *
Copyright: 2024, Hypr Development
Licence: BSD 3-Clause License" >> DEBIAN/copyright

cd .. 
dpkg -b ${project}-${version}-${revision}

mv ${project}-${version}-${revision}.deb ../

