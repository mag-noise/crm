'''
Title: 'example.py'

Date/Version: 25 April 2024 (v0.1)

Author: Matthew G. Finley (NASA GSFC/University of Maryland)

Contact: matthew.g.finley@nasa.gov

Description: Simple Python script to load and display data samples from interference mitigation-enabling dataset. This script accompanies the
                following manuscript, and dataset described therein:
                    'Enabling In-Situ Magnetic Interference Mitigation Algorithm Validation via a Laboratory-Generated Dataset'
                     by M. G. Finley, A. M. Flores, K. J. Morris, R. M. Broadfoot, S. Hisel, J. Homann, C. Piker, A. S. Gupta, and D. M. Miles.

Notes: The file being loaded, designated by the string file_name (in this case, 'CRM_combination_1_L2.cdf'), is assumed to exist in the same directory as this script. 
'''

# Import necessary utilities
import cdflib
import matplotlib.pyplot as plt

# Define file name
file_name = 'CRM_combination_1_L2.cdf'

# Load data with cdflib
cdf_file = cdflib.CDF(file_name)

# Print variables stored in cdf_file
print('CDF Variables:')
print(cdf_file.cdf_info())

# Print text description of this specific combination of data
cdf_global_attributes = cdf_file.globalattsget()
print('CDF Text Supplemental:')
print(cdf_global_attributes['Text_supplemental'])

'''
Relevant Variables:

The relevant variables for many users likely include:
    The combined magnetometer data, comprised of pseudo-Geophysical signals, physically-synthesized interference, and near-DC trend.
        'CombinedMag1', 'CombinedMag2', 'CombinedMag3', 'CombinedMag4'
    Only the magnetometer data associated with the pseudo-Geophysical signals.
        'GeoSignalMag1', 'GeoSignalMag2', 'GeoSignalMag3', 'GeoSignalMag4'
    Only the magnetometer data associated with the physically-synthesized interference.
        'InterMag1', 'InterMag2', 'InterMag3', 'InterMag4'
    Only the magnetometer data associated with the near-DC trend.
        'TrendMag1', 'TrendMag2', 'TrendMag3', 'TrendMag4'
    
    Note that, as described in the manuscript listed above, the 'GeoSignalMagX' and 'TrendMagX' signals are identical for all four magnetometers (i.e., X=1:4) for each L2 CDF.
    This is based on the common assumption that the geophysical phenomena measured by a boom-mounted gradiometer will be identical for both magnetometers.
'''
# Load epoch (time) data; this is identical for all measurements across all CDF files 
#   and was included for usability with common automatic plotting tools such as AutoPlot (http://autoplot.org/)
epoch = cdf_file['Epoch']
# Convert epoch time to Python datetime objects for convenience in display
dt = cdflib.cdfepoch.to_datetime(epoch)

# Extract vector measurements of pseudo-geophysical signal for all four magnetometers
#   since these are the only signals that vary across the four
interference_mag1 = cdf_file['InterMag1']
interference_mag2 = cdf_file['InterMag2']
interference_mag3 = cdf_file['InterMag3']
interference_mag4 = cdf_file['InterMag4']

# Extract vector measurement from one magnetometer of pseudo-geophysical signal
#   since these will be same for all four magnetometers within each CDF
geophysical = cdf_file['GeoSignalMag1']

# Extract vector measurement from one magnetometer of near-DC trend signal
#   since these will be same for all four magnetometers within each CDF
trend = cdf_file['TrendMag1']

# Extract only the B_Z component from each
interference_mag1_bz = interference_mag1[:,2]
interference_mag2_bz = interference_mag2[:,2]
interference_mag3_bz = interference_mag3[:,2]
interference_mag4_bz = interference_mag4[:,2]
geophysical_bz = geophysical[:,2]
trend_bz = trend[:,2]

# Display 
plt.figure(figsize=(12,8))

plt.subplot(611) 
plt.scatter(dt, interference_mag1_bz, color='black', marker='.', s=1)
plt.ylabel('$B_{Z}$ (nT)\n$M_{1}$ Interference')
plt.suptitle(file_name, y=0.98)
plt.grid()

plt.subplot(612)
plt.scatter(dt, interference_mag2_bz, color='black', marker='.', s=1)
plt.ylabel('$B_{Z}$ (nT)\n$M_{2}$ Interference')
plt.grid()

plt.subplot(613)
plt.scatter(dt, interference_mag3_bz, color='black', marker='.', s=1)
plt.ylabel('$B_{Z}$ (nT)\n$M_{3}$ Interference')
plt.grid()

plt.subplot(614)
plt.scatter(dt, interference_mag4_bz, color='black', marker='.', s=1)
plt.ylabel('$B_{Z}$ (nT)\n$M_{4}$ Interference')
plt.grid()

plt.subplot(615)
plt.scatter(dt, geophysical_bz, color='black', marker='.', s=1)
plt.ylabel('$B_{Z}$ (nT)\n$M_{1-4}$ Geophysical')
plt.grid()

plt.subplot(616)
plt.scatter(dt, trend_bz, color='black', marker='.', s=1)
plt.ylabel('$B_{Z}$ (nT)\n$M_{1-4}$ Trend')
plt.grid()
plt.tight_layout()
plt.savefig('output_image.png', bbox_inches='tight')
plt.show()

'''
Applied Stimuli in this Combination:

It can be seen that the data provided here matches the description of the stimulus provided by the text_supplemental global variable stored in the CDF.

'Near DC Trend: 0.001 Hz sine wave with 20 V amplitude applied to coil system X-axis', 
'Interference:  Motor 1 & 2 driven at 2.5 V for duration.', 
'Pseudo-Geomagnetic: 0.75 Hz sinusoid applied to X-axis coil former with amplitude swept from 0 V to 0.6 Vrms to 0 V.  Stimulus applied at ~10-min and ~20-min.'
'''

'''
Generating Additional Combinations:

New combinations of signals can easily be generated using this set of data. For example, if users wish to 
    sum two sets of interference signals together to more accurately represent the ~4 reaction wheels onboard a spacecraft,
    this can be accomplished easily by simply loading multiple CDF files and sum the interference signals associated with 
    each while preserving the original geophysical and near-dc signals.

More complex operations, such as circular shifting of the data to adjust the timing of spurious signals (such as the
    amplitude-modulated 'wave packets' shown in this example code), are possible -- however, the user will need to handle
    potential implementation details, such as the need to preserve spectral continuity at the 'edges' of the original data 
    following the application of a circular shift. A simpler solution would be to reduce the length (e.g., to ~15 minutes) 
    of all signals to be testing and slice out only the appropriate section of the signal to be shifted, conforming to the 
    desired timing of the wave packet.
'''