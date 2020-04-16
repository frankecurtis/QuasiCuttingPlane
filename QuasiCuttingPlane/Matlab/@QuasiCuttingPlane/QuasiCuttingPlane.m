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
% Public methods:
%
%   msg = Q.updateWeights(f)
%     Updates weights in subproblem solver using function values in f.
%
%   d = Q.computeStep(f)
%     Returns step based on current weights.
%
%   Q.printData
%     Prints all members of the class.
%
%   Q.setVerbosity(level)
%     Sets verbosity to level, where level must be a nonnegative integer.
%     - verbosity=0 means that nothing is printed.
%     - verbosity=1 means that warnings and short messages are printed.
%     - verbosity=2 means that all data is printed after pair is added.

% QuasiCuttingPlane class
classdef QuasiCuttingPlane < handle
  
  % Properties (private access)
  properties (SetAccess = private, GetAccess = private)
    
    %%%%%%%%%%%
    % Options %
    %%%%%%%%%%%
    verbosity = 1 % verbosity level
                  %   0 = prints nothing
                  %   1 = prints warnings and short messages
                  %   2 = also prints data after pair added

    %%%%%%%%%%%%%%%
    % Size values %
    %%%%%%%%%%%%%%%
    n = -1 % number of variables
    m = -1 % number of terms in max
        
  end
  
  % Methods (private access)
  methods (Access = private)
                
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
    
    % Update weights
    msg = updateWeights(Q,f)
        
    % Compute step
    d = computeStep(Q,f)
    
    % Print data (for debugging)
    printData(Q)
    
    % Sets verbosity
    setVerbosity(Q,value)
    
  end
  
  % Methods (static)
  methods (Static)
    
    % Usage message
    msg = usageMessage
    
  end
  
end