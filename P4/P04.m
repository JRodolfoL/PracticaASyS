%% Práctica 4: Convolución y correlación de señales.
%
% *Integrantes:*
%
% * Arellano Paz Angel Ulises
% * Cardoso Arias Javier
% * Gachuz Hernández Karla Denisse
% * García Arteaga Alejandro
% * López Galván José Rodolfo
%
%% Objetivos
% * Conocer métodos básicos de integración numérica.
% * Manipulación de instrucciones en MATLAB.
% * Simular convoluciones y correlaciones de señales continuas.
% * Simular convoluciones y correlaciones de señales discretas.

%% introducción
% 
% _Metodos Numericos.
%
%  Numericamnete conocemos la integral como el area encerrada entres dos 
%  rectas o curvas.
%  Una de esas curvas sera nuestra funcion (normalmente definida como
%  f(x)), con esto en mente tenemos que saber que habra funciones que
%  estaran definidas de una forma compleja (extraña), de tal manera que no
%  seran integrables.
%  Esto ultimo refiere a que la antiderivda seria
%  extremadamente dificil de encontrar, o en su defecto, imposibles.
%
%  Asi como habra funciones en las cuales la integral no exista, por lo que
%  habra que saber exactamente que me interesa resolver del problema.
% 
% 
% En los siguientes casos nos interesara encontrar el area debajo de la
% curva en una area *delimitida* de la funcion.
%  
%  Ejemplo:
%  
%% 
% Sea:
%
% $$f(x)= e^{- x^2}$$
%  
%  Deduciriamos que
% 
% $$\int_{-1}^1 f(x) dx = \int_{-1}^1 e^{- x^2} dx = F(1)-F(-1)$$
%
%
% no?
% 
% Pues al intentar realizarla
%%
syms x
simplify(int(exp(-x^2),x,-1,1))

%%
%  Nos muestra un erf(1) lo cual es:
% 
%  Función ERF Error.
%
%    Y = ERF (X) es la función de error para cada elemento de X. X debe ser
%    real. La función de error se define como:
%  
%   erf(x) = 2/sqrt(pi) * integral from 0 to x of exp(-t^2) dt.
%  Y asi deducimos que a pesar de que la funcion sea continua, no hay una
%  antiderivada para este caso,
%  
%  Pero aplicando lo mismo que vimos en al incicio, graficamos la funcion
%  remarcando lo puntos que nos interesan 
%%

x1=-3:0.001:3;
plot(x1,exp(-x1.^2))
hold on;
x=-1:0.001:1;
fill(x,exp(-x.^2),'red');
rectangle('Position',[-1 0 2 0.367879],'FaceColor','red',"EdgeColor",'none');
hold off;

%%
%  En donde resaltando la parte que nos interesa y coparandola con un
%  poligono conocido, en este caso un rectandulo, tenemos.
%
%%

x=-1:0.001:1;
x1=-100:0.01:100;
g=@(x) 1.0.*(x>=-1 & x<=1);
h=@(x) 0.367879.*(x>=-1 & x<=1);
rectangle('Position',[-1 0 2 1],'EdgeColor','r');
hold on;
fill(x,exp(-x.^2),'k');
rectangle('Position',[-1 0 2 0.367879],'FaceColor','k');
axis([-2 2 -0.1 1.5]);
hold off;
grid on;


