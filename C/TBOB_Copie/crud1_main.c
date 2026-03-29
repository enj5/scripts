#include "crud1_salle.h"
#include "crud1_structs.h"
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <conio.h> // Nécessaire pour getch() sur Windows


int main(int argc, char const *argv[])
{

    //Variables génériques
    int i, j, n, m, nS;
    char menu, keep, choix;
    Room tab_Room[26]; //Tableau des salles
    Room spawner, itRoom, bRoom, itRoomB; //Salles spéciales
    

    //Boucle unique des actions du menu
    do
    {
        system("cls");
        //Title
        printf("\n--- CRUD des pieces du donjon---\n\n");
        //Affichage du menu
        
        printf("Menu :\n");
        printf("(10 salles par defaut sont existantes)\n");
        printf("(Tapez le numero correspondant a l'action de votre choix)\n\n");
        printf("1- Afficher les salles\n");
        printf("2- Creer une nouvelle salle\n"); //Juste créer une salle vide nxm avec un id = nS+1. Les ajouts d'obstacles se feront dans le 3.Modifier
        printf("3- Modifier une salle\n");
        printf("4- Supprimer une salle\n");
        printf("5- Quitter\n");
        do
        {
            printf("\nEntrer votre choix (1|2|3|4|5) : ");
            scanf(" %c", &menu);
        } while(menu != '1' && menu != '2' && menu != '3' && menu != '4' && menu != '5');
        printf("\n\n");

        //Chargement du fichier dans le tableau des salles
        FILE* fich = fopen("salles.rtbob", "r+"); // Ouverture du fichier en lecture et en écriture
            //Chargement du contenu dans le tableau des salles
        if(fich != NULL){
            fscanf(fich, "{%d}\n", &nS); //Lecture nbre de salles
            for(i = 0; i < nS; i++){
                ReadInFile(&tab_Room[i], fich); //Lecture de chaque salle
            }
            //fclose(fich);
        }
    
        switch(menu)
        {
            case '1':
                //FILE* fich = fopen("salles.rtbob", "r"); // Ouverture du fichier en lecture
                
                printf("{%d}\n", nS);
                for(i = 0; i < nS; i++){
                    printf("[%d|%d]%d\n", tab_Room[i].height, tab_Room[i].width, tab_Room[i].id);
                    show(tab_Room[i]); //Affichage de la salle dans la console
                }
                //fclose(fich);
                //Liberation de l'espace alloue
                for(i = 0; i < nS; i++)
                    freeR(&tab_Room[i]);
                
                break;
            case '2':
                /* code */
                break;
            case '3':
                char on;
                int num;
                //MODIFICATION DES OBSTACLES
                printf("\n");
                printf("Entrer le numero de la salle");
                do{
                    printf("\n[1, %d] : ", nS); //Restriction au nombre de salle existant
                    scanf(" %d", &num);
                    /*
                    while(scanf(" %d", &num) == 0){
                        printf("\n[1, %d] : ", nS);
                        while(getchar() != '\n') //vider le buffer
                            printf("\n[1, %d] : ", nS);
                    }
                    */  //TENTATIVE D'IMPOSER L'ENTRER D'UNE VALEUR ENTIERE! A REVOIR
                }while(num < 1 || num > nS);

                //Modification de la salle
                modif(&tab_Room[num-1], num);
                
                //Reecriture dans le fichier
                //rewind(fich); //Retour au début du fichier
                fclose(fich);//Fermeture pour vider le fichier avant de reecrire 
                fich = fopen("salles.rtbob", "w+");   
                fprintf(fich, "{%d}\n", nS);
                for(i = 0; i < nS; i++){    
                    WriteInFile(&tab_Room[i], fich);
                }
                        
    
                break;
            case '4':
                /* code */
                break;
            case '5':
                /* code */
                break;
            default:
                break;
        }
        fclose(fich);
        do
        {
            printf("\nRetourner au Menu --> Tapez R | Quitter --> Tapez Q : ");
            scanf(" %c", &keep);
        } while (keep != 'R' && keep != 'Q');
    } while (keep == 'R');


    //TEST LECTURE DANS UN FICHIER
    
    

    //TEST SUPPRESSION DANS UN FICHIER
    //DelInFile(4, nS);
    


    /*
    FILE* f = fopen("salles.rtbob", "w+");
    //TEST ECRITURE DANS UN FICHIER
    if(f != NULL){
        fprintf(f, "{%d}\n", nS);
        for(i = 0; i < nS; i++){
            creer(&tab_Room[i], i+1, n, m);    
            //printf("[%d|%d]%d\n", tab_Room[i].height, tab_Room[i].width, tab_Room[i].id);
            WriteInFile(&tab_Room[i], f);
        }
        fclose(f);
    }*/
    
    
    
    


    
    return 0;
}
