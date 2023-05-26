close all
clear all

addpath('C:\matlib')

%%

cdf_file = cdf.CDF();
% vTime = datetime(2022, 11, 20, 17, 20, 10, 'Timezone', 'UTC') + seconds((1:length(chim_bx_sc_ds))*(1/(8192*8)));
% cdf_file.mkVar('Epoch', vTime, 'DESCRIPTION', 'Approximate Time - DO NOT USE FOR ANYTHING IMPORTANT!');
cdf_file.mkVar('CHIMERA_SC_Bx', chim_bx_sc_ds', 'UNITS', 'ADC_Counts', 'DESCRIPTION', 'BX', 'VAR_TYPE', 'data', 'DEPEND_0', 'Epoch');
cdf_file.mkVar('CHIMERA_SC_By', chim_by_sc_ds', 'UNITS', 'ADC_Counts', 'DESCRIPTION', 'BY', 'VAR_TYPE', 'data', 'DEPEND_0', 'Epoch');
cdf_file.mkVar('CHIMERA_SC_Bz', chim_bz_sc_ds', 'UNITS', 'ADC_Counts', 'DESCRIPTION', 'BZ', 'VAR_TYPE', 'data', 'DEPEND_0', 'Epoch');
cdf_file.mkVar('CHIMERA_SC_B', chim_b_sc', 'UNITS', 'ADC_Counts', 'DESCRIPTION', 'SCALAR', 'VAR_TYPE', 'data', 'DEPEND_0', 'Epoch');
cdf_file.save('C:\Users\mgfinley\Documents\Dev\aces-ii\high-flyer\CDF_CHIMERA_SC_ACESII_FLIGHT.cdf');