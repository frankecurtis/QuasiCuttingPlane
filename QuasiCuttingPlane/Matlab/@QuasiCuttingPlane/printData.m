% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis
%
% Method definition for QuasiCuttingPlane class

% Print data (for debugging)
function printData(Q)

% Print scalar data
fprintf('QuasiCuttingPlane: Printing data...\n');
fprintf('Variables = %d\n',Q.n);
fprintf('Max terms = %d\n',Q.m);
fprintf('Verbosity = %d\n',Q.verbosity);

end