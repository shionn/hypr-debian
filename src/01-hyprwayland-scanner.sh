#!/bin/bash
version="0.4.5"
project="hyprwayland-scanner"

apt install libpugixml-dev -y

cd build
rm -Rf $project*	

git clone --recursive -b v$version https://github.com/hyprwm/${project}.git ${project}
cd ${project} 

cmake -DCMAKE_INSTALL_PREFIX=/usr -B build
cmake --build build -j `nproc`
cmake --install build

mkdir ${project}-${version}
cd ${project}-${version}
mkdir -p usr/bin
cp ../build/hyprwayland-scanner usr/bin/

mkdir DEBIAN

echo "Source: ${project}
Section: graphics
Priority: optional
Maintainer: Shionn<shionn@gmail.com>
Homepage: https://github.com/hyprwm/${project}
Package: ${project}
Version: ${version}
Architecture: amd64
Depends: libpugixml1v5
Description: A Hyprland implementation of wayland-scanner, in and for C++." >> DEBIAN/control

echo "Format: https://www.debian.org/doc/packaging-manuals/copyright-format/1.0/
Upstream-Name: ${project}
Source: https://github.com/hyprwm/${project}/tree/v${version}
Files: *
Copyright: 2024, Hypr Development
Licence: BSD 3-Clause License" >> DEBIAN/copyright

cd .. 
dpkg -b ${project}-${version}

mv ${project}-${version}.deb ../

