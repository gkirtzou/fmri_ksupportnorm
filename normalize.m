% Author: Katerina Gkirtzou
% Copyright 2012-2013 Katerina Gkirtzou
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

function [data mu d] = normalize(data)
% Normalize the columns of a data matrix to unit euclidean length.
% Input : 
%   data - an MxN array with the data to be normalized per columns
% Output : 
%   data - an MxN array with the data columns normalized.
%   mu - a M vector with the mean values for each column. 
%   d - a M vector with the euclidean lengths of each column. 

    [data mu] = center(data);
    d = sqrt(sum(data.^2));
    d(d == 0) = 1;
    data = data./(ones(size(data, 1) ,1)*d);
end

%% end of file
