function [options] = getSettings(functionName)
	% Send back default options to getOptions, users can modify settings here.
	% Biafra Ahanonu
	% started: 2014.12.10
	%
	% Inputs
	%   functionName - name of function whose option should be loaded
	% Note
		% Don't let this function call getOptions! Else you'll potentially get into an infinite loop.

	% changelog
		%

	try
		switch functionName
			case 'exampleFxn'
				options.example1 = '';
				options.example1 = 0;
			case 'exampleFxn2'
				% Str: DESCRIPTION.
				options.example1 = '';
				% Binary: DESCRIPTION.
				options.example1 = 0;
			case 'unitTestGetOptions'
				% Str: DESCRIPTION.
				options.example1 = '';
				% Binary: DESCRIPTION.
				options.example2 = 0;
			case 'unit_getOptions_testFunction'
				% Str: DESCRIPTION.
				options.example1 = '';
				% Binary: DESCRIPTION.
				options.example2 = 0;
			otherwise
				options.error = 1;
		end
	catch err
		display(repmat('@',1,7))
		disp(getReport(err,'extended','hyperlinks','on'));
		display(repmat('@',1,7))
		options = [];
	end
end