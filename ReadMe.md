
# Repo hyprland pour debian

Attention je ne suis pas un spécialiste de la construction de paquets, tout n'est pas fait dans les règles de l'art. 
Il faut avoir activer les repos **forky (testing)** ou **sid(unstable)**. 

# Installation 

~~~bash
wget -qO - http://todo.org/dists/forky/Release.gpg | sudo gpg --dearmor -vo /etc/apt/keyrings/hyprland-shionn.gpg
echo "deb [signed-by=/etc/apt/keyrings/hyprland-shionn.gpg] http://todo.org forky main" | sudo tee /etc/apt/sources.list.d/hyprland-shionn.list
~~~

# Historique récent

- 12/10/2025 : Construction initial du repo

# Construction 
Pour reconstruire votre repo executer les scripts present dans src dans l'ordre des index. 

~~~bash
./src/00-....
....
./src/99-....
~~~ 

# Lien

(https://github.com/hyprwm)[https://github.com/hyprwm]


