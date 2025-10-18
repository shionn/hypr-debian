#!/bin/bash 
apt remove *-dev wayland-protocols hwdata qml6-* qt6-* qml-qt6 -y | grep -v selecting | grep -v "not installed"
apt remove cmake build-essential pkg-config lintian -y
apt autoremove -y

