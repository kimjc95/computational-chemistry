#!/bin/bash

# CHANGE THE ENV_NAME & CUDA_VERSION ACCORDINGLY!
ENV_NAME="MD"
CUDA_VERSION="12.1"

# After the installation, run following lines:
# $ conda activate ENV_NAME
# $ jupyter notebook

conda create -n $ENV_NAME python=3.10 -y

source activate $ENV_NAME

conda install mamba -n base -c conda-forge -y

mamba install -c pytorch -c nvidia -c conda-forge pytorch pytorch-cuda=$CUDA_VERSION openmm=8 openmm-torch openmm-ml openmm-xtb nnpops espaloma openmmforcefields scikit-learn scipy 

mamba install -c conda-forge -c bioconda reduce ipywidgets=7 nglview parmed rdkit pdbfixer openbabel plotly mdtraj lxml numpy tqdm 

pip install mace-torch pdb2pqr jupyter

if [ -f /etc/centos-release ]; then
    echo "CentOS detected. Installing openbabel using yum..."
    sudo yum install openbabel -y
elif [ -f /etc/lsb-release ] && grep -q "Ubuntu" /etc/lsb-release; then
    echo "Ubuntu detected. Installing python3-openbabel using apt-get..."
    sudo apt-get update
    sudo apt-get install python3-openbabel -y
else
    echo "Neither CentOS nor Ubuntu detected. Skipping openbabel installation."
fi

pip install --no-deps plip

conda deactivate

echo "Installation complete. Activate the environment with: conda activate $ENV_NAME"
