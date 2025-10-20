#!/bin/bash
version="0.1.7"
project="hypridle"
revision="0~pre1"

apt install libwayland-dev \
	wayland-protocols \
	libsdbus-c++-dev -y

cd build
rm -Rf $project*	

git clone -b v$version https://github.com/hyprwm/${project}.git ${project}
cd ${project} 

cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`

exit 

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
Depends: hyprlang (>=0.6.0), hyprutils (>=0.2.0), hyprwayland-scanner (>=0.4.4)
Description: Hyprland's idle daemon.">> DEBIAN/control

echo "Format: https://www.debian.org/doc/packaging-manuals/copyright-format/1.0/
Upstream-Name: ${project}
Source: https://github.com/hyprwm/${project}/tree/v${version}
Files: *
Copyright: 2024, Hypr Development
Licence: BSD 3-Clause License" >> DEBIAN/copyright

cd .. 
dpkg -b ${project}-${version}-${revision}

mv ${project}-${version}-${revision}.deb ../

