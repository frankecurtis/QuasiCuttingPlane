% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis
%
% Method definition for QuasiCuttingPlane class

% Add pair
function [ga,gW] = evaluateLossDerivatives(Q,F,J,d,gamma)

% Initialize derivatives
ga = zeros(size(Q.a));
gW = zeros(size(Q.W));

% Evaluate max linear term
[~,active_index] = max([F + J*d; gamma]);

% Set matrix from loss function
matrix = [-J ones(Q.m,1)]*Q.W - eye(Q.m);

% Update derivatives
for i = 1:Q.m
  for j = 1:Q.m
    ga(i)       = ga(i)       + 2*Q.a(i)  *Q.a(j)^2*(matrix(i,j)^2 + matrix(j,i)^2);
    gW(1:Q.n,i) = gW(1:Q.n,i) - 2*Q.a(i)^2*Q.a(j)^2* matrix(j,i)*J(j,:)';
    gW(end,i)   = gW(end,i)   + 2*Q.a(i)^2*Q.a(j)^2* matrix(j,i);
  end
end

% Check activity
if active_index > Q.m
  for i = 1:Q.m
    ga(i)       = ga(i)       - Q.W(:,i)'*Q.W(:,i) - 2*(Q.n + 1 - sum(Q.a)) + Q.W(end,i)*F(i);
    gW(1:Q.n,i) = gW(1:Q.n,i) + 2*(1-Q.a(i))*Q.W(1:Q.n,i);
    gW(end,i)   = gW(end,i)   + Q.a(i)*F(i) + 2*(1-Q.a(i))*Q.W(end,i);
  end
else
  for i = 1:Q.m
    ga(i)       = ga(i)       - Q.W(:,i)'*Q.W(:,i) - 2*(Q.n + 1 - sum(Q.a)) + J(active_index,:)*Q.W(1:Q.n,i)*F(i);
    gW(1:Q.n,i) = gW(1:Q.n,i) + 2*(1-Q.a(i))*Q.W(1:Q.n,i) + J(active_index,:)'*Q.a(i)*F(i);
    gW(end,i)   = gW(end,i)   + 2*(1-Q.a(i))*Q.W(end,i);
  end
end

end