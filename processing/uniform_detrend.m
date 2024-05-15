%{
    Function: uniform_detrend.m
    Date/ Version: 08 May 2025 (v0.1)
    Author: Matthew G. Finley (NASA GSFC/University of Maryland)
    Contact: matthew.g.finley@nasa.gov

    Description: 
    This function applies uniform detrending to a signal. It subtracts the 
    moving average of the signal from the signal itself.

    Inputs:
    - x: The input signal to be detrended.
    - filt_length: The length of the moving average filter.

    Outputs:
    - y: The detrended signal.
%}

function y = uniform_detrend(x, filt_length)
    y = x - movmean(x, filt_length);
end