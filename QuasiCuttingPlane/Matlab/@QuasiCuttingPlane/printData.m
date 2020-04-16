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

% Print vector data
fprintf('Weights (activities) = \n');
disp(Q.a);

% Print matrix data
fprintf('Weights (inverse) = \n');
disp(Q.W);

end