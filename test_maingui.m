% function [ status ] = test_maingui()
% TEST_MAINGUI Summary of this function goes here
%   Detailed explanation goes here

%status = 1;
% modelParameters = struct( ...
%     'tabu', struct('active',0,'initial',1,'phases',[1]), ...
%     'LNS' , struct('active',0,'initial',1,'phases',[1]), ...
%     'ampl', struct('active',0,'initial',1,'phases',[1]));

path1 = 'src/main/guitest/guilauncher';
addpath(path1);
%model_fixtures
test_launcher;

% *** RESOLVE LATER ***
% rmpath(path1);

% end