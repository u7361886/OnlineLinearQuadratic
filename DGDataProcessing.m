function DGDataProcessing(regAvg, T, previewHorizon, numMonte, d, name1, time1, time2, window1, window2)
    
%     regAvg = input.regAvgMeFix;
%     T = input.T;
%     previewHorizon = input.previewHorizon;

    if(nargin == 4)
        d = 1;
        time1 = floor(T/2);
        time2 = previewHorizon+1;
        window1 = 1;
        window2 = floor(previewHorizon/2);
        name1 = string(inputname(1)) + 'Preview' + string(previewHorizon) + 'Time' + string(T) + 'Monte' + string(numMonte);
    elseif (nargin == 5)
        name1 = string(inputname(1)) + 'Preview' + string(previewHorizon) + 'Time' + string(T) + 'Monte' + string(numMonte);
        time1 = floor(T/2);
        time2 = previewHorizon+1;
        window1 = 1;
        window2 = floor(previewHorizon/2);
    end

    figure
    imagesc(previewHorizon:T,0:previewHorizon-1,(regAvg(:,previewHorizon:T)))
    colorbar
    set(gca, 'XTickLabel', get(gca, 'XTick'), 'YTickLabel', get(gca, 'YTick'), 'FontName', 'Arial', 'FontSize', 16);
    set(gcf,'Position',[100,100,950,800])
    xlabel('Time Horizon','FontSize',18)
    ylabel('Regret','FontSize',18)
    exportgraphics(gcf,'.\plots\' + name1 + 'Window' + string(window1) + 'ColorMap' + '.pdf','ContentType','vector','Resolution',600)
    figure
    plot(max(d,previewHorizon):T,regAvg(window1,max(d,previewHorizon):T), 'LineWidth',4)
    set(gca, 'XTickLabel', get(gca, 'XTick'), 'YTickLabel', get(gca, 'YTick'), 'FontName', 'Arial', 'FontSize', 16);
    set(gcf,'Position',[100,100,950,800])
    xlabel('Time Horizon','FontSize',18)
    ylabel('Regret','FontSize',18)
    exportgraphics(gcf,'.\plots\' + name1 + 'Window' + string(window1) + '.pdf','ContentType','vector','Resolution',600)
    
    figure
    plot(max(d,previewHorizon):T,regAvg(window2,max(d,previewHorizon):T), 'LineWidth',4)
    set(gca, 'XTickLabel', get(gca, 'XTick'), 'YTickLabel', get(gca, 'YTick'), 'FontName', 'Arial', 'FontSize', 16);
    set(gcf,'Position',[100,100,950,800])
    xlabel('Time Horizon','FontSize',18)
    ylabel('Regret','FontSize',18)
    exportgraphics(gcf,'.\plots\' + name1 + 'Window' + string(window2) + '.pdf','ContentType','vector')
    
    figure
    plot(0:1:previewHorizon-1,log(abs(regAvg(:,time1))), 'LineWidth',4)
    set(gca, 'XTickLabel', get(gca, 'XTick'), 'YTickLabel', get(gca, 'YTick'), 'FontName', 'Arial', 'FontSize', 16);
    set(gcf,'Position',[100,100,950,800])
    xlabel('Preview Window','FontSize',18)
    ylabel('log|Regret|','FontSize',18)
    exportgraphics(gcf,'.\plots\' + name1 + 'Time' + string(time1) + '.pdf','ContentType','vector')
    
    figure
    plot(0:previewHorizon-1,log(abs((regAvg(:,time2)))), 'LineWidth',4)
    set(gca, 'XTickLabel', get(gca, 'XTick'), 'YTickLabel', get(gca, 'YTick'), 'FontName', 'Arial', 'FontSize', 16);
    set(gcf,'Position',[100,100,950,800])
    xlabel('Preview Window','FontSize',18)
    ylabel('log|Regret|','FontSize',18)
    exportgraphics(gcf,'.\plots\' + name1 + 'Time' + string(time2) + '.pdf','ContentType','vector')
end