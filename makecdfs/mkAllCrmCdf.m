function [nFilesGenerated] = mkAllCrmCdf(cInDir, cOutDir)
%
% [nFilesGenerated] = mkAllCrmCdf(cInputDir, cOutputDir)
%
% Params:
%   cInDir (char vec)
%      A location for files named combination_*_L2.mat, where * represents
%      an integer
%   cOutDir (char vec)
%      The location to write the resulting CDF files.

    mkdir(cOutDir);

    % Loop over all files matching the desired pattern
    aFiles = dir([cInDir filesep 'crm_*_l2.mat']);
    nWritten = 0;
    for i = 1:length(aFiles)
       mkCrmCdf([cInDir filesep aFiles(i).name], cOutDir);
       nWritten = nWritten + 1;
    end
end

