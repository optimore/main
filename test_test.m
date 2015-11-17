x=1:0.1:10;

fig1 = figure;
plot(x,sind(x));

fig2 = figure;
plot(x,cosd(x));

pause(2);

figure(fig1);
plot(x,tand(x));