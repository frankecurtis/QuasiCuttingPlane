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

% Set minibatch size
p = size(F,2);

% Loop over minibatch
for s = 1:p
  
  % Feed forward
  [d,gamma] = Q.feedForward(F(:,s),a);
  
  % Evaluate loss
  loss = loss + (1/p)*(gamma + ...
                       norm(F(a,s) + J(a,:)*d - gamma)^2 + ...
                       norm([-J(a,:) ones(Q.n+1,1)]*Q.W(:,a) - eye(Q.n+1),'fro')^2);
  
end

end