function [fig1,fig2,figaxes1,figaxes2,figdata] = CreateFigures(data)
% Initialize figures for solution plot

close all;

fig1 = figure('Visible','on','Position',[10,100,1400,1000]);
figaxes1 = axes('Units','pixels', 'Units','normalized','Position',[0.05,0.1,0.9,0.85]);

fig2 = figure('Visible','on','Position',[10,100,1400,1000]);
figaxes2 = axes('Units','pixels', 'Units','normalized','Position',[0.05,0.1,0.9,0.85]);

% Make x-axis length of max end of tasks
figdata.L = 1.1*max(data.tasks(:,3));
% Make y-axis no of timelines
figdata.T = 1.1*max(data.tasks(:,4));

end

