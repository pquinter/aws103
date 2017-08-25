# Download and install conda
echo 'Getting miniconda...'
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh;
bash ./miniconda.sh -b -p $HOME/miniconda;
# Add to PATH
export PATH="$HOME/miniconda/bin:$PATH"
# Add to PATH and PYTHONPATH in .bashrc
echo 'export PATH="$HOME/miniconda/bin:$PATH"' >> ~/.bashrc
echo 'export PYTHONPATH=:.:$HOME/bebi103_utils:$PYTHONPATH' >> ~/.bashrc

conda config --set always_yes yes --set changeps1 no;
conda update -q conda;

# Install python packages
echo 'Getting your python packages...'
# computing
conda install -y numpy scipy pandas pymc3 numba tqdm scikit-image
conda install -yc astropy emcee
# plotting
conda install -y matplotlib seaborn bokeh holoviews jupyter

# Needed for bebi103 to work
sudo yum -y install mesa-libGL.x86_64

# Create directories
mkdir ~/certs ~/notebooks ~/notebooks/data ~/notebooks/output

# Generate jupyter configuration file and certificate
jupyter notebook --generate-config
echo 'Please complete your certificate details'
cd ~/certs
sudo openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout mycert.pem -out mycert.pem

# Create and save jupyter password
python ~/bebi103_utils/jupyter_passconfig.py

# Download datasets
echo 'Downloading the bebi103 datasets...'
cd ~/notebooks/data
# wget?
