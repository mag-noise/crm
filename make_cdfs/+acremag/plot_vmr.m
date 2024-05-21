function [] = plot_vmr(cCsvFile)
	% Plot an 11 column constellation ready mag file.
	tbl = readmatrix(cCsvFile);
	
	% Vecnorm operates columnwise, but tables load row-wise hence the
	% transpose below 
	
	tUnixUTC = tbl(:,2).';
	tz_offset = -5*60*60;
	dt = datetime(tUnixUTC+tz_offset, 'ConvertFrom','epochtime');
	
	for i = 1:4
		% load as column vectors, and in each column is a triplet of Bx,By,Bz
		V = tbl(:,i+2:i+4).';
		
		Vavg = [ mean(V(1,:)); mean(V(2,:)); mean(V(3,:)) ];
		
		sub = subplot(4,1,i);
		plot( ...
			dt, V(1,:) - Vavg(1), ...
			dt, V(2,:) - Vavg(2), ...
			dt, V(3,:) - Vavg(3) ...
		);
	end
	
end

%% Ancillary
function [] = spectrogram_(tableData)
	% Vecnorm operates columnwise, but tables load row-wise hence the
	% transpose below 
	time = tableData(:,2).';
	
	Norms = [
		vecnorm( tableData(:, 3: 5).' );
		vecnorm( tableData(:, 6: 8).' );
		vecnorm( tableData(:, 9:11).' );
		vecnorm( tableData(:,12:14).' );
	];

	size(Norms)
	
	for i = 1:4
		
		p = subplot(4,1,i);
	
		[freq, t, psd, ~, ~, ~] = acremag.Spectrogram(Norms(i,:), time, 128, 2, 400);
	
		tz_offset = -5*60*60;
		dt = datetime(t+tz_offset, 'ConvertFrom','epochtime');
		
		surf(dt, freq, 10*log10(sqrt(abs(psd.'))), 'linestyle', 'none');
		view(0,90);
	end
	
end

	
	
	
	
	