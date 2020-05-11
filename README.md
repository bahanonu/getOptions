# getOptions

`getOptions` is a simple, user friendly way to handle variable argument inputs (varargin) into MATLAB functions.

Please see my 2014 write-up __[dealing with variable options (varargin) in matlab](https://bahanonu.com/getOptions)__ ([https://bahanonu.com/getOptions](https://bahanonu.com/getOptions)) for details and reasons behind implementing and using this function. Installation and usage instructions below.

Contact: __Biafra Ahanonu, PhD (bahanonu [at] alum [dot] mit [dot] edu)__.

Made in USA.<br>
<img src="https://user-images.githubusercontent.com/5241605/71493809-322a5400-27ff-11ea-9b2d-52ff20b5f332.png" align="center" title="USA" alt="USA" width="auto" height="50">

## Installation

Download or clone the `getOptions` repository and place the root folder in the MATLAB path. Follow instructions for use below.

Test by running `unitTestGetOptions` unit test. Will print out the modified structures and give out several warnings to show examples of what happens if user inputs Name-Value pairs that are not associated with any options.

## Instructions on use
There are two ways to have parent functions pass Name-Value pairs to child functions that `getOptions` will parse to update default options in child function.

### Method #1
Use the `'options', options` [Name-Value](https://www.mathworks.com/help/matlab/ref/varargin.html) pair to input an `options` structure that will overwrite default options in a function.
- The name of the `opts` variable does not matter, but have to have the `options` Name input as one of the variable arguments for `getOptions` to recognize using Method #1.
- If the user inputs a Name-Value pair that is not associated with an option for that function, `getOptions` gives out a warning rather than an error.

```MATLAB
mutationList = [1 2 3];
opts.Stargazer = 1;
opts.SHH = 0;
exampleFxn(mutationList,'options',opts);
```

### Method #2
Alternatively use Name-Value pairs for all variable input arguments. Will produce the same result as above.

```MATLAB
mutationList = [1 2 3];
exampleFxn(mutationList,'Stargazer',1,'SHH',0);
```

### `getOptions` in user functions
To adapt `getOptions` to your own functions, add the section marked `FUNCTION OPTIONS` at the beginning and add all your options.

```MATLAB
function [out1] = exampleFxn(in1,varargin)

    % ========================
    % FUNCTION OPTIONS
    % Description option #1
    opts.Stargazer = '';
    % Description option #2
    opts.SHH = 1;
    % get options
    opts = getOptions(opts,varargin);
    % disp(opts)
    % unpack options into current workspace (not recommended)
    % fn=fieldnames(opts);
    % for i=1:length(fn)
    %   eval([fn{i} '=opts.' fn{i} ';']);
    % end
    % ========================

    try
        % Do something.
    catch err
        disp(repmat('@',1,7))
        disp(getReport(err,'extended','hyperlinks','on'));
        disp(repmat('@',1,7))
    end
end
```

## Notes
- If `getOptions` masks an existing function due to naming conflicts, just rename it (e.g. `getOptionsCustom`) and it will function the same.
- `getOptions.m` can be placed in a package (e.g. `myPkg` within `+myPkg` folder) to allow it to be called as a function of that package (e.g. `myPkg.getOptions`) to reduce masking or naming conflicts if that is a concern.

## Using `getSettings`
To provide a central location for all options or allow users a central place to edit settings, can add each function's options to `getSettings` switch statement matching the parent functions name. See `getSettings.m` and call `getOptions` using the `getFunctionDefaults` Name-Value input as `opts = getOptions(opts,varargin,'getFunctionDefaults',1);`.

## License

See `LICENSE`. MIT @ Biafra Ahanonu