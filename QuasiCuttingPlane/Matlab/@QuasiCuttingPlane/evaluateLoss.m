% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis
%
% Method definition for QuasiCuttingPlane class

% Add pair
function loss = evaluateLoss(Q,F,J,a)

% Initialize loss
loss = 0;

% Add gamma
%loss = loss + Q.W(end,a)*F(a);

% Add inverse term
loss = loss + norm([-J(a,:) ones(length(a),1)]*Q.W(:,a) - eye(length(a)),'fro')^2;

end