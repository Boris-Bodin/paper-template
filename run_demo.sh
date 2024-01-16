# Author: Boris Bodin
# Date: 2023-08-28
# Version: 1.0
# Description: Compile the demo files

# Function to compile the demo files with given option
function compile() {
    echo "Compile demo-$1.tex"

    # Set the option
    sed -i "s/\\documentclass\[.*\]{archi}/\\documentclass\[$1\]{archi}/g" main.tex

    # Compile the demo file
    pdflatex -file-line-error -interaction=nonstopmode -synctex=1 -output-format=pdf -output-directory=../out main.tex
    pdflatex -file-line-error -interaction=nonstopmode -synctex=1 -output-format=pdf -output-directory=../out main.tex
    mv ../out/main.pdf ../out/demo-$1.pdf
}

# Go to the src directory
cd src || exit

# Compile the demo files
compile externe
compile article

