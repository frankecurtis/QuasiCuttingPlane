% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis
%
% Method definition for QuasiCuttingPlane class

% Add pair
function runLineSearch(Q,F,J,d,gamma,ga,gW)

% Store current values and loss
a = Q.a;
W = Q.W;
[loss,~] = Q.evaluateLoss(F,J,d,gamma);

% Initialize stepsize
alpha = 1;

% Set trial values
Q.a = Q.a - alpha*ga; Q.a = max(0,min(Q.a,1));
Q.W = Q.W - alpha*gW;

% Evaluate new loss
[d,gamma] = Q.feedForward(F);
[loss_new,~] = Q.evaluateLoss(F,J,d,gamma);

% Line search
while 1
  
  % Check for decrease
  if loss_new < loss, break; end
  
  % Check for small stepsize
  if alpha < 1e-20, Q.a = a; Q.W = W; break; end
  
  % Reset values
  Q.a = a;
  Q.W = W;
  
  % Reduce stepsize
  alpha = alpha/2;

  % Set trial values
  Q.a = Q.a - alpha*ga; Q.a = max(0,min(Q.a,1));
  Q.W = Q.W - alpha*gW;

  % Evaluate new loss
  [d,gamma] = Q.feedForward(F);
  [loss_new,~] = Q.evaluateLoss(F,J,d,gamma);

end

end