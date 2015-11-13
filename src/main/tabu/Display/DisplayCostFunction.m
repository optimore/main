function [] = DisplayCostFunction(cost,fig,figdata)
%DISPLAYCOSTFUNTION plots cost function value against iteration

try
    % Set current plot
    h1 = subplot(fig);
    
    % Visualize costs:
    cla reset
    
    %axis([-0.1*L,1.1*L,0,T+1])
    set(gca,'FontSize',10);
    
    title(sprintf('Current cost: %s\nIteration: %s\nActivePhase: %s\n', num2str(sum(cost(end,:)),'%10.5e'), num2str(figdata.iteration),  figdata.phase));
    xlabel('Number of iterations');
    ylabel('CostFunction value (LOG)');
   
    hold(fig, 'on')
    %plot(log(cost));
    %h=area(log(cost+1));
    h=plot(log(cost+1)); %,'LineStyle',':');
    legend(h,'Total','Depen', 'Overlap','Bounds', ...
        'Location','West'); %,'Orientation','horizontal');
    hold(fig,'off')
    
catch err
    rethrow(err)
    fprintf(obj.Logfile, getReport(err,'extended'));
end

end

