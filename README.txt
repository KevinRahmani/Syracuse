------------------------------------------------------------------------
----------------------------FICHIER README------------------------------
------------------------------------------------------------------------

Le code comprend un ensemble de 2 fichiers : 
'syracuse.bash'
'syracuse.c' 

Option en ligne de commande pour le script shell sont :
Pour afficher un manuel d'aide :         -h

---------------------------------------------
LANCER LE SCRIPT SUR UN INTERVALLE [ X - Y ] |
---------------------------------------------
Exemple ligne de commande :
    
   ./syracuse.bash 100 500

Exemple de sortie avec la ligne de commande :
	
  --->Dans le dossier 'Graphe-$X-$Y'

	'grapheAltitudeMax.jpeg'
	'grapheDureeDeVol.jpeg'
	'grapheDureeAltitude.jpeg'
	'grapheUnEnFonctionDeN.jpeg'

---------------------
AIDE D'UTILISATION : |
---------------------
Exemple ligne de commande :

      ./syracuse.bash -h

________________________________________________________________________________________________________________________________________________________________________
      
INFOS UTILES SUR LE PROGRAMME :

- Dans l'entré en ligne de commande des paramètres, toujours rentrer 2 chiffres/nombres entiers positifs avec
  le plus petit suivi du plus grand.
- Ce programme à été créée et sur la distribution Linux Debian, mais à été testé sur d'autre distribution Linux.
  comme Ubuntu(et est fonctionnel)
- Si vous lancer 2 fois l'exécution avec les même paramètres et qu'ils sont valides, les fichiers finaux de la première exécution seront supprimés
  et remplacés par ceux de la deuxième exécution.
