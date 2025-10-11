#!/bin/bash
apt update
apt install git cmake build-essential  -y
# poru resoudre les dependance CMAKE
apt install pkg-config -y
# pour construire les package
apt install devscripts dh-cmake -y
