%{
    Titile: combine_measurements.m
    Date/ Version: 08 May 2025 (v0.1)
    Author: Matthew G. Finley (NASA GSFC/University of Maryland)
    Contact: matthew.g.finley@nasa.gov

    Description: 
    This script combines measurements from different sources, applies necessary
    processing steps such as filtering and detrending, and saves the processed
    data to a MAT file.

    Notes:
    - Requires the functions 'read_tsv.m' and 'uniform_detrend.m' to be in the
      same directory or in the MATLAB path.
%}


close all
clear all

fs = 200;

%% READ IN TSV FILES

[X_dc, Y_dc, Z_dc] = read_tsv('_data/crm_large_neardc_3.1.tsv', fs, 0);
[X_geo, Y_geo, Z_geo] = read_tsv('_data/crm_geophysical_2.1.tsv', fs, 1);
[X_int, Y_int, Z_int] = read_tsv('_data/crm_motors_3.1.tsv', fs, 1);

%% SET ALL TO SAME LENGTH (min_length)
min_length = min([length(X_geo), length(X_int), length(X_dc)]);
t = (1:min_length) / fs;

X_dc = X_dc(1:min_length, :);
Y_dc = Y_dc(1:min_length, :);
Z_dc = Z_dc(1:min_length, :);

X_geo = X_geo(1:min_length, :);
Y_geo = Y_geo(1:min_length, :);
Z_geo = Z_geo(1:min_length, :);

X_int = X_int(1:min_length, :);
Y_int = Y_int(1:min_length, :);
Z_int = Z_int(1:min_length, :);

%% PROCESS DATA
% Near-DC sinusoids need filtering due to 'stepping' of coil system
filt_cutoff = 0.1;
X_dc_1 = lowpass(X_dc(:,1), filt_cutoff, fs);
X_dc_2 = lowpass(X_dc(:,2), filt_cutoff, fs);
X_dc_3 = lowpass(X_dc(:,3), filt_cutoff, fs);
X_dc_4 = lowpass(X_dc(:,4), filt_cutoff, fs);
Y_dc_1 = lowpass(Y_dc(:,1), filt_cutoff, fs);
Y_dc_2 = lowpass(Y_dc(:,2), filt_cutoff, fs);
Y_dc_3 = lowpass(Y_dc(:,3), filt_cutoff, fs);
Y_dc_4 = lowpass(Y_dc(:,4), filt_cutoff, fs);
Z_dc_1 = lowpass(Z_dc(:,1), filt_cutoff, fs);
Z_dc_2 = lowpass(Z_dc(:,2), filt_cutoff, fs);
Z_dc_3 = lowpass(Z_dc(:,3), filt_cutoff, fs);
Z_dc_4 = lowpass(Z_dc(:,4), filt_cutoff, fs);

% Geophysical data preserved at all freq bands
X_geo_1 = X_geo(:,1);
X_geo_2 = X_geo(:,2);
X_geo_3 = X_geo(:,3);
X_geo_4 = X_geo(:,4);
Y_geo_1 = Y_geo(:,1);
Y_geo_2 = Y_geo(:,2);
Y_geo_3 = Y_geo(:,3);
Y_geo_4 = Y_geo(:,4);
Z_geo_1 = Z_geo(:,1);
Z_geo_2 = Z_geo(:,2);
Z_geo_3 = Z_geo(:,3);
Z_geo_4 = Z_geo(:,4);

% 1-second detrend to bring to approximately zero out
X_int_1 = uniform_detrend(X_int(:,1), fs);
X_int_2 = uniform_detrend(X_int(:,2), fs);
X_int_3 = uniform_detrend(X_int(:,3), fs);
X_int_4 = uniform_detrend(X_int(:,4), fs);
Y_int_1 = uniform_detrend(Y_int(:,1), fs);
Y_int_2 = uniform_detrend(Y_int(:,2), fs);
Y_int_3 = uniform_detrend(Y_int(:,3), fs);
Y_int_4 = uniform_detrend(Y_int(:,4), fs);
Z_int_1 = uniform_detrend(Z_int(:,1), fs);
Z_int_2 = uniform_detrend(Z_int(:,2), fs);
Z_int_3 = uniform_detrend(Z_int(:,3), fs);
Z_int_4 = uniform_detrend(Z_int(:,4), fs);

%% TRUNCATE TO AVOID EDGE ARTIFACTS
X_dc_1 = X_dc_1(30*fs:1830*fs);
X_dc_2 = X_dc_2(30*fs:1830*fs);
X_dc_3 = X_dc_3(30*fs:1830*fs);
X_dc_4 = X_dc_4(30*fs:1830*fs);
Y_dc_1 = Y_dc_1(30*fs:1830*fs);
Y_dc_2 = Y_dc_2(30*fs:1830*fs);
Y_dc_3 = Y_dc_3(30*fs:1830*fs);
Y_dc_4 = Y_dc_4(30*fs:1830*fs);
Z_dc_1 = Z_dc_1(30*fs:1830*fs);
Z_dc_2 = Z_dc_2(30*fs:1830*fs);
Z_dc_3 = Z_dc_3(30*fs:1830*fs);
Z_dc_4 = Z_dc_4(30*fs:1830*fs);

