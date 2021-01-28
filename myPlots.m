function [] =  myPlots(y,yhat,model,R2,adjR2)
%scatter plot
figure;
scatter(y,yhat);
xlabel('Y actual')
ylabel('Y predicted')
title(model + " regression scatter plot");

% diagnostic plot of standardised error
rmse = sqrt(mean((y - yhat).^2));
e_standard = (y - yhat)/rmse;
figure;
scatter(y,e_standard);
hold on;
plot(xlim,[2 2]);
hold on;
plot(xlim,[0 0]);
hold on;
plot(xlim,[-2 -2]);
xlabel('Y actual')
ylabel('standardised error')
title(model + " regression diagnostic plot");
annotation('textbox', [0.15, 0.8, 0.1, 0.1], 'String', "R2 = " + R2)
annotation('textbox', [0.15, 0.7, 0.1, 0.1], 'String', "adjR2 = " + adjR2)
hold off