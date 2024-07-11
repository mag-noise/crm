# TODO: Title block

'''
Import Statements
'''
import glob
import os
import pickle
import scipy.signal
import numpy as np
import matplotlib.pyplot as plt
from read_tsv import read_tsv

'''
Generate file directories
'''
os.makedirs('_processed_data/level_1/geo', exist_ok=True)
os.makedirs('_processed_data/level_1/trend', exist_ok=True)
os.makedirs('_processed_data/level_1/int', exist_ok=True)

'''
Define Useful Params
'''
n_mags = 4
fs = 200

'''
Process Geophysical Signals
'''
geophysical_level0_dir = '_tsv/level_0/geo/'
geophysical_level0_file_list = glob.glob(geophysical_level0_dir + '*.tsv')

for file in geophysical_level0_file_list:
    print('Processing ' + os.path.basename(file))
    x_list, y_list, z_list = read_tsv(file)

    x_1 = x_list[0][30*fs:1830*fs]
    x_2 = x_list[1][30*fs:1830*fs]
    x_3 = x_list[2][30*fs:1830*fs]
    x_4 = x_list[3][30*fs:1830*fs]

    y_1 = y_list[0][30*fs:1830*fs]
    y_2 = y_list[1][30*fs:1830*fs]
    y_3 = y_list[2][30*fs:1830*fs]
    y_4 = y_list[3][30*fs:1830*fs]

    z_1 = z_list[0][30*fs:1830*fs]
    z_2 = z_list[1][30*fs:1830*fs]
    z_3 = z_list[2][30*fs:1830*fs]
    z_4 = z_list[3][30*fs:1830*fs]

    l1_x_list = [x_1, x_2, x_3, x_4]
    l1_y_list = [y_1, y_2, y_3, y_4]
    l1_z_list = [z_1, z_2, z_3, z_4]

    l1_output = [l1_x_list, l1_y_list, l1_z_list]

    l1_dir = '_processed_data/level_1/geo/'
    l1_filename = os.path.splitext(os.path.basename(file))[0] + '_l1.pkl'
    with open(l1_dir + l1_filename, 'wb') as f:
        print('Saving ' + l1_dir + l1_filename)
        pickle.dump(l1_output, f)

'''
Process Trend Signals
'''
trend_level0_dir = '_tsv/level_0/trend/'
trend_level0_file_list = glob.glob(trend_level0_dir + '*.tsv')

for file in trend_level0_file_list:
    print('Processing ' + os.path.basename(file))
    x_list, y_list, z_list = read_tsv(file)

    lpf_cuttoff = 0.1 # Hz
    lpf = scipy.signal.iirfilter(9, Wn=lpf_cuttoff, btype='lowpass', fs=fs, output='sos')

    x_1 = scipy.signal.sosfiltfilt(lpf, x_list[0])[30*fs:1830*fs]
    x_2 = scipy.signal.sosfiltfilt(lpf, x_list[1])[30*fs:1830*fs]
    x_3 = scipy.signal.sosfiltfilt(lpf, x_list[2])[30*fs:1830*fs]
    x_4 = scipy.signal.sosfiltfilt(lpf, x_list[3])[30*fs:1830*fs]

    y_1 = scipy.signal.sosfiltfilt(lpf, y_list[0])[30*fs:1830*fs]
    y_2 = scipy.signal.sosfiltfilt(lpf, y_list[1])[30*fs:1830*fs]
    y_3 = scipy.signal.sosfiltfilt(lpf, y_list[2])[30*fs:1830*fs]
    y_4 = scipy.signal.sosfiltfilt(lpf, y_list[3])[30*fs:1830*fs]

    z_1 = scipy.signal.sosfiltfilt(lpf, z_list[0])[30*fs:1830*fs]
    z_2 = scipy.signal.sosfiltfilt(lpf, z_list[1])[30*fs:1830*fs]
    z_3 = scipy.signal.sosfiltfilt(lpf, z_list[2])[30*fs:1830*fs]
    z_4 = scipy.signal.sosfiltfilt(lpf, z_list[3])[30*fs:1830*fs]

    l1_x_list = [x_1, x_2, x_3, x_4]
    l1_y_list = [y_1, y_2, y_3, y_4]
    l1_z_list = [z_1, z_2, z_3, z_4]
    
    l1_output = [l1_x_list, l1_y_list, l1_z_list]

    l1_dir = '_processed_data/level_1/trend/'
    l1_filename = os.path.splitext(os.path.basename(file))[0] + '_l1.pkl'
    with open(l1_dir + l1_filename, 'wb') as f:
        print('Saving ' + l1_dir + l1_filename)
        pickle.dump(l1_output, f)

'''
Process Interference Signals
'''
int_level0_dir = '_tsv/level_0/int/'
int_level0_file_list = glob.glob(int_level0_dir + '*.tsv')

for file in int_level0_file_list:
    print('Processing ' + os.path.basename(file))
    x_list, y_list, z_list = read_tsv(file)

    x_1 = x_list[0][30*fs:1830*fs]
    x_2 = x_list[1][30*fs:1830*fs]
    x_3 = x_list[2][30*fs:1830*fs]
    x_4 = x_list[3][30*fs:1830*fs]

    y_1 = y_list[0][30*fs:1830*fs]
    y_2 = y_list[1][30*fs:1830*fs]
    y_3 = y_list[2][30*fs:1830*fs]
    y_4 = y_list[3][30*fs:1830*fs]

    z_1 = z_list[0][30*fs:1830*fs]
    z_2 = z_list[1][30*fs:1830*fs]
    z_3 = z_list[2][30*fs:1830*fs]
    z_4 = z_list[3][30*fs:1830*fs]

    l1_x_list = [x_1, x_2, x_3, x_4]
    l1_y_list = [y_1, y_2, y_3, y_4]
    l1_z_list = [z_1, z_2, z_3, z_4]

    hpf_cutoff = 1 # Hz
    hpf = scipy.signal.iirfilter(3, Wn=hpf_cutoff, btype='highpass', fs=fs, output='sos')

    for i in range(len(x_list)):
        l1_x_list[i] = scipy.signal.sosfiltfilt(hpf, l1_x_list[i])
        l1_x_list[i] = l1_x_list[i] - np.median(l1_x_list[i])
        l1_y_list[i] = scipy.signal.sosfiltfilt(hpf, l1_y_list[i])
        l1_y_list[i] = l1_y_list[i] - np.median(l1_y_list[i])
        l1_z_list[i] = scipy.signal.sosfiltfilt(hpf, l1_z_list[i])
        l1_z_list[i] = l1_z_list[i] - np.median(l1_z_list[i])
    
    l1_output = [l1_x_list, l1_y_list, l1_z_list]

    l1_dir = '_processed_data/level_1/int/'
    l1_filename = os.path.splitext(os.path.basename(file))[0] + '_l1.pkl'
    with open(l1_dir + l1_filename, 'wb') as f:
        print('Saving ' + l1_dir + l1_filename)
        pickle.dump(l1_output, f)