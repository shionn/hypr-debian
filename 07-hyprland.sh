#!/bin/bash
version="0.51.1"
project="Hyprland"

apt install libgles2-mesa-dev libcairo2-dev libinput-dev wayland-protocols libdrm-dev libpixman-1-dev -y

#rm -Rf $project*	

##git clone --recursive -b v$version https://github.com/hyprwm/${project}.git ${project}
cd ${project} 

make all
#make install

exit

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
Depends: aquamarine (>=0.9.3), hyprlang (>=0.3.2), hyprcursor (>=0.1.7), hyprutils (>=0.8.2), hyprgraphics (>=0.1.3), hyprwayland-scanner (>=0.3.10)
Description: Hyprland is a 100% independent, dynamic tiling Wayland compositor that doesn't sacrifice on its looks.
 It provides the latest Wayland features, is highly customizable, has all the eyecandy, the most powerful plugins, easy IPC, much more QoL stuff than other compositors and more..." >> DEBIAN/control

echo "Format: https://www.debian.org/doc/packaging-manuals/copyright-format/1.0/
Upstream-Name: ${project}
Source: https://github.com/hyprwm/${project}/tree/v${version}
Files: *
Copyright: 2024, Hypr Development
Licence: BSD 3-Clause License" >> DEBIAN/copyright

cd .. 
dpkg -b ${project}-${version}

mv ${project}-${version}.deb ../

