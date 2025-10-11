#!/bin/bash
apt remove libpugixml-dev libpixman-1-dev libgles2-mesa-dev libseat-dev libinput-dev wayland-protocols libwayland-dev libdrm-dev libgbm-dev libdisplay-info-dev hwdata libcairo2-dev libzip-dev libtomlplusplus-dev libmagic-dev libwebp-dev librsvg2-dev libjpeg-dev -y
apt remove cmake build-essential pkg-config lintian -y
apt autoremove -y

