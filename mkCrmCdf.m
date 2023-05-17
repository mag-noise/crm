function [cOutFile] = mkCrmCdf(cInFile)
% Convert a CRM matlab file into an ISTP compliant CDF
%
% [cOutFile] = mkCrmCdf(cInFile)
%
% Params:
%   cInFile (char vec)
%     The name of the input matlab file to convert to a CDF file.
%
% Returns:
%   cOutFile (char vec)
%     The name of the CDF file created.
%
% TODO: 
%   1. Get the date on which Matt's files were created and update the
%      Logical_file_id global file attribute.
%   
%   2. Find out what the different combination numbers mean and convey
%      this meaning in global attributes and varible descriptions
	
	nHertz = 200;  % the sample rate
	
	tIn = load(cInFile);
	
	out = cdf.CDF();  % Empty CDF object
	
	% Write in global identifing attributes
	out.attr('Data_type') = {'H0>Benchmark Input'};
	out.attr('Data_version') = {1};
	out.attr('Descriptor') = {'CRM>Noise Mitigation Benchmark Input'};
	out.attr('Discipline') = {'Space Physics>Magnetospheric Science'};
	out.attr('Generated_by') = {'Finley, M. - University of Iowa'};
	out.attr('Instrument_type') = {'Magnetic Fields'};
	out.attr('Logical_file_id') = {'CRM_N0_MAG_20230101_V01'};
	out.attr('PI_affiliation') = {'The University of Iowa'};
	out.attr('PI_name') = {'Miles, D.'};
	out.attr('Project') = {'Constellation Ready Mag'};
	out.attr('Rules_of_use') = {...
		[...
			'I am paragraph one.', ...
			'Paragraph one continues on a second line here'...
		], ...
		[...
			'I am paragraph two.', ...
			'Paragraph two continues on a second line here'...
		]...
	};

	out.attr('Source_name') = {'CRM>Constellation Ready Magnetometers'};
	out.attr('TEXT') = {'DOI of Journal article goes here'};
	out.attr('Time_resolution') = {sprintf('%d Hz', nHertz)};
	
	out.attr('TITLE') = {'CRM - Interference Benchmarks'};
	
	% Define some string constants for less typing
	cV = 'VAR_TYPE';
	cU = 'UNITS';
	cD = 'CATDESC';
	cMax = 'VALIDMAX';
	rMax = 6e+4;
	cMin = 'VALIDMIN';
	rMin = -6e+4;
	cFill = 'FILLVAL';
	% Manually set the bit pattern so that "scary" negative nans go away.
	rNan = hex2num('7ff8000000000000');
	cF = 'FIELDNAM';
	cD0 = 'DEPEND_0';
	cL1 = 'LABL_PTR_1';
	cN = 'VAR_NOTES';
	
	% The one and only time array, starts at zero point of the TT2000
	% time scale (changed my mind, use rough date of data generation)
	%t0 = datetime('2000-01-01T11:58:55.816Z', 'TimeZone', 'UTCLeapSeconds');
	
	% TODO: Find out when the files were generated
	t0 = datetime('2023-04-15T00:00:00.000Z', 'TimeZone', 'UTCLeapSeconds');
	
	N = height(tIn.L2_Combined.L2_combined_1);
	aTime = t0 + seconds( (1:N)/nHertz );
	out.mkVar('Epoch', aTime, cU, 'UTC', cD, 'Measurement Time', cV, 'support_data');
	
	% Combined data
	aFields = fieldnames(tIn.L2_Combined);
	for iMag = 1:numel(aFields)
		% Question, what is a good name to ID each magnetometer?
		cDesc = sprintf('Combined Signal @ Mag%d', iMag);
		out.mkVar(...
			sprintf('CombinedMag%d', iMag), tIn.L2_Combined.(aFields{iMag})', ...
			cU, 'nT', cD, cDesc, cF, cDesc, cMax, rMax, cMin, rMin, cFill, rNan, ...
			cD0, 'Epoch', cL1, sprintf('LblCombinedMag%d', iMag), cV, 'data', ...
			cN, ['The full measured signal: Interference + Geophysical '...
			'Signal + Near-DC trend'] ...
		);
		
		cMag = sprintf('Mag%d', iMag);
		out.mkVar(...
			sprintf('LblCombinedMag%d', iMag), {...
			['Comb ' cMag ' Bx'];['Comb ' cMag ' By'];['Comb ' cMag ' Bz']...
			}, cD, ...
			sprintf('Component label for CombinedMag%d',iMag), cV, 'metadata' ...
		);
	end
	
	% Just the signal
	aFields = fieldnames(tIn.L2_Geophysical);
	for iMag = 1:numel(aFields)
		
		cDesc = sprintf('Geophysical Signal @ Mag%d', iMag);
		out.mkVar(...
			sprintf('SignalMag%d', iMag), tIn.L2_Geophysical.(aFields{iMag})', ...
			cU, 'nT', cD, cDesc, cF, cDesc, cMax, rMax, cMin, rMin, cFill, rNan, ...
			cD0, 'Epoch', cL1, sprintf('LblSignalMag%d', iMag), cV, 'data', ...
			cN, 'The external geophysical signal only'...
		);
	
		cMag = sprintf('Mag%d', iMag);
		out.mkVar(...
			sprintf('LblSignalMag%d', iMag), {...
			[cMag ' Bx'];[cMag ' By'];[cMag ' Bz']...
			}, cD, ...
			sprintf('Component label for SignalMag%d',iMag), cV, 'metadata' ...
		);
	end
	
	% Just the interference
	aFields = fieldnames(tIn.L2_Interference);
	for iMag = 1:numel(aFields)
		
		cDesc = sprintf('Local Interference Noise @ Mag%d', iMag);
		out.mkVar(...
			sprintf('NoiseMag%d', iMag), tIn.L2_Interference.(aFields{iMag})', ...
			cU, 'nT', cD, cDesc, cF, cDesc, cMax, rMax, cMin, rMin, cFill, rNan, ...
			cD0, 'Epoch', cL1, sprintf('LblNoiseMag%d', iMag), cV, 'data', ...
			cN, 'The local interference noise only'...
		);
	
		cMag = sprintf('Mag%d', iMag);
		out.mkVar(...
			sprintf('LblNoiseMag%d', iMag), {...
			['Noise ' cMag ' Bx'];['Noise ' cMag ' By'];['Noise ' cMag ' Bz']...
			}, cD, ...
			sprintf('Component label for InterMag%d',iMag), cV, 'metadata' ...
		);
	end
	
	% Just the trend
	aFields = fieldnames(tIn.L2_Trend);
	for iMag = 1:numel(aFields)
		
		cDesc = sprintf('Near DC Trend @ Mag%d', iMag);
		out.mkVar(...
			sprintf('TrendMag%d', iMag), tIn.L2_Trend.(aFields{iMag})', ...
			cU, 'nT', cD, cDesc, cF, cDesc, cMax, rMax, cMin, rMin, cFill, rNan, ...
			cD0, 'Epoch', cL1, sprintf('LblTrendMag%d', iMag), cV, 'data', ...
			cN, 'The near DC trend only'...
		);
	
		cMag = sprintf('Mag%d', iMag);
		out.mkVar(...
			sprintf('LblTrendMag%d', iMag), {...
			['Trend ' cMag ' Bx'];['Trend ' cMag ' By'];['Trend ' cMag ' Bz']...
			}, cD, ...
			sprintf('Component label for TrendMag%d',iMag), cV, 'metadata' ...
		);
	end
	
	[cDir, cBase, ~] = fileparts(cInFile);
	
	cOutFile = [cDir filesep 'CRM_' cBase '.cdf'];
	disp(['Writing file ' cOutFile]);
	out.save(cOutFile);
	
end
