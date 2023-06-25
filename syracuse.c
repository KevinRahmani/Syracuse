#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int Transformation(char mot)    //fonction qui transforme un caractère donné en nombre par rapport à la table d'ascii
{
    return (int)mot-48;
}

int CharToInt(char *nombre)
{
    int res = 0;

    for(int i=0; i<strlen(nombre); i++)
    {
        res =res*10 + Transformation(nombre[i]);
    }

    return res;
}

void VerifNombreEntier(char *mot)
{
    for(int i=0; i<strlen(mot);i++)
    {
        int a=mot[i];
        if(a < 48 || a > 57)
        {
            printf("Veuillez rentrer un nombre dans l'argument 1\n");
            exit(EXIT_FAILURE);
        }
    } 
}

int main (int argc, char **argv)
{

    if(argc != 3)                                                           //Vérification du bon nombre d'arguments
    {
        printf("Veuillez rentrer le bon nombre d'arguments");
        exit(EXIT_FAILURE);
    }


    char *tmp=malloc(sizeof(char));                                        //création d'une variable tmp qui va verifier si argv[2] est au bon format, on utilise pour ca strcpy et strcmp qui vont concatener la lettre f argv[1] et .dat
    strcat(strcpy(tmp, "f"),argv[1]);
    strcat(tmp, ".dat");
    VerifNombreEntier(argv[1]);                                            


    if(strcmp(argv[2], tmp) !=0)                                           
    {
        printf("Veuillez rentrer le bon format de l'argument 2\n");
        exit(EXIT_FAILURE);
    }
    

    if(strcmp(argv[1], "0") == 0)                                          //on veille à ne pas rentrer de 0 sinon plus d'interet 
        {
            printf("Veuillez ne pas rentrer de 0 svp\n");
            exit(EXIT_FAILURE);
        }

    else                                                                    // si toutes les vérifications sont faites on rentre dans le programme
    {
        char *word=malloc(sizeof(argv[1]));                                 //allocation d'espace mémoire pour argv[1]

        FILE *fichier = fopen(argv[2], "w+");                               //ouverture du fichier en mode écriture/lecture

        if(word == NULL)                                                    //vérification de la bonne allocation mémoire
        {
            printf("Erreur allocation mémoire");
            exit(EXIT_FAILURE);
        }
        int Un = CharToInt(argv[1]);                                        //déclaration des variables necessaires au prog 
        int U0 = Un;
        int altitudeMax = Un;
        int dureeVol = 0;
        int dureeAltitude = 0;
        int maxdA = 0;

        fprintf(fichier, "n Un\n");                                         //présentation au format demandé avec n et un + U0 et N0
        fprintf(fichier, "%d %d\n", dureeVol, U0);
        while(Un != 1)                                                      //condition d'arrêt si un n'est plus divisible par 2 car = 1
        {
            if(Un%2 == 0)                                                   //si paire alors on rentre dans cette boucle, on divise par 2 et on incrémente la durée de vol à chaque boucle if 
            {   
                Un = Un/2;
                dureeVol++;
                if(Un>altitudeMax)
                {
                    altitudeMax=Un;                                         //si oui alors on prend altitude Max
                }
                if (U0 < Un)
                    dureeAltitude ++;
                if (Un < U0)
                {
                    if (maxdA<dureeAltitude)
                    {
                        maxdA = dureeAltitude;
                        dureeAltitude = 0;
                    }
                }          
                fprintf(fichier, "%d %d\n", dureeVol, Un);                  //écriture de n en fonction de dureeVol et de Un en fonction de lui même
            }
            else
            {
                Un=Un*3+1;                                                  //else -> nombre impaire
                dureeVol++;
                if(Un>altitudeMax)
                {
                    altitudeMax=Un;                                         //si oui alors un prend altitude Max
                }
                if (U0 < Un)
                    dureeAltitude ++;
                if (Un < U0)
                {
                    if (maxdA<dureeAltitude)
                    {
                        maxdA = dureeAltitude;
                        dureeAltitude = 0;
                    }
                }
                fprintf(fichier, "%d %d\n", dureeVol, Un);
            }
        }
        fprintf(fichier, "altimax = %d\n", altitudeMax);                    //écriture des variables
        fprintf(fichier, "dureevol = %d\n", dureeVol);
        fprintf(fichier, "dureealtitude = %d", maxdA);

    fclose(fichier);

    return 0;
    }
}
