% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis
%
% Method definition for QuasiCuttingPlane class

% Add pair
function gW = evaluateLossDerivatives(Q,F,J,a)

% Initialize derivatives
gW = zeros(size(Q.W));

% Add derivative for gamma
%gW(:,a) = gW(:,a) + [zeros(Q.n,length(a)); F(a)'];

% Add derivative for inverse term
gW(:,a) = gW(:,a) + 2*[-J(a,:) ones(length(a),1)]'*([-J(a,:) ones(length(a),1)]*Q.W(:,a) - eye(length(a)));

end