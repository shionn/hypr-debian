#!/bin/bash
version="0.2.0"
project="hyprgraphics"

apt install libcairo2-dev libpixman-1-dev libmagic-dev libjpeg-dev libwebp-dev librsvg2-dev -y

rm -Rf $project*	

git clone --recursive -b v$version https://github.com/hyprwm/${project}.git ${project}
cd ${project} 

cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`
cmake --install build

mkdir ${project}-${version}
cd ${project}-${version}
mkdir -p usr/lib/x86_64-linux-gnu/
mv ../build/libhyprgraphics.so* usr/lib/x86_64-linux-gnu/

mkdir DEBIAN

echo "Source: ${project}
Section: graphics
Priority: optional
Maintainer: Shionn<shionn@gmail.com>
Homepage: https://github.com/hyprwm/${project}
Package: ${project}
Version: ${version}
Architecture: amd64
Depends: hyprutils, libcario2, libmagic-mgc, libmagic1t64, libjpeg62-turbo, libwebp7, librsvg2-2, libjpeg62-turbo
Description: Hyprgraphics is a small C++ library with graphics / resource related utilities used across the hypr* ecosystem." >> DEBIAN/control

echo "Format: https://www.debian.org/doc/packaging-manuals/copyright-format/1.0/
Upstream-Name: ${project}
Source: https://github.com/hyprwm/${project}/tree/v${version}
Files: *
Copyright: 2024, Hypr Development
Licence: BSD 3-Clause License" >> DEBIAN/copyright

cd .. 
dpkg -b ${project}-${version}

mv ${project}-${version}.deb ../

