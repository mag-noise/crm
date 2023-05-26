function [X, Y, Z] = read_tsv(filename, fs, display)
    data = tdfread(filename);
    
    Bx1 = data.x0x2F00x2Fvector0x2Ex;
    Bx1 = Bx1(1 * fs:(end-fs));
    By1 = data.x0x2F00x2Fvector0x2Ey;
    By1 = By1(1 * fs:(end-fs));
    Bz1 = data.x0x2F00x2Fvector0x2Ez;
    Bz1 = Bz1(1 * fs:(end-fs));
    
    Bx2 = data.x0x2F10x2Fvector0x2Ex;
    Bx2 = Bx2(1 * fs:(end-fs));
    By2 = data.x0x2F10x2Fvector0x2Ey;
    By2 = By2(1 * fs:(end-fs));
    Bz2 = data.x0x2F10x2Fvector0x2Ez;
    Bz2 = Bz2(1 * fs:(end-fs));
    
    Bx3 = data.x0x2F20x2Fvector0x2Ex;
    Bx3 = Bx3(1 * fs:(end-fs));
    By3 = data.x0x2F20x2Fvector0x2Ey;
    By3 = By3(1 * fs:(end-fs));
    Bz3 = data.x0x2F20x2Fvector0x2Ez;
    Bz3 = Bz3(1 * fs:(end-fs));
    
    Bx4 = data.x0x2F30x2Fvector0x2Ex;
    Bx4 = Bx4(1 * fs:(end-fs));
    By4 = data.x0x2F30x2Fvector0x2Ey;
    By4 = By4(1 * fs:(end-fs));
    Bz4 = data.x0x2F30x2Fvector0x2Ez;
    Bz4 = Bz4(1 * fs:(end-fs));

    X = [Bx1 Bx2 Bx3 Bx4];
    Y = [By1 By2 By3 By4];
    Z = [Bz1 Bz2 Bz3 Bz4];
    
    if display == 1
        t = (1:length(Bx1)) / fs;
        
        c_up = 30;
        c_down = -10;
        y_up = 50;
        y_down = 0;
        nfft = 2048;
        wlen = hann(128);
        
        figure;
        subplot(3,1,1)
        plot(t, Bx1, 'LineWidth', 1.5)
        hold on
        plot(t, Bx2, 'LineWidth', 1.5)
        plot(t, Bx3, 'LineWidth', 1.5)
        plot(t, Bx4, 'LineWidth', 1.5)
        legend({'M1', 'M2', 'M3', 'M4'})
        ylabel('B_{X} (nT)')
        title(filename)
        
        subplot(3,1,2)
        plot(t, By1, 'LineWidth', 1.5)
        hold on
        plot(t, By2, 'LineWidth', 1.5)
        plot(t, By3, 'LineWidth', 1.5)
        plot(t, By4, 'LineWidth', 1.5)
        legend({'M1', 'M2', 'M3', 'M4'})
        ylabel('B_{Y} (nT)')

        subplot(3,1,3)
        plot(t, Bz1, 'LineWidth', 1.5)
        hold on
        plot(t, Bz2, 'LineWidth', 1.5)
        plot(t, Bz3, 'LineWidth', 1.5)
        plot(t, Bz4, 'LineWidth', 1.5)
        legend({'M1', 'M2', 'M3', 'M4'})
        ylabel('B_{Z} (nT)')
        xlabel('Time (sec)')

        figure;
        spectrogram(Bx2, 1024, [], 1024, fs, 'yaxis')
        ylim([0 30])
        clim([0 30])

        figure;
        spectrogram(By2, 1024, [], 1024, fs, 'yaxis')
        ylim([0 30])
        clim([0 30])

        figure;
        spectrogram(Bz2, 1024, [], 1024, fs, 'yaxis')
        ylim([0 30])
        clim([0 30])
    end
end


