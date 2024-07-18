# Code for Enabling In-Situ Magnetic Interference Mitigation Algorithm Validation via a Laboratory-Generated Dataset  

## Abstract
Magnetometer measurements are one of the critical components necessary to improve our understanding of the intricate physical processes 
coupling mass, momentum, and energy within near-Earth space and throughout our solar system. However, these measurements are often contaminated by 
stray magnetic fields from the spacecraft hosting the magnetic field sensors, and the data often requires the application of interference mitigation algorithms 
prior to scientific use. Rigorous numerical validation of these techniques can be challenging when they are applied to in-situ spaceflight data, as a ground 
truth for the local magnetic field is often unavailable. This manuscript introduces and details the generation of an open-source dataset designed to facilitate 
the assessment of interference mitigation techniques for magnetic field data collected during spaceflight missions. The dataset contains over 100 hours of 
magnetic field data comprising mixtures of near-DC trends, physically-synthesized interference, and pseudo-geophysical phenomena. These constituent source 
signals have been independently captured by four synchronized magnetometers sampling at high cadence and combined into 30-minute intervals of data 
representative of events and interference seen in historic missions. The physical location of the four magnetometers relative to the interference sources enables 
researchers to test their interference mitigation algorithms with various magnetometer suite configurations, and the dataset also provides a ground truth for 
the underlying interference signals, enabling rigorous quantification of the results of past, present, and future interference mitigation efforts. 

## Table of Contents

- [Project Structure](#project-structure)
- [Cloning the Repository](#cloning-the-repository)
- [Dependencies and Submodules](#dependencies-and-submodules)
- [Usage](#usage)
- [License](#license)

## Project Structure

Here is a brief overview of the directory structure of this project:
```
├── collection # Collection of data and corresponding script
├── deps # Dependencies and submodules
├── example # Example scripts for usage
├── makecdfs # Scripts for making CDFs that utilizes the submodule
├── processing # Data processing scripts in python 
├── .gitignore # Git ignore file
├── .gitmodules # Git submodules configuration
├── LICENSE # License file
```


- **collection**: Contains various data or scripts collected for the project.
- **deps**: Directory for dependencies and submodules.
- **example**: Example scripts to demonstrate the usage of the project.
- **makecdfs**: Scripts related to creating CDFs.
- **processing**: Scripts for processing data.
- **.gitignore**: Specifies files to be ignored by Git.
- **.gitmodules**: Configuration for Git submodules.
- **LICENSE**: The license for the project.

## Cloning the Repository

To clone the repository along with its submodules, use the following command:

```sh
git clone --recurse-submodules <repository-url>
```
If you have already cloned the repository without the --recurse-submodules flag, you can initialize and update the submodules with:
``` sh
git submodule update --init --recursive
```

## Dependencies and Submodules
This project uses submodules to manage dependencies. Ensure that you have initialized and updated the submodules as described above.

Requiers: https://github.com/mag-noise/mapCDF for CDF generation

## Usage
Provide detailed instructions on how to use your project. Here’s an example:

1. Setup:
 - Ensure you have the necessary dependencies installed.
 - Initialize and update submodules if not already done:
```
git submodule update --init --recursive
```
2. Running Examples
 - Run example.py script and verify the output matches output.png
4. Processing Data
 - Download _tsv folder in the data repository
 - Run level1_processing.py
 - Run level2_processing.py
5. Creating CDFs
 - Change pathing within code structure to point to level2 .mat files as input path
 - Change pathing within code structure to where CDFs should be generated as output path

## License
This project is licensed under the MIT License.

### Key Points

- **Project Structure**: Clearly outlines the directory structure and briefly explains the purpose of each directory.
- **Cloning the Repository**: Provides commands to clone the repository and initialize submodules.
- **Dependencies and Submodules**: Mentions the importance of submodules and how to handle them.
- **Usage**: Detailed instructions on how to set up and use the project, including examples and specific scripts.
- **License**: States the licensing information and points to the license file.

## Archival and Citation

This repository is archived and assigned a DOI via Zenodo for reproducibility and citation purposes.

- **GitHub Repository**: https://github.com/mag-noise/crm/
- **Zenodo DOI**: https://zenodo.org/doi/10.5281/zenodo.12754307
- **Article DOI**: doi.org/10.5194/egusphere-2024-87
- **Data Repository**: <[To be Added]>

You can cite this repository using the following DOI: <[To be Added]>
