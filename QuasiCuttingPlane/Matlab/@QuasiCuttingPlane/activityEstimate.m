% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis
%
% Method definition for QuasiCuttingPlane class

% Add pair
function a = activityEstimate(Q,F)

% Find largest elements
[~,I] = sort(F,'descend');

% Set estimate
a = I(1:Q.n+1);

end