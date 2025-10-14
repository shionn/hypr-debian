#!/bin/bash 
apt remove *-dev wayland-protocols hwdata -y
apt remove cmake build-essential pkg-config lintian -y
apt autoremove -y

