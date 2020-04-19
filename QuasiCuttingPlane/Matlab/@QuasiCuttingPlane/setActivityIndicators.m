% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis
%
% Method definition for QuasiCuttingPlane class

% Add pair
function a = setActivityIndicators(Q,F)

% Find largest elements
[~,I] = sort(F,'descend');

% Initialize activity indicators
a = zeros(Q.m,1);

% Set activity indicators
a(I(1:Q.n+1)) = 1;

end