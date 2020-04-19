% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis
%
% Method definition for QuasiCuttingPlane class

% Add pair
function alpha = runLineSearch(Q,F,J,gW)

% Store current values and loss
W = Q.W;
[loss,~] = Q.evaluateLoss(F,J);

% Initialize stepsize
alpha = 1;

% Set trial values
Q.W = Q.W - alpha*gW;

% Evaluate new loss
[loss_new,~] = Q.evaluateLoss(F,J);

% Line search
while 1
  
  % Check for decrease
  if loss_new < loss - 1e-1*alpha*norm(gW,'fro')^2, break; end
  
  % Check for small stepsize
  if alpha < 1e-20, Q.W = W; break; end
  
  % Reset values
  Q.W = W;
  
  % Reduce stepsize
  alpha = alpha/2;

  % Set trial values
  Q.W = Q.W - alpha*gW;

  % Evaluate new loss
  [loss_new,~] = Q.evaluateLoss(F,J);

end

end