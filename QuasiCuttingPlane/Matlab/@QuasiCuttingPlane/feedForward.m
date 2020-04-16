% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis
%
% Method definition for QuasiCuttingPlane class

% Add pair
function [d,gamma] = feedForward(Q,F)

% Feed forward
dgamma = Q.W*(Q.a.*F);

% Split output
d     = dgamma(1:end-1);
gamma = dgamma(end);

end