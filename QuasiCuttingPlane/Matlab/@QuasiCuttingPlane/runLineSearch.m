% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis
%
% Method definition for QuasiCuttingPlane class

% Add pair
function alpha = runLineSearch(Q,F,J,a,gW)

% Store current values and loss
W = Q.W;
loss = Q.evaluateLoss(F,J,a);

% Initialize stepsize
alpha = 1;

% Set trial values
Q.W = Q.W - alpha*gW;

% Evaluate new loss
loss_new = Q.evaluateLoss(F,J,a);

% Line search
while 1
  
  % Check for decrease
  if loss_new < loss - Q.LS_CON*alpha*norm(gW,'fro')^2, break; end
  
  % Check for small stepsize
  if alpha < Q.LS_MIN, Q.W = W; break; end
  
  % Reset values
  Q.W = W;
  
  % Reduce stepsize
  alpha = alpha/2;

  % Set trial values
  Q.W = Q.W - alpha*gW;

  % Evaluate new loss
  loss_new = Q.evaluateLoss(F,J,a);

end

end