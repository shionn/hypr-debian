#!/bin/bash
version="0.1.0"
project="hyprland-qt-support"

apt install qt6-base-dev qt6-declarative-dev -y

cd build
rm -Rf $project*	

git clone --recursive -b v$version https://github.com/hyprwm/${project}.git ${project}
cd ${project} 

mkdir ${project}-${version}
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=${project}-${version} -DINSTALL_QML_PREFIX=/lib/x86_64-linux-gnu/qt6/qml -S . -B ./build
#cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -DINSTALL_QML_PREFIX=/lib/x86_64-linux-gnu/qt6/qml -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`
cmake --install build

#mkdir ${project}-${version}
#cd ${project}-${version}
#mkdir -p usr/lib/x86_64-linux-gnu/qt6/
#mv ../build/src/style/impl/libhyprland-quick-style-impl.so  usr/lib/
#mv ../build/src/style/libhyprland-quick-style.so            usr/lib/
#mv ../build/qml usr/lib/x86_64-linux-gnu/qt6/

exit
mkdir DEBIAN

echo "Source: ${project}
Section: graphics
Priority: optional
Maintainer: Shionn<shionn@gmail.com>
Homepage: https://github.com/hyprwm/${project}
Package: ${project}
Version: ${version}
Architecture: amd64
Depends: hyprlang (>=0.6.0), qt6-wayland, qml6-module-qtcore, qml6-module-qtquick-layouts
Description: A qt6 qml style provider for hypr* apps." >> DEBIAN/control

echo "Format: https://www.debian.org/doc/packaging-manuals/copyright-format/1.0/
Upstream-Name: ${project}
Source: https://github.com/hyprwm/${project}/tree/v${version}
Files: *
Copyright: 2024, Hypr Development
Licence: BSD 3-Clause License" >> DEBIAN/copyright

cd .. 
dpkg -b ${project}-${version}

mv ${project}-${version}.deb ../

