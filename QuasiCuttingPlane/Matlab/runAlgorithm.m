function [f,k] = runAlgorithm(n,m,seed,K,try_qcp)

% Set random seed
rng(seed);

% Generate problem data (minimizer is x=0)
[A,b] = generate_data(n,m);

% Create quasi-cutting-plane object
Q = QuasiCuttingPlane(n,m);

% Initialize point
x = 10*randn(n,1);

% Initialize output
f = zeros(K,1);

% Iteration loop
for k = 1:K
  
  % Print header
  if mod(k,20) == 0
    fprintf('%6s  %13s  %13s  %13s  %13s  %13s  %13s  %13s  %13s  %13s  %13s  %13s\n',...
            'Iter.','||x||','f(x)',...
            'Stepsize','Loss Before','Loss After','||g|| Before','||g|| After',...
            '||x_sub||','f(x_sub)','||x_qcp||','f(x_qcp)');
  end
  
  % Evaluate functions
  F = objectives(x,A,b);
  
  % Store function value
  f(k) = max(F);
  
  % Print iterate information
  fprintf('%6d  %+e  %+e',k,norm(x),f(k));
  
  % Check for termination
  if norm(x,inf) <= 1e-5
    fprintf('\n');
    break;
  end
  
  % Evaluate loss before
  [loss_before,~] = Q.evaluateLoss(F,A);
  
  % Evaluate loss derivatives before
  gW_before = Q.evaluateLossDerivatives(F,A);
  
  % Check derivatives
  %Q.checkDerivatives(F,A);

  % Update weights
  alpha = Q.updateWeights(F,A);
  
  % Evaluate loss after
  [loss_after,~] = Q.evaluateLoss(F,A);

  % Evaluate loss derivatives after
  gW_after = Q.evaluateLossDerivatives(F,A);
  
  % Print weight update information
  fprintf('  %+e  %+e  %+e  %+e  %+e',alpha,loss_before,loss_after,norm(gW_before,'fro'),norm(gW_after,'fro'));

  % Compute trial subgradient step values
  d_sub = -(1/k)*subgradient(x,A,b);
  x_sub = x + d_sub;
  f_sub = max(objectives(x_sub,A,b));
  
  % Compute trial quasi-cutting-plane step values
  d_qcp = Q.computeStep(F);
  x_qcp = x + d_qcp;
  f_qcp = max(objectives(x_qcp,A,b));
  
  % Try QCP?
  if try_qcp && f_qcp < f_sub
    x = x_qcp;
  else
    x = x_sub;
  end
  
  % Print step
  fprintf('  %+e  %+e  %+e  %+e\n',norm(x_sub),f_sub,norm(x_qcp),f_qcp);
    
end

% Print data
Q.printData;

end

% Generate problem data
function [A,b] = generate_data(n,m)

A = randn(m,n);
A = normr(A);
v = rand(n,1);
A(n+1,:) = -(v'*A(1:n,:))';
b = zeros(m,1);
b(n+2:end) = -rand(m-n-1,1);

end

% Function evaluation
function F = objectives(x,A,b)

F = A*x + b;

end

% Subgradient evaluation
function g = subgradient(x,A,b)

[~,i] = max(A*x + b);
g = A(i,:)';

end