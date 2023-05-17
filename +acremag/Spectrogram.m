function [f, t, psd, ps, lsd, ls, ENBW ] = Spectrogram(x,time,nfft,overlap,Fs)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
n = floor((numel(x)-(nfft-overlap))/overlap);
nfftPost = nfft/2+1;

f = nan(1,nfftPost);

if isdatetime(time)
    t = NaT(1,n,'TimeZone','UTCLeapSeconds');
else
    t = nan(1,n);
end

psd = nan(n,nfftPost);
ps = nan(n,nfftPost);
lsd = nan(n,nfftPost);
ls = nan(n,nfftPost);
ENBW = nan;

for i = 1:n
    y = x(1+(i-1)*overlap:(i-1)*overlap+nfft);
    z = detrend(y);
   
    [psd(i,:), ps(i,:), lsd(i,:), ls(i,:), ENBW, f]= acremag.DFT(z,Fs);
 
    t(i) = mean(time(1+(i-1)*overlap:(i-1)*overlap+nfft));
end


end

