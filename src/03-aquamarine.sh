#!/bin/bash
version="0.9.5"
project="aquamarine"
revision="5~pre0"

apt install libgles2-mesa-dev \
	libdisplay-info-dev \
	libdrm-dev \
	libinput-dev \
	libseat-dev \
	hwdata \
	libgbm-dev \
	libpixman-1-dev \
	libwayland-dev \
	wayland-protocols \
	libpugixml-dev -y

cd build
rm -Rf $project*	

git clone --recursive -b v$version https://github.com/hyprwm/${project}.git ${project}
cd ${project} 

cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`
cmake --install build

mkdir ${project}-${version}-${revision}
cd ${project}-${version}-${revision}
mkdir -p usr/lib/x86_64-linux-gnu/
mv ../build/libaquamarine.so* usr/lib/x86_64-linux-gnu/

mkdir DEBIAN

echo "Source: ${project}
Section: graphics
Priority: optional
Maintainer: Shionn<shionn@gmail.com>
Homepage: https://github.com/hyprwm/${project}
Package: ${project}
Version: ${version}-${revision}
Architecture: amd64
Depends: hyprwayland-scanner (>=0.4.0), hyprutils (>=0.8.0), 
 libgles2, libgles1, 
 libdisplay-info2, 
 libdrm2, 
 libinput10 (>=1.26.0), 
 libseat1 (>=0.8.0), 
 hwdata, 
 libgbm1, 
 libpixman-1-0,
 libwayland-client0,
 wayland-protocols, 
 libc6 (>=2.40),
 libpugixml1v5
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
dpkg -b ${project}-${version}-${revision}

mv ${project}-${version}-${revision}.deb ../

