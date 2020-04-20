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

% Set minibatch size
p = size(F,2);

% Loop over minibatch
for s = 1:p
  
  % Feed forward
  [d,gamma] = Q.feedForward(F(:,s),a);
  
  % Evaluate loss derivatives
  gW(:,a) = gW(:,a) + (2/p)*([zeros(Q.n,Q.n+1);
                              F(a,s)'/2] + ...
                             [J(a,:)'*(F(a,s) + J(a,:)*d - gamma*ones(Q.n+1,1))*F(a,s)';
                              F(a,s)'*(gamma*(Q.n+1) - sum(F(a,s) + J(a,:)*d))] + ...
                             [-J(a,:) ones(Q.n+1,1)]'*([-J(a,:) ones(Q.n+1,1)]*Q.W(:,a) - eye(Q.n+1)));
  
end

end