%%
%  Que viéndolo a 'ojo' podriamos decir que las partes rellenas de negro
%  darian un area cercana a 1.5 pero necesitamos un resultado mas cercano
%  por lo que a continuacion mostraremos algunos metods numericos de
%  integracion
%
%  Empezando con las formulas de Newton-Cotes las cuales para su solucion
%  utilizan los polinomios de interpolacioon de Lagrenge.
% 
% $$\int_{a}^b f(x) dx$$
% 
%  Donde reescribimos a f(x) como
% 
% $$f(x)=P(x) + \frac{f^{n+1} (\varepsilon(x))}{(n+1)!}(x-x_{0})(x-x_{1})...(x-x_{n})$$
% 
% Con 
% 
% $$x \epsilon [a,b]$$   y   $$x_{n} \epsilon [a,b]$$
% 
%  Y asi la formula cerrada de (n+1)puntos de Newton-Cotes tendra
% 
% * $$x_{0} = a$$   
% 
% * $$h = \frac{b-a}{n} $$
%
% * $$x_{n} = b$$   
% 
% * $$x_{i} =x_{0} + ih $$
% 
% $$i=0,1,2,...n $$
% 
%
% Asi las formulas son;
%
% 
% # formula del trapecio (n=1)
%
% $$\int_{x_{0}}^{x_{1}} f(x) dx =\frac{h}{2} [f(x_{0})+f(x_{1})] - \frac{h^3}{12} f'' (\varepsilon) $$
% 
% $$x_{0}<\varepsilon<x_{1}$$
% 
% Aplicandola a nuestro caso particular
%
% $$\int_{-1}^{1} e^{- x^2} dx =\frac{2}{2} [e^{-1} + e^{-1}] - \frac{8}{12} [-2 e^{- \varepsilon^2} (1 - 2 \varepsilon^2 )] $$
%
% $$0.7357 +\frac{4}{3} \varepsilon^2  (1 - 2 \varepsilon^2 ) $$
% 
% $$-1<\varepsilon<1$$
%
% 
% #2 Regla de Simpson (n=2)
% 
% $$\int_{x_{0}}^{x_{2}} f(x) dx =\frac{h}{3} [f(x_{0}) + 4 f(x_{1} + f(x_{2})] - \frac{h^5}{90} f^4 (\varepsilon) $$
% 
% $$x_{0}<\varepsilon<x_{2}$$
%
% Aplicándola a nuestro caso particular
% 
% $$\int_{-1}^{1} e^{- x^2} dx =\frac{1}{3} [e^{-1} + 4 e^{0} + e^{-1}] - \frac{1}{90} [-4 e^{- \varepsilon^2} (-4 \varepsilon^4 + 12 \varepsilon^2 -3 )] $$
%
% $$1.5785 +\frac{2}{45} e^{- \varepsilon^2} (-4 \varepsilon^4 + 12 \varepsilon^2 -3 )] $$
% 
% $$-1<\varepsilon<1$$
%
% 
% #3 Regla de Simpson (n=2)
% 
% $$\int_{x_{0}}^{x_{3}} f(x) dx =\frac{3}{8} h[f(x_{0}) + 3 f(x_{1} + 3 f(x_{2} + f(x_{3})] - \frac{3 h^5}{80} f^4 (\varepsilon) $$
% 
% $$x_{0}<\varepsilon<x_{3}$$
%
% Aplicandola a nuestro caso particular
% 
% $$\int_{-1}^{1} e^{- x^2} dx =\frac{3}{8} \frac{2}{3} [e^{-1} + 3 e^{- \frac{1}{4}} + 3 e^{- \frac{1}{4}} + e^{-1}] + \frac{3}{80} (\frac{2}{3})^5 [-4 e^{- \varepsilon^2} (-4 \varepsilon^4 + 12 \varepsilon^2 -3 )] $$
%
% $$1.5261 +\frac{8}{405} e^{- \varepsilon^2} (-4 \varepsilon^4 + 12 \varepsilon^2 -3 )] $$
% 
% $$-1<\varepsilon<1$$
% 
%
% 
% Continuamos ahora con las formulas de Newton-Cotes compuestas tenemos:
%
%
% 
% * La regla compuesta del trapecio
% 
% 
% $$\int_{a}^{b} {f(x) dx =\frac{h}{2} [f(a)+ \sum_{j=1}^{n-1} f(x j) +f(b})] - \frac{b-a}{12} h^3 f'' (\mu)$$
% 
% $$\mu \epsilon (a,b)$$
% 
% Donde :
% 
% n= numero de subintervalos 
%
% $$h= \frac{b-a}{n} (paso)$$
% 
% xj=a+jh    
% 
% j =0,1,2....n
% 
% Para nuestro cas particular
% 
% n=10
% 
% $$h= \frac{1-(-1)}{10} = \frac{2}{10} = 0.2$$
%
% $$x_{0}=-1, x_{1}=-0.8, x_{2}=-0.6...x_{9}=0.8, x_{10}=1.0$$
% 
% $$\int_{-1}^{1} e^{- x^2} dx = \frac{0.2}{2} [e^{-1} + 2\sum_{j=1}^{n-1} {e^{- x^2 j}} + e^{-1}] - \frac{2}{12}(0.2) [-2 e^{- \mu^2} (1 - 2\mu^2)]$$
%
% $$=1.4887 + 0.0133 e^{- \mu^2} (1 - 2\mu^2)$$ 
% 
% $$-1 < \mu < 1$$
% 
% 
%
% * La regla compuesta de Simpson
% 
% $$\int_{a}^{b} f(x) dx =\frac{h}{3} [f(a)+ 2 \sum_{j=1}^{(n/2)-1} {f(x_{2 j})} + 4 \sum_{j=1}^{n/2} {f(x_{2 j - 1})} +f(b)] - \frac{b-a}{180} h^4 f^4 (\mu)$$
% 
% $$\mu \epsilon (a,b)$$
% 
% Donde :
% 
% n= numero de subintervalos 
%
% $$h= \frac{b-a}{n} (paso)$$
% 
% xj=a+jh    
% 
% j =0,1,2....n

%%
% Para nuestro caso particular
% 
% n=10
% 
% $$h= \frac{1-(-1)}{10} = \frac{2}{10} = 0.2$$
%
% $$x_{0}=-1, x_{1}=-0.8, x_{2}=-0.6...x_{9}=0.8, x_{10}=1.0$$
% 
% $$\int_{-1}^{1} e^{- x^2} dx = \frac{0.2}{3} [e^{-1} + 2\sum_{j=1}^{4} {e^{- x^2_{2 j}}} + 4\sum_{j=1}^{5} {e^{- (x_{2 j -1})^2}} + e^{-1} + e^{-1}] - \frac{2}{180} (0.2)^4 [-4 e^{- \mu^2}(-4 \mu^4 + 12 \mu^2 -3 )]$$
%
% $$=1.4936 + 0.000031 (0.2)^4 [-4 e^{- \mu^2}(-4 \mu^4 + 12 \mu^2 -3 )]$$ 
% 
% $$-1 < \mu < 1$$
% 
% 
%%
%
% Ahora tenemos tambien la cuadratura gaussiana 
% 
% $$\int_{-1}^{1} f(x) dx \approx \sum_{i=1}^{n} C_{i} f(x i)$$
%
% que ajustandola  a casos "generales"
%
% $$\int_{a}^{b} f(x) dx =  \int_{-1}^{1} f(\frac{(b-a)t + b + a}{2}) dt $$
%
% Cabe alcarar que esta metodologia se apoya de la sig tabla
%
%
% 
% <<tablaCuadGauss>>
% 
% 
% y asi, para nuestro caso especifco con (n=2)
%
% $$\int_{-1}^{1} e^{- x^2} dx \approx e^{- (0.5773502692)^2} + e^{- (-0.5773502692)^2}$$
% 
%%

r=exp(- (0.5773502692)^2) + exp(- (-0.5773502692)^2)

%%
% La precision podria ir aunmentando en cuanto aumentemos n
%

%% Ejercicio 1.
% Realiza la convolución de las siguientes señales:
%
% $f(t) = e^{-t}$ si $0\leq t \leq 1$ y $0$ en otro caso.
%
% $g(t) = t$ si $-1\leq t \leq 1$ y $0$ en otro caso.
%%
% El resultado de la convolución analìtica es:

conv1_an=imread('html/conv1_an.png'); 
imshow(conv1_an);

%%
% El resulltado obtenido con la funciòn de Octave es:

u = @(t) 1*(t >=0);
f = @(t) exp(-t).*(u(t-1)-u(t));
g = @(t) t.*(u(t-1) - u(t+1));
convconm(f,g)

%%
% Debido a limitaciones en la falta de soporte para mostrar gifs en Octave, la animaciòn de la convolución puede ser
% consultada desde el <"siguiente enlace al archivo de Github", https://github.com/JRodolfoL/PracticasASyS/blob/main/P04/html/conv1.gif>.


%% Ejercicio 2.
% Realizar la autocorrelación de la señal:
% $x(t) = u(t)-2*u(t-3)+u(t-4)$

% El resultado de la convolución analìtica es:

conv2_an=imread('html/conv2_an.png'); 
imshow(conv2_an);

%%
% El resulltado obtenido con la funciòn de Octave es:
x = @(t) (t>=-3&t<0.0) - (t>=-4&t<-3);
f = @(t) (t>=0&t<3.0) - (t>=3&t<4);
convconm2(x,f)

%%
% Debido a limitaciones en la falta de soporte para mostrar gifs en Octave, la animaciòn de la convolución puede ser
% consultada desde el <"siguiente enlace al archivo de Github", https://github.com/JRodolfoL/PracticasASyS/blob/main/P04/html/conv2.gif>.

%% Ejercicio 3.
%
% Realice la simulación de la convolución de las señales (c) con (d) del problema 3.1.1
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

%% Ejercicio 4.
%
% Realice la simulación de la correlación de las señales (c) con (d) del problema 3.1.1
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
D = [0 0 0 0 4 2 0 2 4 0 0]
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
convdisc2([n;C],[n;D])
%%


%% Ejercicio 5
% 
% Realice la la convolución de las señales (c) con (d) del problema 3.1.1 
% utilizando el comando conv de MATLAB, muestre el código utilizado y gráfique el resultado
% sugerencia: Utilice las propiedades de traslación de la convolución.
%%
% Definimos el primer vector
C=[0 -9 -6 -3 0 3 6 9 0 0 0];
n=-4:6;
stem(n,C)
axis([-4 4 -10 10])
title('Grafica C')
xlabel('n')
ylabel('x[n]')
%%
% Defnimos el segundo vector
D=[0 0 4 2 0 2 4 0 0 0 0 ];
stem(n,D)
axis([-4 4 -2 5])
set (gca, "xaxislocation", "origin")
set (gca, "yaxislocation", "origin")
set(gca, "box", "off")
title('Grafica D')
xlabel('n')
ylabel('x[n]')
%%
%
% Haciendo la Convolución 
X=-7:13;
R=conv(C,D)
%% Grafica de La convolución
%
stem(X,R)
axis([-8 14 -37 37])
set (gca, "xaxislocation", "origin")
set (gca, "yaxislocation", "origin")
set(gca, "box", "off")
title('Convolución de la grafica C con D')
xlabel('n')
ylabel('x[n]')