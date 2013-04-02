% Example show how to run k-support norm on the brain data in a
% transductive way using squared loss function
% Author: Matthew Blaschko, Katerina Gkirtzou
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
% along with KsupportNormFMRICode.  If not, see <http://www.gnu.org/licenses/>.


%% Load data and packages
clear all;
% Ksupport norm package
addpath(genpath('.'));


% Create data
% data = a mxn array containing m sampless with n features
% Generate values from a normal distribution with mean 1 and standard
% deviation 2 as positive class
dataPos = 1 + 2.*randn(100,20);
% Generate values from a normal distribution with mean 1 and standard
% deviation 2 as negative class
dataNeg = 10 + 2.*randn(100,20);
data = [dataPos; dataNeg];
% labels = a m vector containing the variable that we want to predict
labels = [ ones(100, 1); ones(100, 1)*-1];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Initialization of variables
% Ksupport norm parameters
lambda = 1
k = 10 % k\in\{1, size(data, 2)\}

% Transductive normalization of data and centering of labels
[data, mu, d] = normalize(data);
[labels, muL] = center(labels);

%% Call ksuppport norm  
disp(['Ksupport norm lambda ', num2str(lambda), ' and k ', num2str(k)]);
% Permute data 
ind = randperm(size(data, 2));
labels = labels(ind);
data = data(ind,:);
% Use 80% for training and the remaining 20% for testing 
threshVal = floor(length(labels)*.8);


% Trainning ksupport norm
[w,cost] = KsparseSquaredLoss(data(1:threshVal, :), labels(1:threshVal), lambda, k);

% Validation
pred = data(threshVal+1:end, :)*w;

acc = sum(sign(pred) == sign(labels(threshVal+1:end)))/length(pred);
disp(['Ksupport norm lambda has accuracy ', num2str(acc)]);

%% end of file




