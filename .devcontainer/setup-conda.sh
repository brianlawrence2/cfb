#!/bin/bash

# Download and install miniconda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
bash miniconda.sh -b -p $HOME/miniconda
export PATH="$HOME/miniconda/bin:$PATH"

conda init bash
source ~/.bashrc

conda env create -f .devcontainer/environment.yml

conda activate cfb

rm miniconda.sh