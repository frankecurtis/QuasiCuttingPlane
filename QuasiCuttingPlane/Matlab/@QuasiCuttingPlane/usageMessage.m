% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis
%
% Method definition for QuasiCuttingPlane class

function msg = usageMessage

% Set usage message
msg = 'QuasiCuttingPlane: Usage:';
msg = [msg newline '  Q = QuasiCuttingPlane(n,m)'];
msg = [msg newline '      where n is the number of variables, and'];
msg = [msg newline '            m is the number of max terms'];

end