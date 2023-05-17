function [psd, ps, lsd, ls, ENBW, freq] = DFT(x,Fs)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    freq = 0:Fs/length(x):Fs/2;
    N = length(x);
    window = hann(N);
    s1 = sum(hann(N));
    NENBW = 1.5000;
    
    ENBW = NENBW*Fs/N;


    xdft = fft(x.*window);
    xdft = xdft(1:N/2+1);
    ps = abs(xdft).^2;
    ps(2:end-1) = 2*ps(2:end-1);
    ps = ps/(s1^2);
    psd = ps / ENBW;
    lsd = sqrt(psd);
    ls = sqrt(ps);
    
    ps = transpose(ps);
    psd = transpose(psd);
    ls = transpose(ls);
    lsd = transpose(lsd);
    

end

