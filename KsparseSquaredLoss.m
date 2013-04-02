% Squared loss functions for k-support norm
% Author: Matthew Blaschko, Katerina Gkirtzou
% Copyright 2012-2013 Matthew Blaschko, Katerina Gkirtzou
%
% This file is part of the KsupportNormFMRICode package
% 
% KsupportNormFMRICode is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% KsupportNormFMRICode is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with KsupportNormFMRICode.  If not, see
% <http://www.gnu.org/licenses/>.
% These functions are part of the KsupportNormFMRICode package

function [w,costs] = KsparseSquaredLoss(X,Y,lambda,k,w0, ...
                                        iters_acc,eps_acc);
% first 3 arguments are required!
    if(nargin<7)
        eps_acc = 1e-4;
    end

    if(nargin<6)
        iters_acc = 2000;
    end
    
    if(nargin<5)
        w0 = zeros(size(X,2),1);
    end
    
    if(nargin<4)
        k = min(size(X,2),1500);
    end
           
    if(size(X,1)>size(X,2)) % lipschitz constant for gradient of squared loss
        L = 2*eigs(X'*X,1);
    else
        L = 2*eigs(X*X',1);
    end
    [w,costs] = overlap_nest(@(w)(squaredLoss(w,X,Y)),...
                             @(w)(gradSquaredLoss(w,X,Y)), lambda, ...
                             L, w0, k, iters_acc,eps_acc);
end

function l = squaredLoss(w,X,Y)
    Xw = X*w;
    l = Xw'*Xw - 2*Xw'*Y + Y'*Y;
end

function g = gradSquaredLoss(w,X,Y)
    g = 2*X'*(X*w) - 2*X'*Y;
end

%% end of file

