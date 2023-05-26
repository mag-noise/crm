close all 
clear all

%% PROCESS INTERFERENCE
disp('Processing Interference Data...')
L0_int_filepattern = fullfile('_data/level_0/int', '*.tsv');
L0_int_filelist = dir(L0_int_filepattern);

fs = 200;

for filenum = 1:length(L0_int_filelist)
    basename = L0_int_filelist(filenum).name;
    fullname = fullfile(L0_int_filelist(filenum).folder, basename);

    [L0_X_int, L0_Y_int, L0_Z_int] = read_tsv(fullname, fs, 0);
    
    % Filter to move to near-zero
    filt_length = 20 * fs;
    L1_X_int_1 = L0_X_int(:,1);
    L1_X_int_2 = L0_X_int(:,2);
    L1_X_int_3 = L0_X_int(:,3);
    L1_X_int_4 = L0_X_int(:,4);
    L1_Y_int_1 = L0_Y_int(:,1);
    L1_Y_int_2 = L0_Y_int(:,2);
    L1_Y_int_3 = L0_Y_int(:,3);
    L1_Y_int_4 = L0_Y_int(:,4);
    L1_Z_int_1 = L0_Z_int(:,1);
    L1_Z_int_2 = L0_Z_int(:,2);
    L1_Z_int_3 = L0_Z_int(:,3);
    L1_Z_int_4 = L0_Z_int(:,4);

    % Truncate to correct length and avoid edge artifacts
    L1_X_int_1 = L1_X_int_1(30*fs:1830*fs);
    L1_X_int_2 = L1_X_int_2(30*fs:1830*fs);
    L1_X_int_3 = L1_X_int_3(30*fs:1830*fs);
    L1_X_int_4 = L1_X_int_4(30*fs:1830*fs);
    L1_Y_int_1 = L1_Y_int_1(30*fs:1830*fs);
    L1_Y_int_2 = L1_Y_int_2(30*fs:1830*fs);
    L1_Y_int_3 = L1_Y_int_3(30*fs:1830*fs);
    L1_Y_int_4 = L1_Y_int_4(30*fs:1830*fs);
    L1_Z_int_1 = L1_Z_int_1(30*fs:1830*fs);
    L1_Z_int_2 = L1_Z_int_2(30*fs:1830*fs);
    L1_Z_int_3 = L1_Z_int_3(30*fs:1830*fs);
    L1_Z_int_4 = L1_Z_int_4(30*fs:1830*fs);

    % Reformat to matrices
    L1_X = [L1_X_int_1 L1_X_int_2 L1_X_int_3 L1_X_int_4];
    L1_Y = [L1_Y_int_1 L1_Y_int_2 L1_Y_int_3 L1_Y_int_4];
    L1_Z = [L1_Z_int_1 L1_Z_int_2 L1_Z_int_3 L1_Z_int_4];

    % Determine rotation to mag_1 reference frame
    mag_1 = [L1_X_int_1, L1_Y_int_1, L1_Z_int_1];
    mag_2 = [L1_X_int_2, L1_Y_int_2, L1_Z_int_2];
    mag_3 = [L1_X_int_3, L1_Y_int_3, L1_Z_int_3];
    mag_4 = [L1_X_int_4, L1_Y_int_4, L1_Z_int_4];
    
    rotation_1 = eye(3);
    rotation_2 = mag_2 \ mag_1; % rotation from mag_2 to mag_1
    rotation_3 = mag_3 \ mag_1; % rotation from mag_3 to mag_1
    rotation_4 = mag_4 \ mag_1; % rotation from mag_4 to mag_1

    mag_1 = [uniform_detrend(L1_X_int_1, filt_length), uniform_detrend(L1_Y_int_1, filt_length), uniform_detrend(L1_Z_int_1, filt_length)];
    mag_2 = [uniform_detrend(L1_X_int_2, filt_length), uniform_detrend(L1_Y_int_2, filt_length), uniform_detrend(L1_Z_int_2, filt_length)];
    mag_3 = [uniform_detrend(L1_X_int_3, filt_length), uniform_detrend(L1_Y_int_3, filt_length), uniform_detrend(L1_Z_int_3, filt_length)];
    mag_4 = [uniform_detrend(L1_X_int_4, filt_length), uniform_detrend(L1_Y_int_4, filt_length), uniform_detrend(L1_Z_int_4, filt_length)];
    
    % Rotate
    mag_1_rotated = mag_1 * rotation_1;
    mag_2_rotated = mag_2 * rotation_2;
    mag_3_rotated = mag_3 * rotation_3;
    mag_4_rotated = mag_4 * rotation_4;

    % Breakout into components
    L2_X_dc_1 = mag_1_rotated(:,1);
    L2_X_dc_2 = mag_2_rotated(:,1);
    L2_X_dc_3 = mag_3_rotated(:,1);
    L2_X_dc_4 = mag_4_rotated(:,1);
    L2_Y_dc_1 = mag_1_rotated(:,2);
    L2_Y_dc_2 = mag_2_rotated(:,2);
    L2_Y_dc_3 = mag_3_rotated(:,2);
    L2_Y_dc_4 = mag_4_rotated(:,2);
    L2_Z_dc_1 = mag_1_rotated(:,3);
    L2_Z_dc_2 = mag_2_rotated(:,3);
    L2_Z_dc_3 = mag_3_rotated(:,3);
    L2_Z_dc_4 = mag_4_rotated(:,3);

    L2_X = [L2_X_dc_1 L2_X_dc_2 L2_X_dc_3 L2_X_dc_4];
    L2_Y = [L2_Y_dc_1 L2_Y_dc_2 L2_Y_dc_3 L2_Y_dc_4];
    L2_Z = [L2_Z_dc_1 L2_Z_dc_2 L2_Z_dc_3 L2_Z_dc_4];

    % Time Series Quicklook
    t = (1:length(L2_X_dc_1)) * (1/fs) * (1/60); % Minutes
    figure('Units','Normalized','OuterPosition', [0 0 1 1])
    tiledlayout(3,1)
    ax1 = nexttile;
    plot(t, L2_X_dc_2, 'LineWidth', 1.5)
    hold on
    plot(t, L2_X_dc_3, 'LineWidth', 1.5)
    plot(t, L2_X_dc_4, 'LineWidth', 1.5)
    plot(t, L2_X_dc_1, 'LineWidth', 1.5)
