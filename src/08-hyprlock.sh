#!/bin/bash
version="0.9.2"
project="hyprlock"
revision="pre1"

apt install libcairo2-dev \
	libegl-dev \
	libgles2-mesa-dev \
	libgbm-dev \
	libdrm-dev \
	libwayland-dev \
	wayland-protocols \
	libxkbcommon-dev \
	libpango1.0-dev \
	libpam0g-dev \
	libpugixml-dev \
	libjpeg-dev \
	libwebp-dev \
	librsvg2-dev \
	libsdbus-c++-dev -y

cd build
rm -Rf $project*	

git clone -b v$version https://github.com/hyprwm/${project}.git ${project}
cd ${project} 

cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -S . -B ./build
cmake --build ./build --config Release --target hyprlock -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
cmake --install build

mkdir ${project}-${version}-${revision}
cd ${project}-${version}-${revision}
mkdir -p usr/local/bin/
mkdir -p usr/local/etc/pam.d/
mkdir -p usr/local/share/hypr/
cp ../build/hyprlock  usr/local/bin/
cp ../pam/hyprlock usr/local/etc/pam.d/
cp ../assets/example.conf usr/local/share/hypr/hyprlock.conf

mkdir DEBIAN

echo "Source: ${project}
Section: graphics
Priority: optional
Maintainer: Shionn<shionn@gmail.com>
Homepage: https://github.com/hyprwm/${project}
Package: ${project}
Version: ${version}-${revision}
Architecture: amd64
Depends: hyprgraphics (>=0.1.6), hyprlang (>=0.6.0), hyprutils (>=0.8.0), hyprwayland-scanner (>=0.4.4), libcairo2, libgles1, libgles2, libegl1, libgbm1, libdrm2, libpangocairo-1.0.0, libwayland-client0, wayland-protocol (>=1.35), libwayland-egl1, libxkbcommon0, libsdbus-c++-bin (>=2.0.0), libpam0g, libpugixml1v5, libjpeg62-turbo, libwebp7, librsvg2-bin
Description: Hyprland's simple, yet multi-threaded and GPU-accelerated screen locking utility.">> DEBIAN/control

echo "Format: https://www.debian.org/doc/packaging-manuals/copyright-format/1.0/
Upstream-Name: ${project}
Source: https://github.com/hyprwm/${project}/tree/v${version}
Files: *
Copyright: 2024, Hypr Development
Licence: BSD 3-Clause License" >> DEBIAN/copyright

cd .. 
dpkg -b ${project}-${version}-${revision}

mv ${project}-${version}-${revision}.deb ../

