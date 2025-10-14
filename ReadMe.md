
# Repo hyprland pour debian

Attention je ne suis pas un spécialiste de la construction de paquets, tout n'est pas fait dans les règles de l'art. 
Il faut avoir activer les repos **Debian 13 forky (testing)** ou **Debian sid (unstable)**. 

# Installation 

~~~bash
wget https://shionn.github.io/hypr-debian/pool/main/h/hypr-debian-keyring/hypr-debian-keyring_1.0.0_all.deb
sudo apt install ./hypr-debian-keyring_1.0.0_all.deb
sudo apt update
sudo apt install hyprland
~~~

Le but de ce repo n'est pas de vous fournir un guide d'installation des dépendance ni de configuration de hyprland. 
Je propose simplement des paquet avec une mise à jour plus récente. 


# Version courante

- aquamarine : 0.9.5
- hyprcursor : 0.1.13
- hyprgraphics : 0.2.0
- **hyprland : 0.51.1**
- hyprland-qt-support : 0.1.0
- hyprland-qtutils : 0.1.5
- hyprlang : 0.6.4
- Hyprpolkitagent : 0.1.3
- hyprutils : 0.10.0
- hyprwayland-scanner : 0.4.5


# Historique récent

- 14/10/2025 : Hyprpolkitagent
- 12/10/2025 : Construction initial du repo

# Construction 

Pour reconstruire votre repo executer les scripts present dans src dans l'ordre des index. 

~~~bash
./src/00-....
...
./src/89-... <fingerprint>
...
./src/99-....
~~~ 

Pour avoir le fingerprint : `gpg --list-secret-key` et recuperer le truc dans pub.

# Todo

a faire en priorité : 
- hyprpaper : wallpaper
- xdg-desktop-portal-hyprland : une histoire de dbus
- hyprqt6engine : qt6 encore
- hyprshot ?


# Lien

- [Le repo officiel de Hyperland](https://github.com/hyprwm)
- [Mon Blog](https://shionn.github.io)


