#!/bin/bash
#On verifie si il y a bien au moins 1 argument en parametre sinon on specifie l'usage et on fini par un exit 1
if [ $# -eq 0 ];
    #VOIR NOTE 1
    then echo -e "\n\033[4;34mError:\033[0m no arguments specified.\n\nUsage:\n\ttransfer /tmp/test.md\n\ttransfer test.md";
    exit 1;   
fi

#On recupere le chemin absolu de notre fichier qui contiendra les logs de nos uploads
logFile=$(readlink -f ~/Downloads/TransferLog);
#Par precaution, on recupere juste le nom de fichier au cas ou le script aurait recu le chemin relatif du fichier
baseFile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g');

#On ajoute a la suite de notre fichier log la date et le lien du fichier qu'on upload ainsi qu'un retour a la ligne
date >> $logFile;
#VOIR NOTE 2
curl --progress-bar --upload-file "$1" "https://transfer.sh/$baseFile" >> $logFile;
echo -e "\n" >> $logFile;

#On affiche l'avant derniere ligne du fichier pour avoir directement le lien a copier/coller
tail -2 $logFile | head -1;

#On notifie au systeme que le programme s'est fini correctement
exit 0;


#NOTE 1
#Si on specifie -e en parametre, \n permet un retour a la ligne et \t de faire un retrait de ligne
#\033[4;34m "TEXTE" \033[0m permet de souligner le texte avec le chiffre 4 et le mettre en bleu avec le nombre 34
#Pour mettre un texte en forme,il faut utiliser la synthaxe suivante : \033[A;B;C "TEXTE" \033[
#A, B et C sont 3 parametre qu'on remplacera par des nombres si on le souhaite.

#NOTE 2
#On peut limiter le nombre de telechargement et le nombre de jours en ligne avec en specifiant a curl les parametres suivants :
#curl -H "Max-Downloads: 1" -H "Max-Days: 5" --upload-file ...[SUITE DE LA COMMANDE]