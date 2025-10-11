#!/bin/bash
version="0.1.13"
project="hyprcursor"

apt install libcairo2-dev libzip-dev librsvg2-dev libtomlplusplus-dev -y

rm -Rf $project*	

git clone --recursive -b v$version https://github.com/hyprwm/${project}.git ${project}
cd ${project} 

cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
#cmake --install build

mkdir ${project}-${version}
cd ${project}-${version}
mkdir -p usr/lib/x86_64-linux-gnu/
mv ../build/libhyprcursor.so* usr/lib/x86_64-linux-gnu/
mkdir -p usr/bin/
mv ../build/hyprcursor-util usr/bin/

mkdir DEBIAN

echo "Source: ${project}
Section: graphics
Priority: optional
Maintainer: Shionn<shionn@gmail.com>
Homepage: https://github.com/hyprwm/${project}
Package: ${project}
Version: ${version}
Architecture: amd64
Depends: hyprlang, libcairo2, libzip5, librsvg2-2, libtomlplusplus3t64
Description: The hyprland cursor format, library and utilities." >> DEBIAN/control

echo "Format: https://www.debian.org/doc/packaging-manuals/copyright-format/1.0/
Upstream-Name: ${project}
Source: https://github.com/hyprwm/${project}/tree/v${version}
Files: *
Copyright: 2024, Hypr Development
Licence: BSD 3-Clause License" >> DEBIAN/copyright

cd .. 
dpkg -b ${project}-${version}

mv ${project}-${version}.deb ../

