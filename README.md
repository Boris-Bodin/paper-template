# Template pour rédaction en Latex

Ce repo contient un template pour rédiger des documents en Latex, aux couleurs de Scub.

Il contient une classe `archi.cls` qui permet de définir le templates du document.

## Install pdfLatex

Les commandes suivantes permettent d'installer `pdflatex` sur un système Ubuntu.

```bash
sudo apt-get update
sudo apt-get i -y \
  texlive-latex-base \
  texlive-fonts-recommended \
  texlive-fonts-extra \
  texlive-latex-extra
```

## Utilisation

Pour utiliser ce template, il suffit de faire un fork du projet, puis de modifier le fichier `main.tex` pour y inclure
le contenu de votre document.

## Configuration

La configuration de la class `archi.cls` comporte plusieurs paramètres:

- `externe`: permet de définir si le document est destiné à être envoyé à un client.
- `article`: permet de définir si le document est un article sur deux colone. (Work in progress)

## Compilation

Pour compiler le document, il suffit de lancer la commande suivante:

```bash
cd src
pdflatex -file-line-error -interaction=nonstopmode -synctex=1 -output-format=pdf -output-directory=../out main.tex
```

Ou bien d'utilisé la configuration `Run Latex` d'IntelliJ pour compiler le document.

## Demo

Un document de démonstration est disponible dans le dossier `out`.
