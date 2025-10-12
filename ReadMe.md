
# Repo hyprland pour debian

Attention je ne suis pas un spécialiste de la construction de paquets, tout n'est pas fait dans les règles de l'art. 
Il faut avoir activer les repos **forky (testing)** ou **sid(unstable)**. 

# Installation 

~~~bash
wget https://shionn.github.io/hypr-debian/pool/main/h/hypr-debian-keyring/hypr-debian-keyring_1.0.0_all.deb
sudo apt install hypr-debian-keyring_1.0.0_all.deb
sudo apt update
sudo apt install hyprland
~~~

# Historique récent

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

# Lien

- [Le repo officiel de Hyperland](https://github.com/hyprwm)
- [Mon Blog](https://shionn.github.io)


