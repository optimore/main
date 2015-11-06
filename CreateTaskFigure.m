function [figaxes,figdata] = CreateTaskFigure(data)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

close all;
fig = figure('Visible','on','Position',[10,100,1400,1000]);
end_t = data.tasks(:,2) + data.tasks(:,5);
% Make x-axis length of max placement of task *IMPROVE: use parameter from
% data creation*
figdata.L = 1.1*max(end_t);
% Make y-axis no of timelines
figdata.T = 1.1*max(data.tasks(:,4));
figaxes = axes('Units','pixels', 'Units','normalized','Position',[0.05,0.1,0.9,0.85]);
set(0, 'currentfigure', fig);
set(fig, 'currentaxes', figaxes);


end