X_geo_1 = X_geo_1(30*fs:1830*fs);
X_geo_2 = X_geo_2(30*fs:1830*fs);
X_geo_3 = X_geo_3(30*fs:1830*fs);
X_geo_4 = X_geo_4(30*fs:1830*fs);
Y_geo_1 = Y_geo_1(30*fs:1830*fs);
Y_geo_2 = Y_geo_2(30*fs:1830*fs);
Y_geo_3 = Y_geo_3(30*fs:1830*fs);
Y_geo_4 = Y_geo_4(30*fs:1830*fs);
Z_geo_1 = Z_geo_1(30*fs:1830*fs);
Z_geo_2 = Z_geo_2(30*fs:1830*fs);
Z_geo_3 = Z_geo_3(30*fs:1830*fs);
Z_geo_4 = Z_geo_4(30*fs:1830*fs);

X_int_1 = X_int_1(30*fs:1830*fs);
X_int_2 = X_int_2(30*fs:1830*fs);
X_int_3 = X_int_3(30*fs:1830*fs);
X_int_4 = X_int_4(30*fs:1830*fs);
Y_int_1 = Y_int_1(30*fs:1830*fs);
Y_int_2 = Y_int_2(30*fs:1830*fs);
Y_int_3 = Y_int_3(30*fs:1830*fs);
Y_int_4 = Y_int_4(30*fs:1830*fs);
Z_int_1 = Z_int_1(30*fs:1830*fs);
Z_int_2 = Z_int_2(30*fs:1830*fs);
Z_int_3 = Z_int_3(30*fs:1830*fs);
Z_int_4 = Z_int_4(30*fs:1830*fs);

%% SUM NEAR-DC, GEOPHYSICAL, & INTERFERENCE DATA
X_tot_1 = X_dc_1 + X_geo_1 + X_int_1;
X_tot_2 = X_dc_2 + X_geo_2 + X_int_2;
X_tot_3 = X_dc_3 + X_geo_3 + X_int_3;
X_tot_4 = X_dc_4 + X_geo_4 + X_int_4;
Y_tot_1 = Y_dc_1 + Y_geo_1 + Y_int_1;
Y_tot_2 = Y_dc_2 + Y_geo_2 + Y_int_2;
Y_tot_3 = Y_dc_3 + Y_geo_3 + Y_int_3;
Y_tot_4 = Y_dc_4 + Y_geo_4 + Y_int_4;
Z_tot_1 = Z_dc_1 + Z_geo_1 + Z_int_1;
Z_tot_2 = Z_dc_2 + Z_geo_2 + Z_int_2;
Z_tot_3 = Z_dc_3 + Z_geo_3 + Z_int_3;
Z_tot_4 = Z_dc_4 + Z_geo_4 + Z_int_4;

%% SETUP OUTPUT STRUCTURES
mag_total.mag1_total = [X_tot_1 Y_tot_1 Z_tot_1];
mag_total.mag2_total = [X_tot_2 Y_tot_2 Z_tot_2];
mag_total.mag3_total = [X_tot_3 Y_tot_3 Z_tot_3];
mag_total.mag4_total = [X_tot_4 Y_tot_4 Z_tot_4];

mag_dc.mag1_dc = [X_dc_1 Y_dc_1 Z_dc_1];
mag_dc.mag2_dc = [X_dc_2 Y_dc_2 Z_dc_2];
mag_dc.mag3_dc = [X_dc_3 Y_dc_3 Z_dc_3];
mag_dc.mag4_dc = [X_dc_4 Y_dc_4 Z_dc_4];

mag_int.mag1_int = [X_int_1 Y_int_1 Z_int_1];
mag_int.mag2_int = [X_int_2 Y_int_2 Z_int_2];
mag_int.mag3_int = [X_int_3 Y_int_3 Z_int_3];
mag_int.mag4_int = [X_int_4 Y_int_4 Z_int_4];

mag_geo.mag1_geo = [X_geo_1 Y_geo_1 Z_geo_1];
mag_geo.mag2_geo = [X_geo_2 Y_geo_2 Z_geo_2];
mag_geo.mag3_geo = [X_geo_3 Y_geo_3 Z_geo_3];
mag_geo.mag4_geo = [X_geo_4 Y_geo_4 Z_geo_4];

%% SAVE OUT DATA
save('crm_testing.mat', 'mag_total', 'mag_dc', 'mag_int', 'mag_geo');



