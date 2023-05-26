close all
clear all

fs = 200;

%% PROCESS NEAR-DC DATA
disp('Processing Near-DC Data...')
L0_dc_filepattern = fullfile('_data/level_0/trend', '*.tsv');
L0_dc_filelist = dir(L0_dc_filepattern);

for filenum = 1:length(L0_dc_filelist)
    basename = L0_dc_filelist(filenum).name;
    fullname = fullfile(L0_dc_filelist(filenum).folder, basename);
    
    % Read TSV
    [L0_X_dc, L0_Y_dc, L0_Z_dc] = read_tsv(fullname, fs, 0);
    
    % Break out into components
    L0_X_dc_1 = L0_X_dc(:,1);
    L0_X_dc_2 = L0_X_dc(:,2);
    L0_X_dc_3 = L0_X_dc(:,3);
    L0_X_dc_4 = L0_X_dc(:,4);
    L0_Y_dc_1 = L0_Y_dc(:,1);
    L0_Y_dc_2 = L0_Y_dc(:,2);
    L0_Y_dc_3 = L0_Y_dc(:,3);
    L0_Y_dc_4 = L0_Y_dc(:,4);
    L0_Z_dc_1 = L0_Z_dc(:,1);
    L0_Z_dc_2 = L0_Z_dc(:,2);
    L0_Z_dc_3 = L0_Z_dc(:,3);
    L0_Z_dc_4 = L0_Z_dc(:,4);
    
    % Filter to remove all but near-dc trend
    filt_cutoff = 0.1;
    L1_X_dc_1 = lowpass(L0_X_dc_1, filt_cutoff, fs, 'StopbandAttenuation', 180, 'ImpulseResponse', 'iir');
    L1_X_dc_2 = lowpass(L0_X_dc_2, filt_cutoff, fs, 'StopbandAttenuation', 180, 'ImpulseResponse', 'iir');
    L1_X_dc_3 = lowpass(L0_X_dc_3, filt_cutoff, fs, 'StopbandAttenuation', 180, 'ImpulseResponse', 'iir');
    L1_X_dc_4 = lowpass(L0_X_dc_4, filt_cutoff, fs, 'StopbandAttenuation', 180, 'ImpulseResponse', 'iir');
    L1_Y_dc_1 = lowpass(L0_Y_dc_1, filt_cutoff, fs, 'StopbandAttenuation', 180, 'ImpulseResponse', 'iir');
    L1_Y_dc_2 = lowpass(L0_Y_dc_2, filt_cutoff, fs, 'StopbandAttenuation', 180, 'ImpulseResponse', 'iir');
    L1_Y_dc_3 = lowpass(L0_Y_dc_3, filt_cutoff, fs, 'StopbandAttenuation', 180, 'ImpulseResponse', 'iir');
    L1_Y_dc_4 = lowpass(L0_Y_dc_4, filt_cutoff, fs, 'StopbandAttenuation', 180, 'ImpulseResponse', 'iir');
    L1_Z_dc_1 = lowpass(L0_Z_dc_1, filt_cutoff, fs, 'StopbandAttenuation', 180, 'ImpulseResponse', 'iir');
    L1_Z_dc_2 = lowpass(L0_Z_dc_2, filt_cutoff, fs, 'StopbandAttenuation', 180, 'ImpulseResponse', 'iir');
    L1_Z_dc_3 = lowpass(L0_Z_dc_3, filt_cutoff, fs, 'StopbandAttenuation', 180, 'ImpulseResponse', 'iir');
    L1_Z_dc_4 = lowpass(L0_Z_dc_4, filt_cutoff, fs, 'StopbandAttenuation', 180, 'ImpulseResponse', 'iir');

    % Truncate to correct length and avoid edge artifacts
    L1_X_dc_1 = L1_X_dc_1(30*fs:1830*fs);
    L1_X_dc_2 = L1_X_dc_2(30*fs:1830*fs);
    L1_X_dc_3 = L1_X_dc_3(30*fs:1830*fs);
    L1_X_dc_4 = L1_X_dc_4(30*fs:1830*fs);
    L1_Y_dc_1 = L1_Y_dc_1(30*fs:1830*fs);
    L1_Y_dc_2 = L1_Y_dc_2(30*fs:1830*fs);
    L1_Y_dc_3 = L1_Y_dc_3(30*fs:1830*fs);
    L1_Y_dc_4 = L1_Y_dc_4(30*fs:1830*fs);
    L1_Z_dc_1 = L1_Z_dc_1(30*fs:1830*fs);
    L1_Z_dc_2 = L1_Z_dc_2(30*fs:1830*fs);
    L1_Z_dc_3 = L1_Z_dc_3(30*fs:1830*fs);
    L1_Z_dc_4 = L1_Z_dc_4(30*fs:1830*fs);

    % Reformat to matrices
    L1_X = [L1_X_dc_1 L1_X_dc_2 L1_X_dc_3 L1_X_dc_4];
    L1_Y = [L1_Y_dc_1 L1_Y_dc_2 L1_Y_dc_3 L1_Y_dc_4];
    L1_Z = [L1_Z_dc_1 L1_Z_dc_2 L1_Z_dc_3 L1_Z_dc_4];

    % Save
    split_filename = split(basename, '.');
    l1_filename = append("_data/level_1/trend/", split_filename(1), "_L1.mat");
    save(l1_filename, 'L1_X', 'L1_Y', 'L1_Z', '-v7')

    % Time Series Quicklook
    t = (1:length(L1_X_dc_1)) * (1/fs) * (1/60); % Minutes
    figure('Units','Normalized','OuterPosition', [0 0 1 1])
    tiledlayout(3,1)
    ax1 = nexttile;
    plot(t, L1_X_dc_1, 'LineWidth', 1.5)
    hold on
    plot(t, L1_X_dc_2, 'LineWidth', 1.5)
    plot(t, L1_X_dc_3, 'LineWidth', 1.5)
    plot(t, L1_X_dc_4, 'LineWidth', 1.5)
    title(l1_filename, 'Interpreter', 'None')
    ylabel('B_{X} (nT)')

    ax2 = nexttile;
    plot(t, L1_Y_dc_1, 'LineWidth', 1.5)
    hold on
    plot(t, L1_Y_dc_2, 'LineWidth', 1.5)
    plot(t, L1_Y_dc_3, 'LineWidth', 1.5)
    plot(t, L1_Y_dc_4, 'LineWidth', 1.5)
    ylabel('B_{Y} (nT)')
    legend({'Mag1', 'Mag2', 'Mag3', 'Mag4'}, 'Location', 'EastOutside', 'NumColumns', 1)

    ax3 = nexttile;
    plot(t, L1_Z_dc_1, 'LineWidth', 1.5)
    hold on
    plot(t, L1_Z_dc_2, 'LineWidth', 1.5)
    plot(t, L1_Z_dc_3, 'LineWidth', 1.5)
    plot(t, L1_Z_dc_4, 'LineWidth', 1.5)
    ylabel('B_{Z} (nT)')
    xlabel('Time (min)')

    ax1_ylim = get(ax1, 'YLim');
    ax2_ylim = get(ax2, 'YLim');
    ax3_ylim = get(ax3, 'YLim');
    
    max_ylim = max([ax1_ylim, ax2_ylim, ax3_ylim]);
    min_ylim = min([ax1_ylim, ax2_ylim, ax3_ylim]);

    axis([ax1 ax2 ax3], [1 t(end) min_ylim max_ylim])
    saveas(gcf, append("_data/level_1/trend/", split_filename(1), "_L1_Time_Quicklook.png"))
    close(gcf)

    % Frequency Quicklook
    figure('Units','Normalized','OuterPosition', [0 0 1 1])
    tiledlayout(3,1)
    ax1 = nexttile;
    spectrogram(L1_X_dc_2, 1024, [], 1024, fs, 'yaxis')
    clim([-20, 60])
    ylim([0, 25])
    ylabel({'f_{Mag2, X} (Hz)'})

    ax2 = nexttile;
    spectrogram(L1_Y_dc_2, 1024, [], 1024, fs, 'yaxis')
    clim([-20, 60])
    ylim([0, 25])
    ylabel({'f_{Mag2, Y} (Hz)'})

    ax3 = nexttile;
    spectrogram(L1_Z_dc_2, 1024, [], 1024, fs, 'yaxis')
    clim([-20, 60])
    ylim([0, 25])
    ylabel({'f_{Mag2, Z} (Hz)'})
    
    saveas(gcf, append("_data/level_1/trend/", split_filename(1), "_L1_Freq_Quicklook.png"))
    close(gcf)
