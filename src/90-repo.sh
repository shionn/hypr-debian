#!/bin/bash

mkdir -p docs/conf

echo "Origin: shionn.github.io/hypr-debian
Label: shionn.github.io/hypr-debian
Codename: forky
Architectures: amd64 i386
Components: main
Description: Hyprland repository by shionn
SignWith: yes

Origin: shionn.github.io/hypr-debian
Label: shionn.github.io/hypr-debian
Codename: experimental
Architectures: amd64 i386
Components: main
Description: Hyprland repository by shionn
SignWith: yes
" > docs/conf/distributions

mkdir -p build/experimental
mkdir -p build/forky

mv build/*~*.deb build/experimental/
mv build/*.deb build/forky/

reprepro -b docs/ includedeb forky build/forky/*.deb
reprepro -b docs/ includedeb experimental build/experimental/*.deb

rm build/experimental/*.deb
rm build/forky/*.deb




