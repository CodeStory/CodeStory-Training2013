## Kata Lags


source :
http://wiki.agile-france.org/cgi-bin/wiki.pl?DojoDeveloppement/LouezVotreAvionEtGagnezDesSous


## Enoncé

ABEAS Corp est une toute petite entreprise qui possède un seul avion. Les clients d'ABEAS Corp sont de grandes compagnies qui louent l'avion pour augmenter leur capacité à l'occasion.

Les clients envoient des commandes de location qui consistent en un intervalle de temps, et le prix qu'ils sont prêts à payer pour louer l'avion durant cet intervalle.

Les commandes de tous les clients sont connues à l'avance. Bien sûr, toutes les commandes ne pourront pas être honorées, et certaines devront être déclinées. Eugène LAWLER, le Chief Scientific Officer d'ABEAS Corp aimerait maximiser le profit de l'entreprise.

On vous demande de calculer une solution optimale.

Considérez par exemple le cas où la compagnie a 4 commandes :

	AF514 : heure de départ 0, durée 5, prix 10
	CO5 : heure de départ 3, durée 7, prix 14
	AF515 : heure de départ 5, durée 9, prix 7
	BA01 : heure de départ 6, durée 9, prix 8

La solution optimale consiste à décliner CO5 et AF515, et le revenu est de 10+8=18. Remarquez qu'une solution à partir de AF514 et AF515 est faisable (l'avion serait loué sans interruption de 0 à 14) mais non-optimale.
Entrée

L'entrée consiste en plusieurs cas de test, chacun suivant la description ci-dessous. Une ligne vide sépare chaque cas de test.

Chaque cas de test est décrit par un fichier contenant toutes les informations concernées : la première ligne contient le nombre n de commandes ( n <= 3000). Cette ligne est suivie de n lignes. Chacune de ces lignes décrit une commande et contient l'identifiant de la commande (moins de 80 caractères, sans espaces) suivie de trois valeurs entières : le temps de départ, la durée de la location et le prix que le client est prêt à payer pour cette commande (des espaces sont utilisés comme séparateurs). On suppose que les commandes ont une durée strictement positive. Vous pouvez supposer que les heures, durées et prix sont strictement inférieurs à 231.

Sortie

Pour chaque cas de test, il vous est demandé de calculer une solution optimale pour chaque fichier en entrée. Votre programme doit écrire le prix total payé par les compagnies.

Les sorties de deux cas de tests consécutifs seront séparés par une ligne blanche.

Exemple d'entrée

	4
	AF514 0 5 10
	CO5 3 7 14
	AF515 5 9 7
	BA01 6 9 8
Exemple de sortie

	18




