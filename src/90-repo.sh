#!/bin/bash

mkdir -p docs/conf

echo "Origin: shionn.github.io/hypr-debian
Label: shionn.github.io/hypr-debian
Codename: forky
Architectures: amd64 i386
Components: main
Description: Hyprland repository by shionn
SignWith: yes" > docs/conf/distributions

reprepro -b docs/ includedeb forky build/*.deb







