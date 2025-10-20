#!/bin/bash
version="0.7.0"
project="hyprland-protocols"
revision="0~pre1"

cd build
rm -Rf $project*	

git clone -b v$version https://github.com/hyprwm/${project}.git ${project}
cd ${project} 

meson setup build
meson install -C build

mkdir ${project}-${version}-${revision}
cd ${project}-${version}-${revision}
mkdir -p usr/local/share/hyprland-protocols/protocols
mkdir -p usr/local/share/pkgconfig
cp ../protocols/*.xml usr/local/share/hyprland-protocols/protocols/
cp ../build/hyprland-protocols.pc usr/local/share/pkgconfig/

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
Description: Wayland protocol extensions for Hyprland.">> DEBIAN/control

echo "Format: https://www.debian.org/doc/packaging-manuals/copyright-format/1.0/
Upstream-Name: ${project}
Source: https://github.com/hyprwm/${project}/tree/v${version}
Files: *
Copyright: 2024, Hypr Development
Licence: BSD 3-Clause License" >> DEBIAN/copyright

cd .. 
dpkg -b ${project}-${version}-${revision}

mv ${project}-${version}-${revision}.deb ../

