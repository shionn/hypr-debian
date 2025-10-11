#!/bin/bash
version="0.4.5"
project="hyprwayland-scanner"

apt install libpugixml-dev -y

rm -Rf $project*	
#mkdir ${project}-${version}
#cd ${project}-${version}

git clone --recursive -b v$version https://github.com/hyprwm/${project}.git ${project}-${version}

#cd ${project} 
#cmake -DCMAKE_INSTALL_PREFIX=/usr -B build
#cmake --build build -j `nproc`
#cd ..

mkdir debian

echo "Source: ${project}
Section: graphics
Priority: optional
Maintainer: Shionn<shionn@gmail.com>
Build-Depends: cmake, debhelper, dh-cmake, libpugixml-dev
Standards-Version: ${version}
Homepage: https://github.com/hyprwm/hyprwayland-scanner

Package: ${project}
Architecture: amd64
Depends: libpugixml1v5
Description: A Hyprland implementation of wayland-scanner, in and for C++." >> debian/control


echo "${project} (${version}) unstable; urgency=low 

 [ Shionn ]
 * release ${version}

-- Shionn <shionn@gmail.com> $(date)" > debian/changelog

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

echo "Format: https://www.debian.org/doc/packaging-manuals/copyright-format/1.0/
Upstream-Name: ${project}
Source: https://github.com/hyprwm/hyprwayland-scanner/tree/v0.4.5

Licence: BSD 3-Clause License
Files: *
Copyright: 2024, Hypr Development" > debian/copyright

echo "13" > debian/compat

debuild -us -uc

