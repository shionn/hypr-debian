#!/bin/bash

mkdir -p repo/conf

echo "Origin: todo.com
Label: todo.com
Codename: forky
Architectures: amd64
Components: main
Description: Repo pour hyprland
SignWith: yes" > repo/conf/distributions

reprepro -b repo/ includedeb forky *.deb
#reprepro -b repo/ includedeb forky hyprwayland-scanner-0.4.5.deb
#reprepro -b repo/ includedeb forky hyprutils-0.10.0.deb
#reprepro -b repo/ includedeb forky aquamarine-0.9.5.deb  
#reprepro -b repo/ includedeb forky hyprlang-0.6.4.deb    
#reprepro -b repo/ includedeb forky hyprcursor-0.1.13.deb   
#reprepro -b repo/ includedeb forky hyprgraphics-0.2.0.deb  
#reprepro -b repo/ includedeb forky hyprland-0.51.1.deb   







