% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis
%
% Method definition for QuasiCuttingPlane class

% Add pair
function [loss,active_index] = evaluateLoss(Q,F,J)

% Initialize loss
loss = 0;

% Set minibatch size
p = size(F,2);

% Loop over minibatch
for s = 1:p
  
  % Feed forward
  [d,gamma] = Q.feedForward(F(:,s));
  
  % Evaluate max linear term
  [l1,active_index] = max([F(:,s) + J*d; gamma]);
  
  % Update loss
  loss = loss + (1/p)*l1;
  
  % Evaluate identity mapping penalty
  matrix = [-J ones(Q.m,1)]*Q.W - eye(Q.m);
  l2 = 0;
  for i = 1:Q.m
    for j = 1:Q.m
      l2 = l2 + (Q.a(i)*Q.a(j)*matrix(i,j))^2;
    end
  end
  
  % Update loss
  loss = loss + (1/p)*l2;
  
  % Evaluate inactive penalty term
  l3 = 0;
  for i = 1:Q.m
    l3 = l3 + (1 - Q.a(i))*Q.W(:,i)'*Q.W(:,i);
  end
  
  % Update loss
  loss = loss + (1/p)*l3;
  
  % Evaluate number of active penalty term
  l4 = (Q.n + 1 - sum(Q.a))^2;
  
  % Update loss
  loss = loss + (1/p)*l4;
  
  % Print losses
  if Q.verbosity >= 1
    fprintf('QuasiCuttingPlane: Loss, active index  = %+e\n',active_index);
    fprintf('QuasiCuttingPlane: Loss, max linear    = %+e\n',l1);
    fprintf('QuasiCuttingPlane: Loss, identity map  = %+e\n',l2);
    fprintf('QuasiCuttingPlane: Loss, inactive      = %+e\n',l3);
    fprintf('QuasiCuttingPlane: Loss, number active = %+e\n',l4);
  end
  
end

% Print total loss
if Q.verbosity >= 1
  fprintf('QuasiCuttingPlane: Loss, total         = %+e\n',loss);
end

end