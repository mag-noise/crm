# TODO: Title block

'''
Import Statements
'''
import glob
import os
import pickle
from scipy.io import savemat
import numpy as np

'''
Generate file directories
'''
os.makedirs('_processed_data/level_2', exist_ok=True)

trend_dir = '_processed_data/level_1/trend/'
int_dir = '_processed_data/level_1/int/'
geo_dir = '_processed_data/level_1/geo/'

trend_filelist = glob.glob(trend_dir + '*.pkl')
int_filelist = glob.glob(int_dir + '*.pkl')
geo_filelist = glob.glob(geo_dir + '*.pkl')

# Define combination counter
n_combination = 1
n_combinations = len(trend_filelist) * len(int_filelist) * len(geo_filelist)


# Iterate through trend files
# indicatr for trend signal
trend_ind = 0
for trend_file in trend_filelist:
    trend_ind = trend_ind + 1
    ''' Read data from file '''
    with open(trend_file, 'rb') as f:
        trend_data = pickle.load(f)
    # Break into components
    l1_x_trend = trend_data[0]
    l1_y_trend = trend_data[1]
    l1_z_trend = trend_data[2]

    l1_x_trend_m2 = l1_x_trend[1] # Only need data from center-most magnetometer in coil system (M2)
    l1_y_trend_m2 = l1_y_trend[1]
    l1_z_trend_m2 = l1_z_trend[1]

    ''' Iterate through interference files '''
    # indicator for interference signal
    int_ind = 0
    for int_file in int_filelist:
        int_ind = int_ind + 1
        # Read data from file
        with open(int_file, 'rb') as f:
            int_data = pickle.load(f)
        # Break into components
        l1_x_int = int_data[0]
        l1_y_int = int_data[1]
        l1_z_int = int_data[2]

        l1_x_int_m1 = l1_x_int[0] # Using data from each magnetometer for interference terms
        l1_y_int_m1 = l1_y_int[0]
        l1_z_int_m1 = l1_z_int[0]
        l1_x_int_m2 = l1_x_int[1]
        l1_y_int_m2 = l1_y_int[1]
        l1_z_int_m2 = l1_z_int[1]
        l1_x_int_m3 = l1_x_int[2]
        l1_y_int_m3 = l1_y_int[2]
        l1_z_int_m3 = l1_z_int[2]
        l1_x_int_m4 = l1_x_int[3]
        l1_y_int_m4 = l1_y_int[3]
        l1_z_int_m4 = l1_z_int[3]

        ''' Iterate through geophysical files '''
        # indicator for geophysical signal
        geo_ind = 0
        for geo_file in geo_filelist:
            geo_ind = geo_ind + 1
            # Read data from file
            with open(geo_file, 'rb') as f:
                geo_data = pickle.load(f)
            # Break into components
            l1_x_geo = geo_data[0]
            l1_y_geo = geo_data[1]
            l1_z_geo = geo_data[2]

            l1_x_geo_m2 = l1_x_geo[1]
            l1_y_geo_m2 = l1_y_geo[1]
            l1_z_geo_m2 = l1_z_geo[1]

            ''' Combine data '''
            # Combine components
            l2_x_combined_m1 = l1_x_trend_m2 + l1_x_int_m1 + l1_x_geo_m2 # Only interference uses data from each magnetometer
            l2_y_combined_m1 = l1_y_trend_m2 + l1_y_int_m1 + l1_y_geo_m2
            l2_z_combined_m1 = l1_z_trend_m2 + l1_z_int_m1 + l1_z_geo_m2

            l2_x_combined_m2 = l1_x_trend_m2 + l1_x_int_m2 + l1_x_geo_m2
            l2_y_combined_m2 = l1_y_trend_m2 + l1_y_int_m2 + l1_y_geo_m2
            l2_z_combined_m2 = l1_z_trend_m2 + l1_z_int_m2 + l1_z_geo_m2

            l2_x_combined_m3 = l1_x_trend_m2 + l1_x_int_m3 + l1_x_geo_m2
            l2_y_combined_m3 = l1_y_trend_m2 + l1_y_int_m3 + l1_y_geo_m2
            l2_z_combined_m3 = l1_z_trend_m2 + l1_z_int_m3 + l1_z_geo_m2

            l2_x_combined_m4 = l1_x_trend_m2 + l1_x_int_m4 + l1_x_geo_m2
            l2_y_combined_m4 = l1_y_trend_m2 + l1_y_int_m4 + l1_y_geo_m2
            l2_z_combined_m4 = l1_z_trend_m2 + l1_z_int_m4 + l1_z_geo_m2

            # Generate vectors
            l2_combined_m1 = [l2_x_combined_m1, l2_y_combined_m1, l2_z_combined_m1]
            l2_combined_m2 = [l2_x_combined_m2, l2_y_combined_m2, l2_z_combined_m2]
            l2_combined_m3 = [l2_x_combined_m3, l2_y_combined_m3, l2_z_combined_m3]
            l2_combined_m4 = [l2_x_combined_m4, l2_y_combined_m4, l2_z_combined_m4]
            l2_combined = {'l2_combined_m1': l2_combined_m1,
                           'l2_combined_m2': l2_combined_m2,
                           'l2_combined_m3': l2_combined_m3,
                           'l2_combined_m4': l2_combined_m4}

            l2_int_m1 = [l1_x_int_m1, l1_y_int_m1, l1_z_int_m1]
            l2_int_m2 = [l1_x_int_m2, l1_y_int_m2, l1_z_int_m2]
            l2_int_m3 = [l1_x_int_m3, l1_y_int_m3, l1_z_int_m3]
            l2_int_m4 = [l1_x_int_m4, l1_y_int_m4, l1_z_int_m4]
            l2_int = {'l2_int_m1': l2_int_m1,
                      'l2_int_m2': l2_int_m2,
                      'l2_int_m3': l2_int_m3,
                      'l2_int_m4': l2_int_m4}

            l2_trend_m1 = [l1_x_trend_m2, l1_y_trend_m2, l1_z_trend_m2]
            l2_trend_m2 = [l1_x_trend_m2, l1_y_trend_m2, l1_z_trend_m2]
            l2_trend_m3 = [l1_x_trend_m2, l1_y_trend_m2, l1_z_trend_m2]
            l2_trend_m4 = [l1_x_trend_m2, l1_y_trend_m2, l1_z_trend_m2]
            l2_trend = {'l2_trend_m1': l2_trend_m1,
                        'l2_trend_m2': l2_trend_m2,
                        'l2_trend_m3': l2_trend_m3,
                        'l2_trend_m4': l2_trend_m4}

            l2_geo_m1 = [l1_x_geo_m2, l1_y_geo_m2, l1_z_geo_m2]
            l2_geo_m2 = [l1_x_geo_m2, l1_y_geo_m2, l1_z_geo_m2]
            l2_geo_m3 = [l1_x_geo_m2, l1_y_geo_m2, l1_z_geo_m2]
            l2_geo_m4 = [l1_x_geo_m2, l1_y_geo_m2, l1_z_geo_m2]
            l2_geo = {'l2_geo_m1': l2_geo_m1,
                      'l2_geo_m2': l2_geo_m2,
                      'l2_geo_m3': l2_geo_m3,
                      'l2_geo_m4': l2_geo_m4}
            
            l2_sourcefiles = {'trend_source': trend_file, 
                              'int_source': int_file, 
                              'geo_source': geo_file}
            
            output_dictionary = {'l2_combined': l2_combined,
                                 'l2_int': l2_int,
                                 'l2_trend': l2_trend,
                                 'l2_geo': l2_geo,
                                 'l2_sourcefiles': l2_sourcefiles}
            
            # Save data as .mat file (note that this defaults to -v5)
            savemat('_processed_data/level_2/crm_g%d_i%d_t%d_l2.mat' % (geo_ind, int_ind, trend_ind) , output_dictionary)

            # Print progress statement
            print('Completed saving out combination %d / %d.' % (n_combination, n_combinations))

            # Iterate combination counter
            n_combination += 1 