end

%% PROCESS INTERFERENCE
disp('Processing Interference Data...')
L0_int_filepattern = fullfile('_data/level_0/int', '*.tsv');
L0_int_filelist = dir(L0_int_filepattern);

for filenum = 1:length(L0_int_filelist)
    basename = L0_int_filelist(filenum).name;
    fullname = fullfile(L0_int_filelist(filenum).folder, basename);

    [L0_X_int, L0_Y_int, L0_Z_int] = read_tsv(fullname, fs, 0);

    % Break out into components
    L0_X_int_1 = L0_X_int(:,1);
    L0_X_int_2 = L0_X_int(:,2);
    L0_X_int_3 = L0_X_int(:,3);
    L0_X_int_4 = L0_X_int(:,4);
    L0_Y_int_1 = L0_Y_int(:,1);
    L0_Y_int_2 = L0_Y_int(:,2);
    L0_Y_int_3 = L0_Y_int(:,3);
    L0_Y_int_4 = L0_Y_int(:,4);
    L0_Z_int_1 = L0_Z_int(:,1);
    L0_Z_int_2 = L0_Z_int(:,2);
    L0_Z_int_3 = L0_Z_int(:,3);
    L0_Z_int_4 = L0_Z_int(:,4);
    
    % Filter to move to near-zero
    filt_length = 20 * fs;
    L1_X_int_1 = uniform_detrend(L0_X_int_1, filt_length);
    L1_X_int_2 = uniform_detrend(L0_X_int_2, filt_length);
    L1_X_int_3 = uniform_detrend(L0_X_int_3, filt_length);
    L1_X_int_4 = uniform_detrend(L0_X_int_4, filt_length);
    L1_Y_int_1 = uniform_detrend(L0_Y_int_1, filt_length);
    L1_Y_int_2 = uniform_detrend(L0_Y_int_2, filt_length);
    L1_Y_int_3 = uniform_detrend(L0_Y_int_3, filt_length);
    L1_Y_int_4 = uniform_detrend(L0_Y_int_4, filt_length);
    L1_Z_int_1 = uniform_detrend(L0_Z_int_1, filt_length);
    L1_Z_int_2 = uniform_detrend(L0_Z_int_2, filt_length);
    L1_Z_int_3 = uniform_detrend(L0_Z_int_3, filt_length);
    L1_Z_int_4 = uniform_detrend(L0_Z_int_4, filt_length);

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

    % Save
    split_filename = split(basename, '.');
    l1_filename = append("_data/level_1/int/", split_filename(1), "_L1.mat");
    save(l1_filename, 'L1_X', 'L1_Y', 'L1_Z', '-v7')

    % Time Series Quicklook
    t = (1:length(L1_X_int_1)) * (1/fs) * (1/60); % Minutes
    figure('Units','Normalized','OuterPosition', [0 0 1 1])
    tiledlayout(3,1)
    ax1 = nexttile;
    plot(t, L1_X_int_1, 'LineWidth', 1.5)
    hold on
    plot(t, L1_X_int_2, 'LineWidth', 1.5)
    plot(t, L1_X_int_3, 'LineWidth', 1.5)
    plot(t, L1_X_int_4, 'LineWidth', 1.5)
    title(l1_filename, 'Interpreter', 'None')
    ylabel('B_{X} (nT)')

    ax2 = nexttile;
    plot(t, L1_Y_int_1, 'LineWidth', 1.5)
    hold on
    plot(t, L1_Y_int_2, 'LineWidth', 1.5)
    plot(t, L1_Y_int_3, 'LineWidth', 1.5)
    plot(t, L1_Y_int_4, 'LineWidth', 1.5)
    ylabel('B_{Y} (nT)')
    legend({'Mag1', 'Mag2', 'Mag3', 'Mag4'}, 'Location', 'EastOutside', 'NumColumns', 1)

    ax3 = nexttile;
    plot(t, L1_Z_int_1, 'LineWidth', 1.5)
    hold on
    plot(t, L1_Z_int_2, 'LineWidth', 1.5)
    plot(t, L1_Z_int_3, 'LineWidth', 1.5)
    plot(t, L1_Z_int_4, 'LineWidth', 1.5)
    ylabel('B_{Z} (nT)')
    xlabel('Time (min)')

    ax1_ylim = get(ax1, 'YLim');
    ax2_ylim = get(ax2, 'YLim');
    ax3_ylim = get(ax3, 'YLim');
    
    max_ylim = max([ax1_ylim, ax2_ylim, ax3_ylim]);
    min_ylim = min([ax1_ylim, ax2_ylim, ax3_ylim]);

    axis([ax1 ax2 ax3], [1 t(end) min_ylim max_ylim])
    saveas(gcf, append("_data/level_1/int/", split_filename(1), "_L1_Time_Quicklook.png"))
    close(gcf)

    % Frequency Quicklook
    figure('Units','Normalized','OuterPosition', [0 0 1 1])
    tiledlayout(3,1)
    ax1 = nexttile;
    spectrogram(L1_X_int_2, 1024, [], 1024, fs, 'yaxis')
    clim([-20, 60])
    ylim([0, 25])
    ylabel({'f_{Mag2, X} (Hz)'})

    ax2 = nexttile;
    spectrogram(L1_Y_int_2, 1024, [], 1024, fs, 'yaxis')
    clim([-20, 60])
    ylim([0, 25])
    ylabel({'f_{Mag2, Y} (Hz)'})

    ax3 = nexttile;
    spectrogram(L1_Z_int_2, 1024, [], 1024, fs, 'yaxis')
    clim([-20, 60])
    ylim([0, 25])
    ylabel({'f_{Mag2, Z} (Hz)'})
    
    saveas(gcf, append("_data/level_1/int/", split_filename(1), "_L1_Freq_Quicklook.png"))
    close(gcf)
