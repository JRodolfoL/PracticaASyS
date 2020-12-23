%% Ejercicio 3
%
% Realice la simuación de la convolución de las señales (c) con (d) del problema 3.1.1
%%
C=[0 -9 -6 -3 0 3 6 9 0 0 0];
n=-4:6;
stem(n,C)
axis([-4 4 -10 10])
gca.XAxisLocation = 'origin';
gca.YAxisLocation = 'origin';
gca.Box = 'off';
title('Grafica C')
xlabel('n')
ylabel('x[n]')
%%
D=[0 0 4 2 0 2 4 0 0 0 0 ];
stem(n,D)
axis([-4 4 -2 5])
gca = gca;
gca.XAxisLocation = 'origin';
gca.YAxisLocation = 'origin';
gca.Box = 'off';
title('Grafica D')
xlabel('n')
ylabel('x[n]')
%%
% Mandamos a llamar la función
%
convdisc([n;C],[n;D])
%%