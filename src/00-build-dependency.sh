#!/bin/bash
apt update
apt install git cmake build-essential  -y
# poru resoudre les dependance CMAKE
apt install pkg-config -y
# pour verifier la construction du packe
apt install lintian -y

# pour le repo
apt install reprepro
