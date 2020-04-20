% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis
%
% Method definition for QuasiCuttingPlane class

% Add pair
function checkDerivatives(Q,F,J,a)

% Evaluate derivatives
gW = Q.evaluateLossDerivatives(F,J,a);

% Set displacement
h = 1e-4;

% Loop over inverse weights
for i = 1:size(Q.W,1)
  for j = 1:length(a)
    
    % Store current inverse weight
    Wij = Q.W(i,a(j));
    
    % Set forward step
    Q.W(i,a(j)) = Wij + h;
    
    % Evaluate forward loss
    loss_forward = Q.evaluateLoss(F,J,a);
    
    % Set backward step
    Q.W(i,a(j)) = Wij - h;
    
    % Evaluate backward loss
    loss_backward = Q.evaluateLoss(F,J,a);
    
    % Print information
    fprintf('Inverse weight : %+.2e %+.2e %+.2e\n',...
      gW(i,a(j)),...
      (loss_forward-loss_backward)/(2*h),...
      abs(gW(i,a(j)) - (loss_forward-loss_backward)/(2*h)));
    
    % Reset weight
    Q.W(i,a(j)) = Wij;
    
  end
end

end