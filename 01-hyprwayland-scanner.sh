#!/bin/bash
version="0.4.5"
project="hyprwayland-scanner"

apt install libpugixml-dev -y

rm -Rf $project*	
git clone --recursive -b v$version https://github.com/hyprwm/${project}.git ${project}-${version}
cd ${project}-${version}

#cmake -DCMAKE_INSTALL_PREFIX=/usr -B build
#cmake --build build -j `nproc`

mkdir debian

echo "Source: ${project}
Section: graphics
Priority: optional
Maintainer: Shionn<shionn@gmail.com>
Build-Depends: cmake, debhelper, libpugixml-dev

Package: ${project}
Version: ${version}
Architecture: amd64
Depends: libpugixml1v5
Description: A Hyprland implementation of wayland-scanner, in and for C++." >> debian/control


echo "${project} (${version}) trixie; 2025-07-07
	* release ${version}" > debian/changelog

echo "#!/usr/bin/make -f

%:
	dh \$@

override_dh_auto_install:
	dh_auto_install --destdir=\$(DEB_DESTDIR)

build:
	cmake -DCMAKE_INSTALL_PREFIX=/usr -B build
	cmake --build build -j `nproc`

install:
	cmake -DCMAKE_INSTALL_PREFIX=/usr -B build
	cmake --build build -j `nproc`
	cmake --install build
	
clean:
	rm -rf build
" > debian/rules



