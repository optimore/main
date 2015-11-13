%  function [ status ] = test_maingui()
% TEST_MAINGUI Summary of this function goes here
%   Detailed explanation goes here
clear;
clc;
path1 = 'src/main/guitest/guilauncher';
addpath(path1);
test_launcher;

% *** RESOLVE LATER ***
% rmpath(path1);
% end