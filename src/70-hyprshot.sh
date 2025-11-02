#!/bin/bash
version="1.3.0"
project="hyprshot"
revision="0~pre1"

cd build
rm -Rf $project*	

git clone -b $version git@github.com:Gustash/Hyprshot.git ${project}
cd ${project} 

mkdir ${project}-${version}-${revision}
cd ${project}-${version}-${revision}
mkdir -p usr/local/bin/
cp ../hyprshot usr/local/bin/

mkdir DEBIAN

echo "Source: ${project}
Section: graphics
Priority: optional
Maintainer: Shionn<shionn@gmail.com>
Homepage: https://github.com/Gustash/Hyprshot
Package: ${project}
Version: ${version}-${revision}
Architecture: amd64
Depends: hyprland, slurp, grimi, libnotify-bin, weston 
Description: Hyprshot is an utility to easily take screenshot in Hyprland using your mouse.">> DEBIAN/control

echo "Format: https://www.debian.org/doc/packaging-manuals/copyright-format/1.0/
Upstream-Name: ${project}
Source: https://github.com/Gustash/Hyprshot/tree/${version}
Files: *
Copyright: 
Licence: GNU GPL V3" >> DEBIAN/copyright

cd .. 
dpkg -b ${project}-${version}-${revision}

mv ${project}-${version}-${revision}.deb ../

