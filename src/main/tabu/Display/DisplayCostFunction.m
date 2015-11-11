function [] = DisplayCostFunction(cost,fig,figdata)
%DISPLAYCOSTFUNTION plots cost function value against iteration

try
    % Set current plot
    h1 = subplot(fig);
    
    % Visualize costs:
    cla reset
    
    %axis([-0.1*L,1.1*L,0,T+1])
    set(gca,'FontSize',10);
    
    title(sprintf('Current cost: %s\nIteration: %s\nActivePhase: %s\n', num2str(cost(end)), num2str(figdata.iteration),  num2str(figdata.phase)));
    xlabel('Number of iterations');
    ylabel('CostFunction value (LOG)');
    
    hold(fig, 'on')
    plot(log(cost));
    hold(fig,'off')
    
catch err
    rethrow(err)
    fprintf(obj.Logfile, getReport(err,'extended'));
end

end

