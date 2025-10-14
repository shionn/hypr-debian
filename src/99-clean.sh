#!/bin/bash 
apt remove *-dev wayland-protocols hwdata qml6-* qt6-* qml-qt6 -y
apt remove cmake build-essential pkg-config lintian -y
apt autoremove -y

