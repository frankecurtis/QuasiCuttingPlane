function testQCP(n,m,seed)

% Set random seed
rng(seed);

% Generate problem data (minimizer is x=0)
[A,b] = generate_data(n,m);

% Create quasi-cutting-plane object
Q = QuasiCuttingPlane(n,m);

% Set points to generate each iteration
p = 10*n;

% Initialize function value matrix
F = zeros(m,p);

% Iteration loop
for k = 1:1000
  
  % Generate function values
  for j = 1:p
  
    % Evaluate functions
    F(:,j) = objectives(randn(n,1),A,b);
    
  end
  
  % Evaluate loss before
  [loss_before,~] = Q.evaluateLoss(F,A);

  % Update weights
  alpha = Q.updateWeights(F,A);
  
  % Evaluate loss after
  [loss_after,~] = Q.evaluateLoss(F,A);

  % Generate random point
  x = randn(n,1);
  
  % Evaluate functions
  f = objectives(x,A,b);
  
  % Compute step
  d = Q.computeStep(f);
  
  % Print step
  fprintf('%6d  %+e  %+e  %+e  %+e  %+e  %+e\n',k,loss_before,loss_after,alpha,norm(x),norm(d),norm(x+d));
  
end

% Print data
Q.printData

end

% Generate problem data
function [A,b] = generate_data(n,m)

A = randn(m,n);
v = rand(n,1);
A(n+1,:) = -(v'*A(1:n,:))';
b = zeros(m,1);
b(n+2:end) = -rand(m-n-1,1);

end

% Function evaluation
function F = objectives(x,A,b)

F = A*x + b;

end