#include "crud1_salle.h"
#include "crud1_structs.h"
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <conio.h> // Nécessaire pour getch() sur Windows


int main(int argc, char const *argv[])
{

    FILE* fich = fopen("salles.rtbob", "r"); // Ouverture du fichier en lecture
    //Variables génériques
    int i, j, n = 9, m = 15, nS = 10;
    char menu, choix;
    Room tab_Room[26]; //Tableau des salles
    Room spawner, itRoom, bRoom, itRoomB; //Salles spéciales

    //Title
    printf("\n--- CRUD des pieces du donjon---\n\n");
         
    //Affichage du menu
    do
    {
        printf("Menu :\n");
        printf("(10 salles par defaut sont existantes)\n");
        printf("(Tapez le numero correspondant à l'action de votre choix)\n\n");
        printf("1- Afficher les salles\n");
        printf("2- Creer une nouvelle salle\n");
        printf("3- Modifier une salle\n");
        printf("4- Supprimer une salle\n");
        printf("5- Supprimer une salle\n");
        printf("\nEntrer votre choix :");
        scanf(" %c", &menu);
    } while(menu != 1 && menu != 2 && menu != 3 && menu != 4 && menu != 5);

    switch (menu)
    {
    case '1':
        if(fich != NULL){
            fscanf(fich, "{%d}\n", &nS); //Lecture nbre de salles
            //printf("{%d}\n", nS);
            for(i = 0; i < nS; i++){
                ReadInFile(&tab_Room[i], fich);
                printf("[%d|%d]%d\n", tab_Room[i].height, tab_Room[i].width, tab_Room[i].id);
                show(tab_Room[i]);
            }
            fclose(fich);
        }
        break;
    case '2':
        /* code */
        break;
    case '3':
        /* code */
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
    

    /*
    char on;
    int num;
    //MODIFICATION DES OBSTACLES
    do{
        printf("Voulez-vous modifier une salle? (o/n) : ");
        scanf(" %c", &on);
        printf("\n");
    }while((on != 'o' && on != 'n'));

    if(on == 'o'){
        do{
            printf("\n");
            printf("Entrer le numero de la salle\n");
            printf("[1, 10] : ");
            scanf(" %d", &num);
        }while(num != 1 && num != 2 && num != 3 && num != 4 && num != 5 && num != 6 && num != 7 && num != 8 && num != 9 && num != 10 );
        
        modif(&tab_Room[num-1], num);
        show(tab_Room[num-1]);

    
    }*/
    
    


    

    
    for(i = 0; i < nS; i++)
        freeR(&tab_Room[i]);
    
    
    return 0;
}