end

%% PROCSES GEOPHYSICAL SIGNALS
disp('Processing Geophysical Data...')
L0_geo_filepattern = fullfile('_data/level_0/geo', '*.tsv');
L0_geo_filelist = dir(L0_geo_filepattern);

for filenum = 1:length(L0_geo_filelist)
    basename = L0_geo_filelist(filenum).name;
    fullname = fullfile(L0_geo_filelist(filenum).folder, basename);

    [L0_X_geo, L0_Y_geo, L0_Z_geo] = read_tsv(fullname, fs, 0);
    
    % Breakout into components
    L0_X_geo_1 = L0_X_geo(:,1);
    L0_X_geo_2 = L0_X_geo(:,2);
    L0_X_geo_3 = L0_X_geo(:,3);
    L0_X_geo_4 = L0_X_geo(:,4);
    L0_Y_geo_1 = L0_Y_geo(:,1);
    L0_Y_geo_2 = L0_Y_geo(:,2);
    L0_Y_geo_3 = L0_Y_geo(:,3);
    L0_Y_geo_4 = L0_Y_geo(:,4);
    L0_Z_geo_1 = L0_Z_geo(:,1);
    L0_Z_geo_2 = L0_Z_geo(:,2);
    L0_Z_geo_3 = L0_Z_geo(:,3);
    L0_Z_geo_4 = L0_Z_geo(:,4);
    
    % Truncate to correct length and avoid edge artifacts
    L1_X_geo_1 = L0_X_geo_1(30*fs:1830*fs);
    L1_X_geo_2 = L0_X_geo_2(30*fs:1830*fs);
    L1_X_geo_3 = L0_X_geo_3(30*fs:1830*fs);
    L1_X_geo_4 = L0_X_geo_4(30*fs:1830*fs);
    L1_Y_geo_1 = L0_Y_geo_1(30*fs:1830*fs);
    L1_Y_geo_2 = L0_Y_geo_2(30*fs:1830*fs);
    L1_Y_geo_3 = L0_Y_geo_3(30*fs:1830*fs);
    L1_Y_geo_4 = L0_Y_geo_4(30*fs:1830*fs);
    L1_Z_geo_1 = L0_Z_geo_1(30*fs:1830*fs);
    L1_Z_geo_2 = L0_Z_geo_2(30*fs:1830*fs);
    L1_Z_geo_3 = L0_Z_geo_3(30*fs:1830*fs);
    L1_Z_geo_4 = L0_Z_geo_4(30*fs:1830*fs);

    % Reformat to matrices
    L1_X = [L1_X_geo_1 L1_X_geo_2 L1_X_geo_3 L1_X_geo_4];
    L1_Y = [L1_Y_geo_1 L1_Y_geo_2 L1_Y_geo_3 L1_Y_geo_4];
    L1_Z = [L1_Z_geo_1 L1_Z_geo_2 L1_Z_geo_3 L1_Z_geo_4];

    % Save
    split_filename = split(basename, '.');
    l1_filename = append("_data/level_1/geo/", split_filename(1), "_L1.mat");
    save(l1_filename, 'L1_X', 'L1_Y', 'L1_Z', '-v7')

    % Time Series Quicklook
    t = (1:length(L1_X_geo_1)) * (1/fs) * (1/60); % Minutes
    figure('Units','Normalized','OuterPosition', [0 0 1 1])
    tiledlayout(3,1)
    ax1 = nexttile;
    plot(t, L1_X_geo_1, 'LineWidth', 1.5)
    hold on
    plot(t, L1_X_geo_2, 'LineWidth', 1.5)
    plot(t, L1_X_geo_3, 'LineWidth', 1.5)
    plot(t, L1_X_geo_4, 'LineWidth', 1.5)
    title(l1_filename, 'Interpreter', 'None')
    ylabel('B_{X} (nT)')

    ax2 = nexttile;
    plot(t, L1_Y_geo_1, 'LineWidth', 1.5)
    hold on
    plot(t, L1_Y_geo_2, 'LineWidth', 1.5)
    plot(t, L1_Y_geo_3, 'LineWidth', 1.5)
    plot(t, L1_Y_geo_4, 'LineWidth', 1.5)
    ylabel('B_{Y} (nT)')
    legend({'Mag1', 'Mag2', 'Mag3', 'Mag4'}, 'Location', 'EastOutside', 'NumColumns', 1)

    ax3 = nexttile;
    plot(t, L1_Z_geo_1, 'LineWidth', 1.5)
    hold on
    plot(t, L1_Z_geo_2, 'LineWidth', 1.5)
    plot(t, L1_Z_geo_3, 'LineWidth', 1.5)
    plot(t, L1_Z_geo_4, 'LineWidth', 1.5)
    ylabel('B_{Z} (nT)')
    xlabel('Time (min)')

    ax1_ylim = get(ax1, 'YLim');
    ax2_ylim = get(ax2, 'YLim');
    ax3_ylim = get(ax3, 'YLim');
    
    max_ylim = max([ax1_ylim, ax2_ylim, ax3_ylim]);
    min_ylim = min([ax1_ylim, ax2_ylim, ax3_ylim]);

    axis([ax1 ax2 ax3], [1 t(end) min_ylim max_ylim])
    saveas(gcf, append("_data/level_1/geo/", split_filename(1), "_L1_Time_Quicklook.png"))
    close(gcf)

    % Frequency Quicklook
    figure('Units','Normalized','OuterPosition', [0 0 1 1])
    tiledlayout(3,1)
    ax1 = nexttile;
    spectrogram(L1_X_geo_2, 1024, [], 1024, fs, 'yaxis')
    clim([-20, 60])
    ylim([0, 25])
    ylabel({'f_{Mag2, X} (Hz)'})

    ax2 = nexttile;
    spectrogram(L1_Y_geo_2, 1024, [], 1024, fs, 'yaxis')
    clim([-20, 60])
    ylim([0, 25])
    ylabel({'f_{Mag2, Y} (Hz)'})

    ax3 = nexttile;
    spectrogram(L1_Z_geo_2, 1024, [], 1024, fs, 'yaxis')
    clim([-20, 60])
    ylim([0, 25])
    ylabel({'f_{Mag2, Z} (Hz)'})
    
    saveas(gcf, append("_data/level_1/geo/", split_filename(1), "_L1_Freq_Quicklook.png"))
    close(gcf)
end