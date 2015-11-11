function [] = DisplayCostFunction(cost,fig,figdata)
%DISPLAYCOSTFUNTION plots cost function value against iteration


% Set current plot
subplot(fig);

% Y-axis
%no_of_iterations = length(cost);
%T = cost(no_of_iterations - round(no_of_iterations/5));

% X-axis
%L = length(cost) - length(cost)/5;

% Visualize costs:
cla reset

%axis([-0.1*L,1.1*L,0,T+1])
set(gca,'FontSize',10);

currentcost_s = '';
currentcost_s = strcat('Current cost:',num2str(cost(end)));
title(currentcost_s);
xlabel('Number of iterations');
ylabel('CostFunction value');

hold(fig, 'on')
plot(cost);
hold(fig,'off')

end

