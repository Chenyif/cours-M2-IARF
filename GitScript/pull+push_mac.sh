#!/bin/bash
# pause2.sh : appuyer sur une touche pour continuer un script

#on se place dans le repertoire principal
cd /Users/Wedge/Desktop/M2/cours-M2-IARF

#on fait un pull pour mettre à jour
git pull origin master

#on ajoute tous les fichiers à l'index
git add -A

echo "Entrez un nom de commit"

#on recupère le nom du commit saisi dans la variable nomCommit
read -r nomCommit

#on fait un commit pour valider les changements
git commit -m "$nomCommit"

#on envoie les changement
git push origin master


