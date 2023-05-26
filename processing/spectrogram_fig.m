close all
clear all

fs = 200;

filename = ["_data/level_2/combination_20_L2.mat", "_data/level_2/combination_100_L2.mat", "_data/level_2/combination_180_L2.mat"];

for i = 1:length(filename)
    [filepath, name, ext] = fileparts(filename(i));
    
    load(filename(i))
    
    data_1_combined = L2_Combined.L2_combined_2;
    data_1_interference = L2_Interference.L2_interference_2;
    
    %% Combined 
    data_1z_combined_detrended = uniform_detrend(data_1_combined(:,3), fs * 10);
    t = (0:length(data_1z_combined_detrended)-1)/(fs*60);
    figure;
    plot(t, data_1z_combined_detrended, 'LineWidth', 1.5, 'Color', 'Black')
    ylabel('B_Z (nT)')
    xlabel('Time (minutes)')
    title({name, '(Combined)'}, 'Interpreter', 'None')
    ylim([-50 50])
    ax = gca; 
    ax.FontSize = 20;
    ax.FontSize = 20;
    xticks([0, 5, 10, 15, 20, 25, 30])
    xticklabels({'', '5', '10', '15', '20', '25', ''})
    saveas(gcf, sprintf('_outputs/%s_combined_t.png', name))
    
    figure;
    spectrogram(data_1z_combined_detrended, 1024, [], 1024, fs, 'yaxis')
    colormap(flipud(gray))
    a = colorbar();
    a.Label.String = 'PSD (dB/Hz)';
    clim([-10 20])
    ylim([0 20])
    title({name, '(Combined)'}, 'Interpreter', 'None')
    ylabel({'f_Z (Hz)'})
    ax = gca; 
    ax.FontSize = 20;
    saveas(gcf, sprintf('_outputs/%s_combined_s.png', name))
    
    %% Interference
    figure;
    plot(t, data_1_interference(:,3), 'LineWidth', 1.5, 'Color', 'Black')
    ylabel('B_Z (nT)')
    xlabel('Time (minutes)')
    title({name, '(Interference)'}, 'Interpreter', 'None')
    ylim([-50 50])
    ax = gca; 
    ax.FontSize = 20;
    xticks([0, 5, 10, 15, 20, 25, 30])
    xticklabels({'', '5', '10', '15', '20', '25', ''})
    saveas(gcf, sprintf('_outputs/%s_inteference_t.png', name))
    
    figure;
    spectrogram(data_1_interference(:,3), 1024, [], 1024, fs, 'yaxis')
    colormap(flipud(gray))
    a = colorbar();
    a.Label.String = 'PSD (dB/Hz)';
    clim([-10 20])
    ylim([0 20])
    title({name, '(Interference)'}, 'Interpreter', 'None')
    ylabel({'f_Z (Hz)'})
    ax = gca; 
    ax.FontSize = 20;
    saveas(gcf, sprintf('_outputs/%s_interference_s.png', name))
end