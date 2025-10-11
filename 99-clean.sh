#!/bin/bash 
apt remove libpugixml-dev libpixman-1-dev libgles2-mesa-dev libseat-dev libinput-dev wayland-protocols libwayland-dev libdrm-dev libgbm-dev libdisplay-info-dev hwdata libcairo2-dev libzip-dev libtomlplusplus-dev libmagic-dev libwebp-dev librsvg2-dev libjpeg-dev libxkbcommon-dev libre2-dev libwayland-dev libgbm-dev libpango1.0-dev libxcursor-dev libxcb-xfixes0-dev libxcb-icccm4-dev libxcb-composite0-dev libxcb-res0-dev libxcb-errors-dev libglaze-dev -y
apt remove cmake build-essential pkg-config lintian -y
apt autoremove -y

