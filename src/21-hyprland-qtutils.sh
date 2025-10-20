#!/bin/bash
version="0.1.5"
project="hyprland-qtutils"

apt install qt6-base-dev qt6-declarative-dev qt6-wayland-dev qt6-wayland-private-dev qt6-base-private-dev -y

cd build
rm -Rf $project*	

git clone --recursive -b v$version https://github.com/hyprwm/${project}.git ${project}
cd ${project} 

cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`

cmake --install build

mkdir ${project}-${version}
cd ${project}-${version}
mkdir -p usr/bin

mv ../build/utils/dialog/hyprland-dialog               usr/bin/
mv ../build/utils/donate-screen/hyprland-donate-screen usr/bin/
mv ../build/utils/update-screen/hyprland-update-screen usr/bin/

mkdir DEBIAN

# il manque des dependance !

echo "Source: ${project}
Section: graphics
Priority: optional
Maintainer: Shionn<shionn@gmail.com>
Homepage: https://github.com/hyprwm/${project}
Package: ${project}
Version: ${version}
Architecture: amd64
Depends: hyprland-qt-support
Description: some qt/qml utilities that might be used by various hypr* apps." >> DEBIAN/control

echo "Format: https://www.debian.org/doc/packaging-manuals/copyright-format/1.0/
Upstream-Name: ${project}
Source: https://github.com/hyprwm/${project}/tree/v${version}
Files: *
Copyright: 2024, Hypr Development
Licence: BSD 3-Clause License" >> DEBIAN/copyright

cd .. 
dpkg -b ${project}-${version}

mv ${project}-${version}.deb ../

