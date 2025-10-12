#!/bin/bash

mkdir -p docs/conf

echo "Origin: todo.com
Label: todo.com
Codename: forky
Architectures: amd64
Components: main
Description: Hyprland repository by shionn
SignWith: yes" > docs/conf/distributions

reprepro -b docs/ includedeb forky build/*.deb







