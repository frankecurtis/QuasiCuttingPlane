% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis
%
% Method definition for QuasiCuttingPlane class

% Constructor
function constructor(Q,n,m)

% First input must be number of variables, a positive integer
if ~isnumeric(n)
  msg = 'QuasiCuttingPlane: 1st input to constructor must be positive integer';
  msg = [msg newline '                   ... but given input is non-numeric'];
  msg = [msg newline Q.usageMessage];
  error(msg);
end
if length(n) ~= 1
  msg = 'QuasiCuttingPlane: 1st input to constructor must be positive integer';
  msg = [msg newline '                   ... but given input is not a scalar'];
  msg = [msg newline Q.usageMessage];
  error(msg);
end
if n ~= abs(n) || n < 1 || n == inf
  msg = 'QuasiCuttingPlane: 1st input to constructor must be positive integer';
  msg = [msg newline Q.usageMessage];
  error(msg);
end

% Set number of variables
Q.n = n;

% Second input must be number of terms in max, a positive integer
if ~isnumeric(m)
  msg = 'QuasiCuttingPlane: 2nd input to constructor must be positive integer';
  msg = [msg newline '                   ... but given input is non-numeric'];
  msg = [msg newline Q.usageMessage];
  error(msg);
end
if length(m) ~= 1
  msg = 'QuasiCuttingPlane: 2nd input to constructor must be positive integer';
  msg = [msg newline '                   ... but given input is not a scalar'];
  msg = [msg newline Q.usageMessage];
  error(msg);
end
if m ~= abs(m) || m < 1 || m == inf
  msg = 'QuasiCuttingPlane: 2nd input to constructor must be positive integer';
  msg = [msg newline Q.usageMessage];
  error(msg);
end

% Set number of terms in max
Q.m = m;

% Initialize weights
Q.W = zeros(Q.n+1,Q.m);

end