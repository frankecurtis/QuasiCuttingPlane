% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis
%
% Method definition for QuasiCuttingPlane class

% Add pair
function alpha = runLineSearch(Q,F,J,ga,gW)

% Store current values and loss
a = Q.a;
W = Q.W;
[loss,~] = Q.evaluateLoss(F,J);

% Initialize stepsize
alpha = 1;

% Set trial values
Q.a = Q.a - alpha*ga; Q.a = max(0,min(Q.a,1));
Q.W = Q.W - alpha*gW;

% Evaluate new loss
[loss_new,~] = Q.evaluateLoss(F,J);

% Line search
while 1
  
  % Check for decrease
  if loss_new < loss - 1e-8*alpha*(norm(ga)^2 + norm(gW,'fro')^2), break; end
  
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
  [loss_new,~] = Q.evaluateLoss(F,J);

end

end