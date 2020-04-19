% Copyright (C) 2020 Frank E. Curtis
%
% All Rights Reserved.
%
% Authors: Frank E. Curtis
%
% QuasiCuttingPlane class definition
%
% Constructors:
%
%   Q = QuasiCuttingPlane(n,m)
%       where n is the number of variables, and
%             m is the number of terms in max
%
% Private methods:
%
%   [d,gamma] = Q.feedForward(F)
%     Feeds forward to produce output corresponding to input F.
%    
%   a = Q.setActivityIndicators(F)
%     Set activity indicators
%
%   alpha = Q.runLineSearch(F,J,gW)
%     Runs line search.
%
% Public methods:
%
%   Q.checkDerivatives(F,J)
%     Checks derivatives with respect to weights.
%
%   d = Q.computeStep(F)
%     Returns step based on current weights.
%
%   [loss,active_index] = Q.evaluateLoss(F,J)
%     Evaluates loss.
%    
%   gW = Q.evaluateLossDerivatives(F,J)
%     Evaluates loss derivatives.
%    
%   Q.printData
%     Prints all members of the class.
%
%   Q.setVerbosity(level)
%     Sets verbosity to level, where level must be a nonnegative integer.
%     - verbosity=0 means that nothing is printed.
%     - verbosity=1 means that warnings and short messages are printed.
%     - verbosity=2 means that all data is printed after pair is added.
%
%   alpha = Q.updateWeights(F,J)
%     Updates weights in subproblem solver using function values in F.
%
%   W = Q.weights
%     Returns weights.
%
% Static methods:
%
%   Q.usageMessage
%     Returns usage message for user.

% QuasiCuttingPlane class
classdef QuasiCuttingPlane < handle
  
  % Properties (private access)
  properties (SetAccess = private, GetAccess = private)
    
    %%%%%%%%%%%
    % Options %
    %%%%%%%%%%%
    verbosity = 0 % verbosity level
                  %   0 = prints nothing
                  %   1 = prints warnings and short messages
                  %   2 = also prints data after pair added

    %%%%%%%%%%%%%%%
    % Size values %
    %%%%%%%%%%%%%%%
    n = -1 % number of variables
    m = -1 % number of terms in max
    
    %%%%%%%%%%%%%%%%%
    % Weight values %
    %%%%%%%%%%%%%%%%%
    W % weights for inverse
        
  end
  
  % Methods (private access)
  methods (Access = private)

    % Feed forward to compute output
    [d,gamma] = feedForward(Q,F)
    
    % Set activity indicators
    a = setActivityIndicators(Q,F);
    
    % Run line search
    alpha = runLineSearch(Q,F,J,gW)
  
  end
  
  % Methods (public access)
  methods (Access = public)
    
    % Constructor
    function Q = QuasiCuttingPlane(varargin)
      
      % Check inputs
      if nargin == 2
        constructor(Q,varargin{1},varargin{2});
      else
        msg = 'QuasiCuttingPlane: Incorrect number of inputs';
        msg = [msg newline Q.usageMessage];
        error(msg);
      end
      
    end
    
    % Check derivatives
    checkDerivatives(Q,F,J)
    
    % Compute step
    d = computeStep(Q,F)
    
    % Evaluate loss
    [loss,active_index] = evaluateLoss(Q,F,J)
    
    % Evaluate loss derivatives
    gW = evaluateLossDerivatives(Q,F,J)
    
    % Print data (for debugging)
    printData(Q)
    
    % Sets verbosity
    setVerbosity(Q,value)
    
    % Update weights
    alpha = updateWeights(Q,F,J)
    
    % Get weights, activities
    function W = weights(Q)
      W = Q.W;
    end

  end
  
  % Methods (static)
  methods (Static)
    
    % Usage message
    msg = usageMessage
    
  end
  
end