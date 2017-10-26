# Configure an AWS EC2 server for bebi103
# Install miniconda with relevant python packages
# and setup Jupyter Notebooks
# Author: Porfirio Quintero

# Download and install conda
echo 'Getting miniconda...'
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh;
bash ./miniconda.sh -b -p $HOME/miniconda;
# Add to PATH
export PATH="$HOME/miniconda/bin:$PATH"
# Add to PATH and PYTHONPATH in .bashrc
echo 'export PATH="$HOME/miniconda/bin:$PATH"' >> ~/.bashrc
# Add bebi103_utils to PYTHONPATH
echo 'export PYTHONPATH=:.:$HOME/aws103:$PYTHONPATH' >> ~/.bashrc

# Update bashrc
source ~/.bashrc

conda config --set always_yes yes --set changeps1 no;
conda update -q conda;

# Install python packages
echo 'Getting your python packages...'
# computing
conda install -y numpy scipy pandas pymc3 numba tqdm scikit-image
conda install -yc astropy emcee
# plotting
conda install -y matplotlib seaborn bokeh holoviews jupyter datashader

# install bebi103_utils
pip install bebi103
# for bebi103_utils
sudo yum -y install mesa-libGL.x86_64 gcc-c++

# Generate jupyter configuration file and certificate
jupyter notebook --generate-config
echo 'Please complete your certificate details'
mkdir ~/certs
cd ~/certs
sudo openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout mycert.pem -out mycert.pem

# Create and save jupyter password
python ~/aws103/jupyter_passconfig.py

# Download datasets
echo 'Downloading the bebi103 datasets...'
cd ~/*bebi103
wget https://s3.amazonaws.com/bebi103.caltech.edu/2017/data/data.tar
tar -xvf data.tar
rm ./data.tar
# Done!
echo 'All set!'
