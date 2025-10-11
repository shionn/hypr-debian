#!/bin/bash
version="0.9.5"
project="aquamarine"

apt install libgles2-mesa-dev libseat-dev libinput-dev wayland-protocols libwayland-dev libpixman-1-dev libdrm-dev libgbm-dev libdisplay-info-dev hwdata libpugixml-dev -y

rm -Rf $project*	

git clone --recursive -b v$version https://github.com/hyprwm/${project}.git ${project}
cd ${project} 

cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
cmake --install build

mkdir ${project}-${version}
cd ${project}-${version}
mkdir -p usr/lib/x86_64-linux-gnu/
mv ../build/libaquamarine.so* usr/lib/x86_64-linux-gnu/

mkdir DEBIAN

echo "Source: ${project}
Section: graphics
Priority: optional
Maintainer: Shionn<shionn@gmail.com>
Homepage: https://github.com/hyprwm/${project}
Package: ${project}
Version: ${version}
Architecture: amd64
Depends: hyprwayland-scanner, hyprutils (>=0.8.0), libgles2, libseat1, libinput10, wayland-protocols, libwayland-bin, libwayland-cursor0, libwayland-egl1, libdrm-amdgpu1, libdrm-intel1, libdrm-nouveau2, libdrm-radeon1, libgbm1, libdisplay-info2, hwdata 
Description: Aquamarine is a very light linux rendering backend library. It provides basic abstractions for an application to render on a Wayland session (in a window) or a native DRM session.
 It is agnostic of the rendering API (Vulkan/OpenGL) and designed to be lightweight, performant, and minimal.
 Aquamarine provides no bindings for other languages. It is C++-only." >> DEBIAN/control

echo "Format: https://www.debian.org/doc/packaging-manuals/copyright-format/1.0/
Upstream-Name: ${project}
Source: https://github.com/hyprwm/${project}/tree/v${version}
Files: *
Copyright: 2024, Hypr Development
Licence: BSD 3-Clause License" >> DEBIAN/copyright

cd .. 
dpkg -b ${project}-${version}

mv ${project}-${version}.deb ../

