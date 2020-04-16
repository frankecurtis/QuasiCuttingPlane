function testQCP(n,m,seed)

% Set random seed
rng(seed);

% Generate problem data (minimizer is x=0)
A = randn(m,n);
v = rand(n,1);
A(n+1,:) = -(v'*A(1:n,:))';
b = zeros(m,1);
b(n+2:end) = -rand(m-n-1,1);

% Create quasi-cutting-plane object
Q = QuasiCuttingPlane(n,m);

% Iteration loop
for k = 1:10000
  
  % Generate random point
  x = randn(n,1);
  
  % Evaluate functions
  F = objectives(x,A,b);
  
  % Update weights
  Q.updateWeights(F,A);
  
  % Compute step
  d = Q.computeStep(F);
  
  % Print step
  fprintf('%6d  %+e  %+e  %+e\n',k,norm(x),norm(d),norm(x+d));
  
end

% Print data
Q.printData

end

% Function evaluation
function F = objectives(x,A,b)

F = A*x + b;

end