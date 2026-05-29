#!/usr/bin/env bash

#
# Auteur : Erwin NJINKOUE
# Date : Mai 2025
# Version 1.0.0 : Ecriture des rôles de chaque groupes dans chaque table

# Variables globales

# Parcours des tables

set_role() {
    local table_rls="$1"
    local colonne_rls="$2"
    local tablegold="$3"
    local colonnegold="$4"
    local nomgroupe="$5"

    # Décompte du nombre de ligne
    total=$(wc -l < C:/Git/TEST/"Rapport Self-Service Sécurisé.SemanticModel"/definition/roles/$nomgroupe.tmdl)
    ligne=$(( total - 3 )) # Récupération de la ligne d'insertion

    # Bloc à insérer fichier temporaire
    cat <<- EOF > bloc_temp.txt
    
    tablePermission $tablegold =
            VAR _codes =
                CALCULATETABLE(
                    VALUES($table_rls[$colonne_rls] ),
                    $table_rls[security_group] = "$nomgroupe"
                )
            VAR _isAll =
                NOT ISEMPTY( FILTER( _codes, [$colonne_rls] = "ALL" ) )
            RETURN
                _isAll
                || ISBLANK( $tablegold[$colonnegold] )
                || [$colonnegold] = ""
                || [$colonnegold] IN _codes

EOF
    # Insertion à la 4è ligne vers le bas
    sed -i "${ligne}r bloc_temp.txt" C:/Git/TEST/"Rapport Self-Service Sécurisé.SemanticModel"/definition/roles/$nomgroupe.tmdl
    rm bloc_temp.txt # Suppression du fichier temporaire

}

for GROUPE in $(cat listes_groupes.txt)
do
    for TABLE in $(cat listes_tables.txt)
    do 
        if [[ $TABLE =~ _vente_ ]]
        then
            table_rls="v_RLS_client_VKORG_CLIVEN"
            colonne_rls="vkorg_vente"
            case  $TABLE in
                "g_tarifs_vente_a901_bu_canaldistri_secacti_article")
                    set_role $table_rls $colonne_rls $TABLE "TARVEN901_Code_Organisation_Commerciale" $GROUPE
                    ;;
                "g_tarifs_vente_a952_bu_canaldistri_article")
                    set_role $table_rls $colonne_rls $TABLE "TARVEN952_Code_Organisation_Commerciale" $GROUPE
                    ;;
                "g_tarifs_vente_a952_bu_canaldistri_article")
                    set_role $table_rls $colonne_rls $TABLE "TARVEN952_Code_Organisation_Commerciale" $GROUPE
                    ;;
                "g_tarifs_vente_a902_bu_canaldistri_secacti_supportvente_article")
                    set_role $table_rls $colonne_rls $TABLE "TARVEN902_Code_Organisation_Commerciale" $GROUPE
                    ;;
                "g_tarifs_vente_a903_bu_canaldistri_secacti_client_article")
                    set_role $table_rls $colonne_rls $TABLE "TARVEN903_Code_Organisation_Commerciale" $GROUPE
                    ;;
                "g_tarifs_vente_a910_bu_canaldistri_secacti_hierarchie_article")
                    set_role $table_rls $colonne_rls $TABLE "TARVEN910_Code_Organisation_Commerciale" $GROUPE
                    ;;
                "g_tarifs_vente_a901_degressif_bu_canaldistri_secacti_article")
                    set_role $table_rls $colonne_rls $TABLE "TARDEGVEN901_Code_Organisation_Commerciale" $GROUPE
                    ;;
            esac
        fi
        
        if [[ $TABLE =~ _achat_ ]]
        then
            table_rls="v_RLS_EKORG"
            colonne_rls="ekorg"
            case  $TABLE in
                "g_tarifs_achat_a017_fournisseur_orgachat_division_article")
                    set_role $table_rls $colonne_rls $TABLE "TARACHT017_Code_Organisation_Achats" $GROUPE
                    ;;
                "g_tarifs_achat_a017_degressif_fournisseur_orgachat_division_article")
                    set_role $table_rls $colonne_rls $TABLE "TARDEGACHT017_Code_Organisation_Achats" $GROUPE
                    ;;
            esac
        fi
        
        if [[ $TABLE =~ _stocks_division_ ]]
        then
            set_role "v_RLS_WERKS_DIVISION" "werks_division" $TABLE "STODIV_Code_Site" $GROUPE
        fi

    done
done
