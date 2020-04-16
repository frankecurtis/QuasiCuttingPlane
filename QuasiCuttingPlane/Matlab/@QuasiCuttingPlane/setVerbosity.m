% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis
%
% Method definition for QuasiCuttingPlane class

% Sets verbosity
function setVerbosity(Q,value)

% Check input type
if length(value) ~= 1 || ~isnumeric(value) || value ~= abs(value)
  error('QuasiCuttingPlane: Invalid input to setVerbosity.  Input must be nonnegative integer.');
end

% Print message
if Q.verbosity ~= value && value >= 1
  fprintf('QuasiCuttingPlane: Verbosity set to %d\n',value);
end

% If all is OK, then set option
Q.verbosity = value;

end