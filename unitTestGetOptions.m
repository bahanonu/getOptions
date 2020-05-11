function optionsCheck = unitTestGetOptions(varargin)
	% Unit test for getOptions.
	% Will perform 4 tests. Using Name-Value vs. options input and with or without structure crawling (recursion) enabled.
	% Biafra Ahanonu
	% started: 2015.12.03
	% inputs
		%
	% outputs
		%

	% changelog
		%
	% TODO
		%
	clc


	disp(repmat('=',1,7))
	disp('Default options')
	opts = unit_getOptions_testFunction(1,0);
	dispStruct(opts,'options',1);

	recursionStr = {'OFF','ON'};
	for recursionState = [0 1]
		disp(repmat('=',1,7))
		disp(['options test | recursion ' recursionStr{recursionState+1}])
		% Show that inputing an options stuct with sub-struct returns entire
		% sub-structs if user doesn't provide all sub-struct field names
		optsCheck.check1 = 20;
		optsCheck.check3 = 20;
		optsCheck.secondaryOpts.check1 =  'USA USA USA';
		optsCheck.secondaryOpts.check3 =  'AMERICA';
		optsCheck.secondaryOpts.check2.go1.h1 =  'AMERICA';
		optsCheck.secondaryOpts.check2.go1.h2 =  1776;
		optsCheck.secondaryOpts.check2.go2.h1 =  'AMERICA';
		optsCheck.secondaryOpts.check2.go2.h2 =  1776;
		optsCheck.secondaryOpts.tertiaryOptions.check1 = 'The rest of the world';
		opts = unit_getOptions_testFunction(recursionState,0,'options',optsCheck,1);
		dispStruct(opts,'options',1);
	end

	for recursionState = [0 1]
		disp(repmat('=',1,7))
		disp(['name-value struct test | recursion ' recursionStr{recursionState+1}])
		% Show that inputing struct as a name-value argument returns all that
		% sub-structs values
		secondaryOpts.check3 = 'America';
		secondaryOpts.tertiaryOpts.check1 = 'USA USA USA';
		secondaryOpts.tertiaryOpts.check3 = 'America';
		secondaryOpts.tertiaryOpts.moreOpts.check1 = 'USA USA USA';
		secondaryOpts.tertiaryOpts.moreOpts.check3 = 'America';
		opts = unit_getOptions_testFunction(recursionState,0,'secondaryOptions',secondaryOpts);
		dispStruct(opts,'options',1);
	end

	for recursionState = [0 1]
		disp(repmat('=',1,7))
		disp(['Default options using getSettings, should see warnings | name-value struct test | recursion ' recursionStr{recursionState+1}])
		% Show that inputing struct as a name-value argument returns all that
		% sub-structs values
		secondaryOpts.check3 = 'America';
		secondaryOpts.tertiaryOpts.check1 = 'USA USA USA';
		secondaryOpts.tertiaryOpts.check3 = 'America';
		secondaryOpts.tertiaryOpts.moreOpts.check1 = 'USA USA USA';
		secondaryOpts.tertiaryOpts.moreOpts.check3 = 'America';
		opts = unit_getOptions_testFunction(recursionState,1,'options',optsCheck);
		dispStruct(opts,'options',1);
	end
end
function opts = unit_getOptions_testFunction(arg1,arg2,varargin)
	% default options
	opts.check1 = 1;
	opts.check2 = 1;
	opts.secondaryOpts.check1 = 1;
	opts.secondaryOpts.check2.go1 = struct;
	opts.secondaryOpts.check2.go2 =  'USA USA USA';
	opts.secondaryOpts.quadOpts.check1 = 1;
	opts.secondaryOpts.quadOpts.check2 = {1,2};
	opts.secondaryOpts.tertiaryOpts.check1 = 1;
	opts.secondaryOpts.tertiaryOpts.check2 = 1;
	opts.secondaryOpts.tertiaryOpts.moreOpts.check1 = 1;
	opts.secondaryOpts.tertiaryOpts.moreOpts.check2 = 1;
	opts = getOptions(opts,varargin,'recursiveStructs',arg1,'getFunctionDefaults',arg2);
end
function dispStruct(iStruct,iField,lvlNum)
	if isstruct(iStruct)
		disp(['<strong>' iField '</strong>'])
		disp(iStruct)
		fprintf('\b')
		nameList = fieldnames(iStruct);
		for i = 1:length(nameList)
			if isstruct(iStruct.(nameList{i}))
				dispStruct(iStruct.(nameList{i}),nameList{i},lvlNum+1);
			end
		end
	else
	end
end