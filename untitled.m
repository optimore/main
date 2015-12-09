%% DATA

close all

Xaxis = [0 5 10 15 20 25 30 35 40 45];

Adatat = [
1.9469e+03
1.8024e+03
924.7860
202.6205
35.3662
8.4470
4.4954
3.1889
4.3660
1.6048]';

Adatat = fliplr(Adatat);

Adatai = [
138.3000
99.6000
414.8000
339.8000
172.8000
124.9000
115.5000
114.6000
78.3000
45.3000]';

Adatai = fliplr(Adatai);

Bdatat = [
1.9518e+03
1.9888e+03
795.4580
253.9320
63.0361
12.5723
4.5566
2.3785
4.8358
2.6226]';

Bdatat = fliplr(Bdatat);

Bdatai = [  
139.3000
97.8000
417.7000
396.9000
180.6000
91.1000
104.7000
104
57.9000
73]';

Bdatai = fliplr(Bdatai);


Cdatat = [1.9449e+03
1.8169e+03
593.0030
179.7519
41.8708
7.8139
4.6988
7.8976
1.6663
3.6637]';

Cdatat = fliplr(Cdatat);

Cdatai = [
76.4000
627.1000
362.7000
419.5000
184.7000
148.1000
138.2000
249.5000
72.3000
132.5000]';

Cdatai = fliplr(Cdatai)


Ddatat = [2.1321 2.456 4.0442 4.5021 12.1196 32.2437 50.5501 187.665 436.073 1921.87];

Ddatai = [
421
231.5000
229.5000
134.2000
219.1000
188.3000
105.8000
114.7000
58.8000
55.5000]';

Ddatai = fliplr(Ddatai);


%% PLOTS

close all

%TIME
figure;
plot(Xaxis, Adatat,'-*')

figure;
plot(Xaxis, Bdatat, '-o')

figure;
plot(Xaxis, Cdatat, '-^')

figure;
plot(Xaxis, Ddatat, '-x')


%ITERATION
figure;
plot(Xaxis, Adatai,'-*')

figure;
plot(Xaxis, Bdatai, '-o')

figure;
plot(Xaxis, Cdatai, '-^')

figure;
plot(Xaxis, Ddatai, '-x')
%%
close all

figure;
plot(Xaxis, Adatat, '-b*', Xaxis, Bdatat, '-go', Xaxis, Cdatat, '-cx', Xaxis, Ddatat, '-m^')
legend('A-data', 'B-data', 'C-data', 'D-data')

figure;
plot(Xaxis, Adatai, '-b*', Xaxis, Bdatai, '-go', Xaxis, Cdatai, '-cx', Xaxis, Ddatai, '-m^')
legend('A-data', 'B-data', 'C-data', 'D-data')

