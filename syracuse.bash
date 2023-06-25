#!/bin/bash
if [ $# -gt 2 ]                                 ## Vérification qu'il n'y ai pas + de 2 paramètres/arguments
then 
   echo "Il y a trop d'arguments"               ## Affiche message d'erreur 
fi
if [ $# -eq 2 ]                                 ## Vérification si le nombre paramètres/arguments est bien égale à 2
then 
   if [ "$(echo $1 | grep "^[ [:digit:] ]*$")" ] && [ "$(echo $2 | grep "^[ [:digit:] ]*$")" ] ## Vérification que les paramètres/arguments soit bien des chiffres/nombres
   then     
      if [ $1 -ge $2 ] || [ $1 -le 1 ]                                ## Vérification que le premier paramètre/argument soit bien inférieux au deuxième paramètre/argument
      then
	      echo "Erreur lors de l'entré des paramètres, vous êtes redirigé vers un manuel d'aide"           ## Affiche message d'erreur 
	      ./$0 -h                                                                                          ## Redirige vers le manuel d'aide 
      else  
         if [ -d tempo ]                            ## Vérification si le dossier "tempo" existe 
         then
            rm -r tempo                             ## Si le dossier "tempo" existe, il le supprime
         fi
         if [ -d tempo2 ]                           ## Vérification si le dossier "tempo2" existe 
         then 
            rm -r tempo2                            ## Si le dossier "tempo2" existe, il le supprime                 
         fi
         if [ -d Graphe-$1-$2 ]                     ## Vérification si le dossier "Graphe-(premier paramètre)-(deuxième paramètre)" existe 
         then 
            rm -r Graphe-$1-$2                      ## Si le dossier existe, il le supprime
         fi
	 mkdir tempo                                ## Créer le dossier "tempo"
         mkdir tempo2                               ## Créer le dossier "tempo2"
         mkdir Graphe-$1-$2                         ## Créer le dossier "Graphe-(premier paramètre)-'deuxième paramétre)"
         gcc syracuse.c -o syracuse                 ## Compilation du programme syracuse.c
         for var in `seq $1 $2`                     ## Lancement d'une boucle for pour var allant du premier paramètre au deuxième paramètre
         do
            ./syracuse $var f$var.dat               ## Lance l'éxécution du programme syracuse.c avec comme paramètre la valeur de la variable var et comme deuxième paramètre un fichier de la forme f(valeur de var).dat
            mv f$var.dat tempo                      ## Déplace le fichier généré dans le dossier "tempo"
	      done
         for i in $(seq $1 1 $2)                    ## Lancement d'une boucle for pour i allant du premier paramètre au deuxième paramètre
         do 
            echo "$i `tail -n -3 tempo/f$i.dat | cut -d ' ' -f3 | sed -n '1p'`"  >> altitudeMax.dat      ##Récupère la valeur d'altitude maximum dans le fichier f$i.dat et l'ajoute dans un fichier altitudeMax.dat
            echo "$i `tail -n -3 tempo/f$i.dat | cut -d ' ' -f3 | sed -n '2p'`"  >> dureeVol.dat         ##Récupère la valeur de durée de vol dans le fichier f$i.dat et l'ajoute dans un fichier dureeVol.dat
            echo "$i `tail -n -3 tempo/f$i.dat | cut -d ' ' -f3 | sed -n '3p'`"  >> dureeAltitude.dat    ##Récupère la valeur de durée de vol en altitude dans le fichier f$i.dat et l'ajoute dans un fichier dureeAltitude.dat
            echo "`grep -v -e"=" -e"n" tempo/f$i.dat`" > tempo2/f$i.dat                                  ##Copie un fichier similaire à f$i.dat sans la permière lignes et les 3 dernières lignes et le déplace dans le dossier "tempo2"
         done
         if [ -f altitudeMax.dat ]         ## Verificaton que le fichier altitudeMax.dat a bien été crée
         then
            echo -e "ALTITUDEMAX BONUS :\n" >> synthese-$1-$2.txt                                                      ##Ecriture dans le fichier de synthèse
            echo -e "Le minimum est : `cut -d " " -f2 altitudeMax.dat | sort -n | head -1`" >> synthese-$1-$2.txt      ##Ecriture dans le fichier de synthèse le minimum pour l'altitude maximum
            echo -e "Le maximum est : `cut -d " " -f2 altitudeMax.dat | sort -n -r | head -1`" >>synthese-$1-$2.txt    ##Ecriture dans le fichier de synthèse le maximum pour l'altitude maximum
            echo -e "La moyenne de l'altitude max est : `awk '{ sum+=$2;count++ } END { print (sum / count) }' altitudeMax.dat`\n\n" >> synthese-$1-$2.txt  ##Ecriture dans le fichier de synthèse la moyenne pour l'altitude maximum
         fi
         if [ -f dureeVol.dat ]              ## Verificaton que le fichier dureeVol.dat ai bien été créé   
         then 
            echo -e "DUREE VOL BONUS :\n" >> synthese-$1-$2.txt                                                   ##Ecriture dans le fichier de synthèse                       
            echo -e "Le minimum est : `cut -d " " -f2 dureeVol.dat | sort -n | head -1`" >> synthese-$1-$2.txt    ##Ecriture dans le fichier de synthèse le minimum pour La durée de vol
            echo -e "Le maximum est : `cut -d " " -f2 dureeVol.dat | sort -n -r | head -1`" >>synthese-$1-$2.txt  ##Ecriture dans le fichier de synthèse le maximum pour La durée de vol
            echo -e "La moyenne de la duree de vol est : `awk '{ sum+=$2;count++ } END { print (sum / count) }' dureeVol.dat`\n\n" >> synthese-$1-$2.txt  ##Ecriture dans le fichier de synthèse la moyenne pour La durée de vol
         fi
         if [ -f dureeAltitude.dat ]           ## Verificaton que le fichier dureeAltitude.dat ai bien été créé
         then 
            echo -e "DUREE ALTITUDE BONUS :\n" >> synthese-$1-$2.txt                                ##Ecriture dans le fichier de synthèse
            echo -e "Le minimum est : `cut -d " " -f2 dureeAltitude.dat | sort -n | head -1`" >> synthese-$1-$2.txt   ##Ecriture dans le fichier de synthèse le minimum pour La durée de vol en altitude
            echo -e "Le maximum est : `cut -d " " -f2 dureeAltitude.dat | sort -n -r | head -1`" >>synthese-$1-$2.txt  ##Ecriture dans le fichier de synthèse le maximum pour La durée de vol en altitude
            echo -e "La moyenne de la duree d'altitude est : `awk '{ sum+=$2;count++ } END { print (sum / count) }' dureeAltitude.dat`\n\n" >> synthese-$1-$2.txt  ##Ecriture dans le fichier de synthèse la moyenne pour La durée de vol en altitude
         fi                                                                                                           

gnuplot << EOF
   set terminal jpeg size 800,600    #Set la taille du graphe
   set output 'grapheAltitudeMax.jpeg'    #Indique le nom du fichier Graphique
   unset key 
   set title "Graphe AltitudeMax"        #Ajoute un titre au graphique
   set xlabel 'n'                        #Set l'axe des abscisses
   set ylabel 'Un'                       #Set l'axe des ordonnées
   set xrange [$1:$2]                    #Set la range de X
   plot "altitudeMax.dat" w l lt 1 lc 22  #Construction du graphique à partir du fichier altitudeMax.dat
   quit                                  #Quitte GNUPLOT
EOF
gnuplot << EOF
   set terminal jpeg size 800,600        #Set la taille du graphe
   set output 'grapheDureeDeVol.jpeg'    #Indique le nom du fichier Graphique
   unset key 
   set title "Graphe Durée de Vol"      #Ajoute un titre au graphique
   set xlabel 'n'                       #Set l'axe des abscisses
   set ylabel 'Un'                      #Set l'axe des ordonnées
   set xrange[$1:$2]                    #Set la range de X
   plot "dureeVol.dat" w l lt 1 lc 22   #Construction du graphique à partir du fichier dureeVol.dat
   quit                                 # Quitte GNUPLOT
EOF
gnuplot << EOF
   set terminal jpeg size 800,600         #Set la taille du graphe
   set output 'grapheDureeAltitude.jpeg'  #Indique le nom du fichier Graphique
   unset key
   set title "Graphe de la Durée en Altitude"  #Ajoute un titre au graphique
   set xlabel 'n'                              #Set l'axe des abscisses
   set ylabel 'Un'                             #Set l'axe des ordonnées
   set xrange[$1:$2]                           #Set la range de X
   plot"dureeAltitude.dat" w l lt 1 lc 22      #Construction du graphique à partir du fichier dureeAltitude.dat
   quit                                        # Quitte GNUPLOT
EOF
gnuplot << EOF   
   set terminal jpeg size 800,600           #Set la taille du graphe
   set output 'grapheUnEnFonctionDeN.jpeg'  #Indique le nom du fichier Graphique
   unset key
   set title "Graphe des Un en fonction de N"   #Ajoute un titre au graphique
   set xlabel 'n'                               #Set l'axe des abscisses
   set ylabel 'Un'                              #Set l'axe des ordonnées
   plot for[i=$1:$2]'tempo2/f'.i.'.dat' w l lt 1 lc 22 #Construction des graphiques de tous les fichiers contenu dans le repertoire "tempo2"
   quit                                         # Quitte GNUPLOT
EOF
         rm -r tempo              ##Supression des différents fichiers/dossiers 
         rm -r tempo2             ##Supression des différents fichiers/dossiers
         rm altitudeMax.dat       ##Supression des différents fichiers/dossiers
         rm dureeAltitude.dat     ##Supression des différents fichiers/dossiers
         rm dureeVol.dat          ##Supression des différents fichiers/dossiers
         mv grapheAltitudeMax.jpeg Graphe-$1-$2      ##Déplacement des graphiques dans le nouveau repertoire 
         mv grapheDureeAltitude.jpeg Graphe-$1-$2    ##Déplacement des graphiques dans le nouveau repertoire
         mv grapheUnEnFonctionDeN.jpeg Graphe-$1-$2  ##Déplacement des graphiques dans le nouveau repertoire
         mv grapheDureeDeVol.jpeg Graphe-$1-$2       ##Déplacement des graphiques dans le nouveau repertoire
         mv synthese-$1-$2.txt Graphe-$1-$2          ##Déplacement de la synthèse dans le nouveau repertoire
	   fi 
   else 
      echo "Erreur dans l'entrée des du paramètres, vous êtes redirigé vers un manuel d'aide"        ##Affiche message d'erreur 
      ./$0 -h                                                                                       ##Affiche le manuel d'aide 
   fi 
else 
  if [ "$1" == "-h" ]                ## Vérification si le premier paramètre/argument est bien "-h"
  then
     echo -e "Voici le manuel :\n\nPour éxécuter ce script, veuillez écrire dans votre terminal l'éxécutable en premier lieu avec le nom du script en n'oubliant pas son extension.\nEnsuite, veuillez rentrer 2 arguments qui sont des entiers positifs (supérieur strictement à 1) l'un à la suite de l'autre rangé dans l'ordre croissant tout en les séparant par un espace (le premier argument doit être plus petit que le deuxième).\n\nVoici un exemple d'utilisation : ./syracuse.bash 100 500\nMerci d'avoir lu "
  else                                                                                           ##Manuel d'aide juste au dessus       
     echo "Erreur dans l'entré des du paramètres, vous êtes redirigé vers un manuel d'aide"      ##Affiche message d'erreur 
     ./$0 -h                                                                                     ##Affiche le manuel d'aide 
  fi
fi
