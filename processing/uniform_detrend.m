function y = uniform_detrend(x, filt_length)
    y = x - movmean(x, filt_length);
end