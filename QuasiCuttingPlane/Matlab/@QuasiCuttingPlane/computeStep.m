% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis
%
% Method definition for QuasiCuttingPlane class

% Add pair
function [d,gamma] = computeStep(Q,F,a)

% Feed forward
dgamma = Q.W(:,a)*F(a);

% Split output
d     = dgamma(1:end-1);
gamma = dgamma(end);

end