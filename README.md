# Projet Haskell ELP LOGOSKELL
## Objectif du projet
Ecrire en Haskell un programme capable de lire en entrée un programme LOGOSKELL, et d’écrire en sortie un programme SVG représentant la même figure. (Convertion LOGOSKELL --> SVG)  
## Logoskell et SVG  
Le logoskell est formule une suite d'instructions comme par exemple `[ Repeat 36 [ Right 10, Repeat 8 [ Forward 25, Left 45 ] ] ]`  
Notre projet à ainsi pour but de transformer ces instructions en code SVG (voir exemple ci dessous), interprétable par les navigateurs web :
```  
<?xml version='1.0' encoding='utf-8'?>  
 <svg xmlns='http://www.w3.org/2000/svg' version='1.1' width='800' height='800'>  
 <title>Super SVG max</title>  
<line x1='100.0' y1='100.0' x2='100.0' y2='100.0' stroke='red' />  
...  
</svg>  
```  

## Execution
Pour executer le projet, veuillez rentrer dans votre console la commande suivante :  
  `./init < test.logo > prog.svg` (à exécuter sous système UNIX)
(évidemment, vous pouvez remplacer test.logo par n'importe que fichier logo de votre choix, n'hésitez pas à utiliser ceux présents dans l'archive)  
==> Vous n'avez plus qu'à visualiser le resultat en ouvrant le fichier **prog.svg** dans votre navigateur favori !  




