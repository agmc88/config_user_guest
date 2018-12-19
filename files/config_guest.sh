#!/bin/bash

###############################################
# Script permettant de copier l'environnement #
#      de l'utilisateur Guest sur Mac         #
#				Bureau + Library			  #
###############################################

# Si on est pas root on n'exec pas.
if [ $(whoami) != "root" ]
then
	echo -e "Le script $0 doit être executé en root.\n"
	exit 1
fi

if [ -z $1 ];then
	echo -e "Le script doit comprendre un argument"
	exit 2
else
	UTILISATEUR=$1


	echo "Assurez vous d'avoir fermé toutes les fenetres de la session invitée avant de continuer..."
	#	liste des dossiers stockés dans une variable
	listeDossier="Library Desktop"
	# ls /System/Library/User\ Template/French.lproj/Library/Keychains/{$listeDossier}
	#	Suppression des dossiers à copier 
	rm -r /System/Library/User\ Template/French.lproj/{$listeDossier}
	echo "dossier supprimés"

	#	Copier les dossiers Library et Desktop dans le French.lproj -  Environnement Guest
	cp -Rf /Users/Guest/Library /System/Library/User\ Template/French.lproj/
	cp -Rf /Users/Guest/Desktop /System/Library/User\ Template/French.lproj/
	echo "dossiers copiés"

	#	Supprimer tous les fichiers du Keychains - evite les pop-up de mdp
	rm -r /System/Library/User\ Template/French.lproj/Library/Caches/*
	rm -r /System/Library/User\ Template/French.lproj/Library/Keychains/*
	cd /System/Library/User\ Template/French.lproj/Library/Keychains/
	rm .f* *
	echo "keychains vidé"

	
	rm -r /System/Library/User\ Template/French.lproj/Library/Keychains/*

	#	On créé le lien symbolique peu importe le poste pour être certain d'avoir l'environnement en anglais et en français partout
	ln -s /System/Library/User\ Template/French.lproj/ /System/Library/User\ Template/English.lproj/
	echo "Symlink du french.lproj vers English.lproj effectué"

	#	Copie du french.lproj sur le bureau
	cp -r /System/Library/User\ Template/French.lproj/ /Users/$UTILISATEUR/French.lproj
	echo "Copie du dossier French.lproj effectué"

	#	Modificationd des droits
	chown -R $UTILISATEUR:staff /Users/$UTILISATEUR/French.lproj/
	echo "les droits sont modifiés"

	

	echo "Vous pouvez vous déconnecter ..."
fi