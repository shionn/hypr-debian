#!/bin/bash
version="0.1.3"
project="hyprpolkitagent"
revision="1"

apt install libpolkit-agent-1-dev libpolkit-qt6-1-dev qt6-tools-dev qt6-tools-dev-tools  qt6-base-dev qt6-declarative-dev qml6-module-qtquick-controls qml6-module-qtquick-layouts -y

cd build
rm -Rf $project*	

git clone --recursive -b v$version https://github.com/hyprwm/${project}.git ${project}
cd ${project} 

cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -DINSTALL_QML_PREFIX=/lib/x86_64-linux-gnu/qt6/qml -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`
cmake --install build

mkdir ${project}-${version}-${revision}
cd ${project}-${version}-${revision}
mkdir -p usr/libexec/
mkdir -p usr/lib/systemd/user/
mkdir -p usr/share/dbus-1/services/
cp ../build/hyprpolkitagent usr/libexec/
cp ../build/hyprpolkitagent.service usr/lib/systemd/user/
cp ../build/org.hyperland.hyprpolkitagent.service usr/shar/dbus-1/services/

mkdir DEBIAN

echo "Source: ${project}
Section: graphics
Priority: optional
Maintainer: Shionn<shionn@gmail.com>
Homepage: https://github.com/hyprwm/${project}
Package: ${project}
Version: ${version}-${revision}
Architecture: amd64
Depends: hyprutils, hyprland-qt-support, libpolkit-agent-1-0, libpolkit-qt6-1-1, qt6-wayland, qml6-module-qtquick-controls, qml6-module-qtquick-layouts 
Description: A simple polkit authentication agent for Hyprland, written in QT/QML." >> DEBIAN/control

echo "Format: https://www.debian.org/doc/packaging-manuals/copyright-format/1.0/
Upstream-Name: ${project}
Source: https://github.com/hyprwm/${project}/tree/v${version}
Files: *
Copyright: 2024, Hypr Development
Licence: BSD 3-Clause License" >> DEBIAN/copyright

cd .. 
dpkg -b ${project}-${version}-${revision}

mv ${project}-${version}-${revision}.deb ../