%     title(l2_filename, 'Interpreter', 'None')
    ylabel('B_{X} (nT)')

    ax2 = nexttile;
    plot(t, L2_Y_dc_2, 'LineWidth', 1.5)
    hold on
    plot(t, L2_Y_dc_3, 'LineWidth', 1.5)
    plot(t, L2_Y_dc_4, 'LineWidth', 1.5)
    plot(t, L2_Y_dc_1, 'LineWidth', 1.5)
    ylabel('B_{Y} (nT)')
    legend({'Mag2', 'Mag3', 'Mag4', 'Mag1'}, 'Location', 'EastOutside', 'NumColumns', 1)

    ax3 = nexttile;
    plot(t, L2_Z_dc_2, 'LineWidth', 1.5)
    hold on
    plot(t, L2_Z_dc_3, 'LineWidth', 1.5)
    plot(t, L2_Z_dc_4, 'LineWidth', 1.5)
    plot(t, L2_Z_dc_1, 'LineWidth', 1.5)
    ylabel('B_{Z} (nT)')
    xlabel('Time (min)')

    ax1_ylim = get(ax1, 'YLim');
    ax2_ylim = get(ax2, 'YLim');
    ax3_ylim = get(ax3, 'YLim');
    
    max_ylim = max([ax1_ylim, ax2_ylim, ax3_ylim]);
    min_ylim = min([ax1_ylim, ax2_ylim, ax3_ylim]);

    axis([ax1 ax2 ax3], [1 t(end) min_ylim max_ylim])

end