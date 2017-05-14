# Tests de performances de différents langages

Ici sont répertoriés quelques programmes réalisés dans différents langages, et réalisant un traitement d'image très simple de flou sur une image.

# Système de mesure

Pour mesurer la consommation du processeur, j'utilise une pince ampèremétrique qui relève le courant arrivant dans le processeur par les deux câbles 12V d'alimentation dédiés. 
- Un premier système de mesure par Matlab avec une carte Arduino permet de relever les valeurs, de les enregistrer et de les tracer
- Je réalise d'autre part un autre système permettant de transformer la pince ampèremétrique en instrument connecté générant un point d'accès Wi-Fi et un serveur Web pour récupérer les valeurs. Il utilise un microcontrôleur Wi-Fi ESP8266 avec le firmware NodeMCU et est programmé en Lua.

# Test réalisé
Il s'agit d'une convolution d'un noyau de 3x3 sur une image en niveaux de gris encodée par des entiers. L'image importée est convertie en niveaux de gris avant d'effectuer la convolution. Le programme chronomètre le temps passé pour faire cette opération, mais pas les autres (notamment pas la conversion en niveaux de gris, qui diffère suivant les langages utilisés.)

# Langages
Ce test a été écrit en :
- C avec OpenCV (accès aux pixels manuellement)
- Python avec Numpy
- Scala avec ImageIO (sous forme de script, sauvegarde l'image au lieu de l'affichier)
- Java avec ImageIO (sous forme de bytecode en JAR)

Il est envisagé d'écrire ce test également en Go.
# Pourquoi

Ces programmes de test servent d'outil de mesure de consommation pour un dossier industriel proposé par Orange Labs (Lannion). Le problème est de quantifier la consommation d'un ordinateur (représentant un serveur) suivant les langages et la qualité de l'écriture du code.
