
# Repo hyprland pour debian

Attention je ne suis pas un spécialiste de la construction de paquets, tout n'est pas fait dans les règles de l'art. 
Il faut avoir activer les repos **forky (testing)** ou **sid(unstable)**. 

# Installation 

~~~bash


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

(https://github.com/hyprwm)[https://github.com/hyprwm]


