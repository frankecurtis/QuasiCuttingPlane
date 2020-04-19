% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis
%
% Method definition for QuasiCuttingPlane class

% Add pair
function checkDerivatives(Q,F,J)

% Evaluate derivatives
gW = Q.evaluateLossDerivatives(F,J);

% Set displacement
h = 1e-4;

% Loop over inverse weights
for i = 1:size(Q.W,1)
  for j = 1:size(Q.W,2)
    
    % Store current inverse weight
    Wij = Q.W(i,j);
    
    % Set forward step
    Q.W(i,j) = Wij + h;
    
    % Evaluate forward loss
    [loss_forward,active_index_forward] = Q.evaluateLoss(F,J);
    
    % Set backward step
    Q.W(i,j) = Wij - h;
    
    % Evaluate backward loss
    [loss_backward,active_index_backward] = Q.evaluateLoss(F,J);
    
    % Print information
    fprintf('Inverse weight : %6d %6d %+.2e %+.2e %+.2e\n',...
      active_index_forward,...
      active_index_backward,...
      gW(i,j),...
      (loss_forward-loss_backward)/(2*h),...
      abs(gW(i,j) - (loss_forward-loss_backward)/(2*h)));
    
    % Reset weight
    Q.W(i,j) = Wij;
    
  end
end

end