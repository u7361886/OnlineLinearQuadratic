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
    elseif(nargin == 6)
        name1 = string(name1) + "Preview" + string(previewHorizon) + "Time" + string(T) + "Monte" + string(numMonte);
        time1 = floor(T/2);
        time2 = previewHorizon+1;
        window1 = 1;
        window2 = floor(previewHorizon/2);
    end
    xfontsize = 25;
    yfontsize = 25;
    ylabelFontSize = 24;
    size1 = 1050;
    size2 = 850;
%     size1 = 1450;
%     size2 = 950;

    figure
    imagesc(previewHorizon:T,0:previewHorizon-1,(regAvg(:,previewHorizon:T)))
    colorbar
    set(gca, 'XTickLabel', get(gca, 'XTick'), 'YTickLabel', get(gca, 'YTick'), 'FontName', 'Arial', 'FontSize', ylabelFontSize);
    set(gcf,'Position',[100,100,size1,size2])
    curtick = get(gca, 'xTick');
    xticks(unique(round(curtick)));
    xlabel('Time Horizon','FontSize',xfontsize)
    ylabel('Regret','FontSize',yfontsize)
    exportgraphics(gcf,".\plots\" + name1 + "Window" + string(window1) + "ColorMap" + ".pdf",'ContentType','vector','Resolution',600)
    
%     size1 = 1550;
%     size2 = 1050;
    figure
    plot(max(d,previewHorizon):T,regAvg(window1,max(d,previewHorizon):T), 'LineWidth',4)
    set(gca, 'XTickLabel', get(gca, 'XTick'), 'YTickLabel', get(gca, 'YTick'), 'FontName', 'Arial', 'FontSize', ylabelFontSize);
    set(gcf,'Position',[100,100,size1,size2])
%     curtick = get(gca, 'xTick');
%     xticks(unique(round(curtick)));
    xlabel('Time Horizon','FontSize',xfontsize)
    ylabel('Regret','FontSize',yfontsize)
    xlim([previewHorizon T])
    exportgraphics(gcf,".\plots\" + name1 + "Window" + string(window1) + ".pdf",'ContentType','vector','Resolution',600)
    
    figure
    plot(max(d,previewHorizon):T,regAvg(window2,max(d,previewHorizon):T), 'LineWidth',4)
    set(gca, 'XTickLabel', get(gca, 'XTick'), 'YTickLabel', get(gca, 'YTick'), 'FontName', 'Arial', 'FontSize', ylabelFontSize);
    set(gcf,'Position',[100,100,size1,size2])
    xlabel('Time Horizon','FontSize',xfontsize)
    ylabel('Regret','FontSize',yfontsize)
    exportgraphics(gcf,".\plots\" + name1 + "Window" + string(window2) + ".pdf",'ContentType','vector')
    
    figure
    plot(0:1:previewHorizon-1,log(abs(regAvg(:,time1))), 'LineWidth',4)
    curtick = get(gca, 'xTick');
    xticks(unique(round(curtick)));
    set(gca, 'XTickLabel', get(gca, 'XTick'), 'YTickLabel', get(gca, 'YTick'), 'FontName', 'Arial', 'FontSize', ylabelFontSize);
    set(gcf,'Position',[100,100,size1,size2])
    xlabel('Preview Window','FontSize',xfontsize)
    ylabel('log|Regret|','FontSize',yfontsize)
    exportgraphics(gcf,".\plots\" + name1 + "Time" + string(time1) + ".pdf",'ContentType','vector')
    
    figure
    plot(0:previewHorizon-1,log(abs((regAvg(:,time2)))), 'LineWidth',4)
    curtick = get(gca, 'xTick');
    xticks(unique(round(curtick)));
    set(gca, 'XTickLabel', get(gca, 'XTick'), 'YTickLabel', get(gca, 'YTick'), 'FontName', 'Arial', 'FontSize', ylabelFontSize);
    set(gcf,'Position',[100,100,size1,size2])
    xlabel('Preview Window','FontSize',xfontsize)
    ylabel('log|Regret|','FontSize',yfontsize)
    exportgraphics(gcf,".\plots\" + name1 + "Time" + string(time2) + ".pdf",'ContentType','vector')
end