#!/bin/bash
version="1.3.11"
project="xdg-desktop-portal-hyprland"
revision="0~pre1"

apt install \
	libgbm-dev \
	libdrm-dev \
	libpipewire-0.3-dev \
	libspa-0.2-dev \
	libwayland-dev \
	wayland-protocols \
	-y

cd build
rm -Rf $project*	

git clone --recursive -b v$version https://github.com/hyprwm/${project}.git ${project}
cd ${project} 

cmake -DCMAKE_INSTALL_LIBEXECDIR=/usr/lib -DCMAKE_INSTALL_PREFIX=/usr -B build
cmake --build build
sudo cmake --install build

exit

mkdir ${project}-${version}-${revision}
cd ${project}-${version}-${revision}
mkdir -p usr/lib/x86_64-linux-gnu/
mv ../build/libaquamarine.so* usr/lib/x86_64-linux-gnu/

mkdir DEBIAN

echo "Source: ${project}
Section: graphics
Priority: optional
Maintainer: Shionn<shionn@gmail.com>
Homepage: https://github.com/hyprwm/${project}
Package: ${project}
Version: ${version}-${revision}
Architecture: amd64
Depends: 
 libgbm1, 
 libdrm2, 
 libpipewire-0.3-0t64 (>=1.1.82),
 libwayland-client0,
 wayland-protocols,
 hyprlang (>=0.2.0),
 hyprutils (>=0.8.0), 
 hyprwayland-scanner (>=0.4.0),
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

