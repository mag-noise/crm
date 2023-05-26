close all
clear all

fs = 200;

L1_dc_filepattern = '_data/level_1/trend/*_L1.mat';
L1_dc_filelist = dir(L1_dc_filepattern);

combination_number = 1;
for filenum = 1:length(L1_dc_filelist)
    trend_basename = L1_dc_filelist(filenum).name;
    fullname = fullfile(L1_dc_filelist(filenum).folder, trend_basename);

    data = load(fullname);
    L1_X_dc = data.L1_X;
    L1_Y_dc = data.L1_Y;
    L1_Z_dc = data.L1_Z;

    % Breakout into components
    L1_X_dc = L1_X_dc(:,2);
    L1_Y_dc = L1_Y_dc(:,2);
    L1_Z_dc = L1_Z_dc(:,2);

    L1_int_filepattern = '_data/level_1/int/*_L1.mat';
    L1_int_filelist = dir(L1_int_filepattern);

    for filenum = 1:length(L1_int_filelist)
        int_basename = L1_int_filelist(filenum).name;
        fullname = fullfile(L1_int_filelist(filenum).folder, int_basename);
    
        data = load(fullname);
        L1_X_int = data.L1_X;
        L1_Y_int = data.L1_Y;
        L1_Z_int = data.L1_Z;
    
        % Breakout into components
        L1_X_int_1 = L1_X_int(:,1);
        L1_X_int_2 = L1_X_int(:,2);
        L1_X_int_3 = L1_X_int(:,3);
        L1_X_int_4 = L1_X_int(:,4);
        L1_Y_int_1 = L1_Y_int(:,1);
        L1_Y_int_2 = L1_Y_int(:,2);
        L1_Y_int_3 = L1_Y_int(:,3);
        L1_Y_int_4 = L1_Y_int(:,4);
        L1_Z_int_1 = L1_Z_int(:,1);
        L1_Z_int_2 = L1_Z_int(:,2);
        L1_Z_int_3 = L1_Z_int(:,3);
        L1_Z_int_4 = L1_Z_int(:,4);
   
        L1_geo_filepattern = '_data/level_1/geo/*_L1.mat';
        L1_geo_filelist = dir(L1_geo_filepattern);
        
        for filenum = 1:length(L1_geo_filelist)
            geo_basename = L1_geo_filelist(filenum).name;
            fullname = fullfile(L1_geo_filelist(filenum).folder, geo_basename);
        
            data = load(fullname);
            L1_X_geo = data.L1_X;
            L1_Y_geo = data.L1_Y;
            L1_Z_geo = data.L1_Z;
        
            % Breakout into components
            L1_X_geo = L1_X_geo(:,2);
            L1_Y_geo = L1_Y_geo(:,2);
            L1_Z_geo = L1_Z_geo(:,2);
        
            % Combine
            L2_X_combined_1 = L1_X_dc + L1_X_geo + L1_X_int_1;
            L2_Y_combined_1 = L1_Y_dc + L1_Y_geo + L1_Y_int_1;
            L2_Z_combined_1 = L1_Z_dc + L1_Z_geo + L1_Z_int_1;
            L2_X_combined_2 = L1_X_dc + L1_X_geo + L1_X_int_2;
            L2_Y_combined_2 = L1_Y_dc + L1_Y_geo + L1_Y_int_2;
            L2_Z_combined_2 = L1_Z_dc + L1_Z_geo + L1_Z_int_2;
            L2_X_combined_3 = L1_X_dc + L1_X_geo + L1_X_int_3;
            L2_Y_combined_3 = L1_Y_dc + L1_Y_geo + L1_Y_int_3;
            L2_Z_combined_3 = L1_Z_dc + L1_Z_geo + L1_Z_int_3;
            L2_X_combined_4 = L1_X_dc + L1_X_geo + L1_X_int_4;
            L2_Y_combined_4 = L1_Y_dc + L1_Y_geo + L1_Y_int_4;
            L2_Z_combined_4 = L1_Z_dc + L1_Z_geo + L1_Z_int_4;
            
            % Format into matrices
            L2_combined_1 = [L2_X_combined_1, L2_Y_combined_1, L2_Z_combined_1];
            L2_combined_2 = [L2_X_combined_2, L2_Y_combined_2, L2_Z_combined_2];
            L2_combined_3 = [L2_X_combined_3, L2_Y_combined_3, L2_Z_combined_3];
            L2_combined_4 = [L2_X_combined_4, L2_Y_combined_4, L2_Z_combined_4];
            L2_Combined = struct('L2_combined_1', L2_combined_1, 'L2_combined_2', L2_combined_2, 'L2_combined_3', L2_combined_3, 'L2_combined_4', L2_combined_4);

            L2_interference_1 = [L1_X_int_1, L1_Y_int_1, L1_Z_int_1];
            L2_interference_2 = [L1_X_int_2, L1_Y_int_2, L1_Z_int_2];
            L2_interference_3 = [L1_X_int_3, L1_Y_int_3, L1_Z_int_3];
            L2_interference_4 = [L1_X_int_4, L1_Y_int_4, L1_Z_int_4];
            L2_Interference = struct('L2_interference_1', L2_interference_1, 'L2_interference_2', L2_interference_2, 'L2_interference_3', L2_interference_3, 'L2_interference_4', L2_interference_4);

            L2_trend_1 = [L1_X_dc, L1_Y_dc, L1_Z_dc];
            L2_trend_2 = [L1_X_dc, L1_Y_dc, L1_Z_dc];
            L2_trend_3 = [L1_X_dc, L1_Y_dc, L1_Z_dc];
            L2_trend_4 = [L1_X_dc, L1_Y_dc, L1_Z_dc];
            L2_Trend = struct('L2_trend_1', L2_trend_1, 'L2_trend_2', L2_trend_2, 'L2_trend_3', L2_trend_3, 'L2_trend_4', L2_trend_4);

            L2_geophysical_1 = [L1_X_geo, L1_Y_geo, L1_Z_geo];
            L2_geophysical_2 = [L1_X_geo, L1_Y_geo, L1_Z_geo];
            L2_geophysical_3 = [L1_X_geo, L1_Y_geo, L1_Z_geo];
            L2_geophysical_4 = [L1_X_geo, L1_Y_geo, L1_Z_geo];
            L2_Geophysical = struct('L2_geophysical_1', L2_geophysical_1, 'L2_geophysical_2', L2_geophysical_2, 'L2_geophysical_3', L2_geophysical_3, 'L2_geophysical_4', L2_geophysical_4);

            L2_SourceFiles = struct('TrendSource', trend_basename, 'IntSource', int_basename, 'GeoSource', geo_basename);

            % Save
            l2_filename = append("_data/level_2/combination_", num2str(combination_number), "_L2.mat");
            save(l2_filename, 'L2_Combined', 'L2_Interference', 'L2_Trend', 'L2_Geophysical', 'L2_SourceFiles', '-v7')

            % Time Series Quicklook
            t = (1:length(L2_X_combined_1)) * (1/fs) * (1/60); % Minutes
            figure('Units','Normalized','OuterPosition', [0 0 1 1])
            tiledlayout(3,1)
            ax1 = nexttile;
            plot(t, L2_X_combined_1, 'LineWidth', 1.5)
            hold on
            plot(t, L2_X_combined_2, 'LineWidth', 1.5)
            plot(t, L2_X_combined_3, 'LineWidth', 1.5)
            plot(t, L2_X_combined_4, 'LineWidth', 1.5)
            title(append("_data/level_2/combination_", num2str(combination_number), "_L2.mat"), 'Interpreter', 'None')
            ylabel('B_{X} (nT)')
        
            ax2 = nexttile;
            plot(t, L2_Y_combined_1, 'LineWidth', 1.5)
            hold on
            plot(t, L2_Y_combined_2, 'LineWidth', 1.5)
            plot(t, L2_Y_combined_3, 'LineWidth', 1.5)
            plot(t, L2_Y_combined_4, 'LineWidth', 1.5)
            ylabel('B_{Y} (nT)')
            legend({'Mag1', 'Mag2', 'Mag3', 'Mag4'}, 'Location', 'EastOutside', 'NumColumns', 1)
        
            ax3 = nexttile;
            plot(t, L2_Z_combined_1, 'LineWidth', 1.5)
            hold on
            plot(t, L2_Z_combined_2, 'LineWidth', 1.5)
            plot(t, L2_Z_combined_3, 'LineWidth', 1.5)
            plot(t, L2_Z_combined_4, 'LineWidth', 1.5)
            ylabel('B_{Z} (nT)')
            xlabel('Time (min)')
        
            ax1_ylim = get(ax1, 'YLim');
            ax2_ylim = get(ax2, 'YLim');
            ax3_ylim = get(ax3, 'YLim');
            
            max_ylim = max([ax1_ylim, ax2_ylim, ax3_ylim]);
            min_ylim = min([ax1_ylim, ax2_ylim, ax3_ylim]);
        
            axis([ax1 ax2 ax3], [1 t(end) min_ylim max_ylim])
            saveas(gcf, append("_data/level_2/combination_", num2str(combination_number), "_L2_Time_Quicklook.png"))
            close(gcf)
        
            % Frequency Quicklook
            figure('Units','Normalized','OuterPosition', [0 0 1 1])
            tiledlayout(3,1)
            ax1 = nexttile;
            spectrogram(L2_X_combined_1, 1024, [], 1024, fs, 'yaxis')
            clim([-20, 60])
            ylim([0, 25])
            ylabel({'f_{Mag2, X} (Hz)'})
            title(append("_data/level_2/combination_", num2str(combination_number), "_L2.mat"), 'Interpreter', 'None')
        
            ax2 = nexttile;
            spectrogram(L2_Y_combined_1, 1024, [], 1024, fs, 'yaxis')
            clim([-20, 60])
            ylim([0, 25])
            ylabel({'f_{Mag2, Y} (Hz)'})
        
            ax3 = nexttile;
            spectrogram(L2_Z_combined_1, 1024, [], 1024, fs, 'yaxis')
            clim([-20, 60])
            ylim([0, 25])
            ylabel({'f_{Mag2, Z} (Hz)'})
            
            saveas(gcf, append("_data/level_2/combination_", num2str(combination_number), "_L2_Freq_Quicklook.png"))
            close(gcf)

            combination_number = combination_number + 1;
        end
    end
end