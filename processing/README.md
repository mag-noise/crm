# crm_python
Python code to replicate, and slightly improve, the MATLAB code functionality associated with the crm repo (https://github.com/mag-noise/crm). This repo takes different types of data captured by four Twinleaf VMR magnetometers (https://twinleaf.com/vector/VMR/), filters them appropriately, and combines them in various ways. The output combinations are saved in a MATLAB v5 format, which will then be converted to CDF files for distribution. 

The data and associated processing are described in a manuscript by Finley et al. (2024), titled _Enabling In-Situ Magnetic Interference Mitigation Algorithm Validation via a Laboratory-Generated Dataset_, that has been accepted and is currently in production at the journal of _Geoscientific Instrumentation, Methods, and Data Systems_ (Preprint available at: https://egusphere.copernicus.org/preprints/2024/egusphere-2024-87/egusphere-2024-87.pdf).
 
## Folder Structure:
The ```_processed_data/``` directory, and all subdirectories, are generated when running ```level1_processing.py``` and ```level2_processing.py```. The original _.tsv_ files __must__ be held in the directory structure shown for ```_tsv/```. Note that this will hopefully be improved in the future to pull the original files from an external source.
```
crm_python
├───level1_processing.py
├───level2_processing.py
├───_processed_data
│   ├───level_1
│   │   ├───geo
│   │   ├───int
│   │   └───trend
│   └───level_2
└───_tsv
    └───level_0
        ├───geo
        ├───int
        └───trend
```
