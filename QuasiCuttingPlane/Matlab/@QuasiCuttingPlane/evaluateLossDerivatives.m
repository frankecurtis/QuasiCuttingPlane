% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis
%
% Method definition for QuasiCuttingPlane class

% Add pair
function gW = evaluateLossDerivatives(Q,F,J)

% Initialize derivatives
gW = zeros(size(Q.W));

% Set minibatch size
p = size(F,2);

% Loop over minibatch
for s = 1:p
  
  % Set activity indicators
  a = Q.setActivityIndicators(F(:,s));
  
  % Feed forward
  [d,gamma] = Q.feedForward(F(:,s));
  
  % Evaluate max linear term
  [l,active_index] = max([F(:,s) + J*d; gamma]);
  
  % Set matrix from loss function
  matrix = [-J ones(Q.m,1)]*Q.W - eye(Q.m);
  
  % Update derivatives
  for i = 1:Q.m
    for j = 1:Q.m
      gW(1:Q.n,i) = gW(1:Q.n,i) - (1/p)*(2*a(i)*a(j)* matrix(j,i)*J(j,:)');
      gW(end,i)   = gW(end,i)   + (1/p)*(2*a(i)*a(j)* matrix(j,i));
    end
  end
  
  % Check activity
  if active_index > Q.m
    for i = 1:Q.m
      gW(1:Q.n,i) = gW(1:Q.n,i) + (1/p)*(2*(1-a(i))*Q.W(1:Q.n,i));
      gW(end,i)   = gW(end,i)   + (1/p)*(2*l*F(i,s) + 2*(1-a(i))*Q.W(end,i));
    end
  else
    for i = 1:Q.m
      gW(1:Q.n,i) = gW(1:Q.n,i) + (1/p)*(2*l*J(active_index,:)'*F(i,s) + 2*(1-a(i))*Q.W(1:Q.n,i));
      gW(end,i)   = gW(end,i)   + (1/p)*(2*(1-a(i))*Q.W(end,i));
    end
  end
  
end

end