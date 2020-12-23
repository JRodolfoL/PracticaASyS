## Copyright (C) 2020 rodo6
## 
## This program is free software: you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see
## <https://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} convconm (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: rodo6 <rodo6@DESKTOP-JJTBP0C>
## Created: 2020-12-22

function retval = convconm (x, h)
Tam1 = size(x(1,:));
    Tam2 = size(h(1,:));
    T1 = Tam1(2);
    T2 = Tam2(2);
    T3 = T1+T2-1;
  figure (1) % Se crea una figura para hacer las graficas
  dtau = 0.005; % Base de los rectangulos para realizar la integral 
  tau = -2.2:dtau:3; % Intervalo de visualizacion del resultado
  ti = 0; % Indice para el vector de resultados
  tvec = -2:.1:2; % traslaciones de t, cuantas integrales se calulan  
  y = NaN*zeros(1, length (tvec)); % Resultados de acuerdo a cuantos t
  hFig = figure();
  set(hFig, 'Position', [0 0 1000 1000])
    filename = 'testAnimated.gif';
    ttt=1;
  for t = tvec, % Cantidad de traslaciones
      ti = ti+1; % Indice para guardar el resultado (indice del tiempo)
      xh = x(t-tau).*h(tau); % resultado de la multiplicacion 
      lxh = length(xh); % longitud del resultado
      y(ti) = sum(xh.*dtau); % Base por altura, aproximacion de la integral
      subplot (2,1,1), % grafica de 2 x 1 (primera)
      plot(tau, h(tau), 'r-', tau, x(t-tau), 'g--', t, 0, 'ob'); %graficas 
      axis ([tau(1) tau(end) -2.0 2.5]); % limites de los ejes
      patch([tau(1:end-1); tau(1:end-1); tau(2:end); tau(2:end)],...
      [zeros(1,lxh-1);xh(1:end-1);xh(2:end);zeros(1,lxh-1)],...
      [.8 .8 .8], 'edgecolor', 'none');
      xlabel('\tau'); % Texto del eje X
      legend('h(\tau)', 'x(t-\tau)','t','h(\tau)x(t-\tau)')% Caja de Texto  
      subplot (2, 1, 2)  % grafica de 2 x 1 (segunda)
      plot (tvec, y, 'k', tvec (ti), y(ti), 'ok');
      xlabel ('t'); 
      ylabel ('y(t) = \int h(\tau)x(t-\tau) d\tau');
      axis ([tau(1) tau(end) -1.0 2.0]); % limites del eje
      grid; % malla
      drawnow; % efecto de movimiento continuo
      pause(0.05)
        vec2 = zeros(1,T1+2*T2-2);
        frame = getframe(hFig); 
        im = frame2im(frame); 
        [imind,cm] = rgb2ind(im); 
        % Write to the GIF File 
        if ttt == 1 
          imwrite(imind,cm,filename,'gif', 'Loopcount',inf); 
        else 
          imwrite(imind,cm,filename,'gif','WriteMode','append'); 
        end
        ttt=ttt+1;
  end
  end
