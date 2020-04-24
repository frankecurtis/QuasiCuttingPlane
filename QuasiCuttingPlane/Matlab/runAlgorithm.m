function [f,k] = runAlgorithm(n,m,seed,K,try_qcp,factor)

% Set random seed
rng(seed);

% Generate problem data (minimizer is x=0)
[A,b] = generate_data(n,m);

% Create quasi-cutting-plane object
Q = QuasiCuttingPlane(n,m);

% Initialize point
x = 10*randn(n,1);

% Initialize inverse Hessian approximation
W = eye(n);

% Initialize output
f = zeros(K,1);

% Initialize best function value
f_best = inf;

% Initialize active set estimate
a_avg = zeros(m,1);
a     = [];

% Iteration loop
for k = 1:K
  
  % Print header
  if mod(k,20) == 0
    fprintf('%6s %11s %11s %11s %11s %11s %11s %11s %11s %11s %11s %11s %11s %11s %11s\n',...
            'Iter.','f(x)','||x||',...
            'Stepsize','Loss Bef.','Loss Aft.','||g|| Bef.','||g|| Aft.',...
            '||x_reg||','f_reg','alpha_reg','||x_qcp||','f_qcp','gamma_qcp','alpha_qcp');
  end
  
  % Evaluate functions
  F = objectives(x,A,b);
  
  % Store function value
  f(k) = max(F);
    
  % Print iterate information
  fprintf('%6d %+.4e %+.4e',k,f(k),norm(x));
    
  % Check for termination
  if norm(x,inf) <= 1e-8
    fprintf('\n');
    break;
  end
  
  % Quasi-cutting plane stuff
  if try_qcp && k >= factor*K
    
    % Set activity estimate
    if f(k) < f_best
      a_tem = (F >= max(F)-1e-00);
      a_avg = 0.1*a_avg + 0.9*a_tem;%(a_avg*k + a_tem)/(k+1);
      [~,a] = sort(a_avg,'descend');
      for i = length(a):-1:1
        if a_avg(a(i)) <= 0
          a(i) = [];
        end
      end
    end
    
    % Evaluate loss before
    loss_before = Q.evaluateLoss(F,A,a);
    
    % Evaluate loss derivatives before
    gW_before = Q.evaluateLossDerivatives(F,A,a);
    
    % Check derivatives
    %   fprintf('\n');
    %   Q.checkDerivatives(F,A,a);
    %   pause
    
    % Update weights
    alpha = Q.updateWeights(F,A,a);
    
    % Evaluate loss after
    loss_after = Q.evaluateLoss(F,A,a);
    
    % Evaluate loss derivatives after
    gW_after = Q.evaluateLossDerivatives(F,A,a);
    
    % Print weight update information
    fprintf(' %+.4e %+.4e %+.4e %+.4e %+.4e',alpha,loss_before,loss_after,norm(gW_before,'fro'),norm(gW_after,'fro'));
    
  else
    
    % Print weight update information
    fprintf(' %+.4e %+.4e %+.4e %+.4e %+.4e',0,0,0,0,0);
    
  end

  % Compute trial regular step values
  d_reg = -W*subgradient(x,A,b);
  [x_reg,a_reg] = lineSearch(x,d_reg,A,b);
  f_reg = max(objectives(x_reg,A,b));
  
  % Compute trial quasi-cutting-plane step values
  if try_qcp && k >= factor*K
    [d_qcp,g_qcp] = Q.computeStep(F,a);
    [x_qcp,a_qcp] = lineSearch(x,d_qcp,A,b);
    f_qcp = max(objectives(x_qcp,A,b));
  else
    g_qcp = 0; x_qcp = 0; a_qcp = 0; f_qcp = 0;
  end
  
  % Store values for inverse Hessian approximation update
  x_old = x;
  [~,ind] = max(objectives(x,A,b));
  g_old = A(ind,:)';

  % Try QCP?
  x_ind = 'reg';
  if try_qcp && ~isnan(f_qcp) && ~isinf(f_qcp) && sum(isnan(x_qcp)) == 0 && sum(isinf(x_qcp)) == 0 && k >= factor*K && f_qcp < f_reg
    x = x_qcp; x_ind = 'qcp';
  else
    x = x_reg;
  end
    
  % Do inverse Hessian approximation update
  [~,ind] = max(objectives(x,A,b));
  g = A(ind,:)';
  s = x - x_old;
  y = g - g_old;
  if norm(s) > 0 && norm(y) > 0
    W = (eye(n) - (y*s')/(s'*y))'*W*(eye(n) - (y*s')/(s'*y)) + (s*s')/(s'*y);
  end
  
  % Print step
  fprintf(' %+.4e %+.4e %+.4e %+.4e %+.4e %+.4e %+.4e %3s %3d\n',norm(x_reg),f_reg,a_reg,norm(x_qcp),f_qcp,g_qcp,a_qcp,x_ind,sum(a <= n+1));
    
end

end

% Generate problem data
function [A,b] = generate_data(n,m)

A = randn(m,n);
A = normr(A);
v = rand(n,1);
A(n+1,:) = -(v'*A(1:n,:))';
b = zeros(m,1);
b(n+2:end) = -0.5-rand(m-n-1,1);

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

% Line search
function [x_new,a] = lineSearch(x,d,A,b)

a    = 1;
a_lo = 0;
a_hi = 100;
[f,ind] = max(objectives(x,A,b));
g = A(ind,:)';
dd = g'*d;

while 1
  
  x_new = x + a*d;
  
  if a_hi - a_lo <= 1e-10
    break;
  end
  
  [f_new,ind_new] = max(objectives(x_new,A,b));
  g_new = A(ind_new,:)';
  
  if f_new <= f + 1e-10*a*dd
    if d'*g_new >= 5e-1*dd
      break;
    else
      a_lo = a;
    end
  else
    a_hi = a;
  end
  
  a = 0.5*(a_lo+a_hi);
  
end

end