
function convconm2(x,h)
Tam1 = size(x(1,:));
    Tam2 = size(h(1,:));
    T1 = Tam1(2);
    T2 = Tam2(2);
    T3 = T1+T2-1;
  figure (1) % Se crea una figura para hacer las graficas
  dtau = 0.005; % Base de los rectangulos para realizar la integral 
  tau = -5:dtau:9; % Intervalo de visualizacion del resultado
  ti = 0; % Indice para el vector de resultados
  tvec = -4:.1:4; % traslaciones de t, cuantas integrales se calulan  
  y = NaN*zeros(1, length (tvec)); % Resultados de acuerdo a cuantos t
  hFig = figure();
  set(hFig, 'Position', [0 0 1000 1000])
    filename = 'testAnimated2.gif';
    ttt=1;
  for t = tvec, % Cantidad de traslaciones
      ti = ti+1; % Indice para guardar el resultado (indice del tiempo)
      xh = x(t-tau).*h(tau); 
      lxh = length(xh); % longitud del resultado
      y(ti) = sum(xh.*dtau); 
      subplot (2,1,1), 
      plot(tau, h(tau), 'r-', tau, x(t-tau), 'g--', t, 0, 'ob'); %graficas 
      axis ([tau(1) tau(end) -2.0 2.5]); 
      patch([tau(1:end-1); tau(1:end-1); tau(2:end); tau(2:end)],...
      [zeros(1,lxh-1);xh(1:end-1);xh(2:end);zeros(1,lxh-1)],...
      [.8 .8 .8], 'edgecolor', 'none');
      xlabel('\tau'); % Texto del eje X
      legend('h(\tau)', 'x(t-\tau)','t','h(\tau)x(t-\tau)')% Caja de Texto  
      subplot (2, 1, 2) 
      plot (tvec, y, 'k', tvec (ti), y(ti), 'ok');
      xlabel ('t'); 
      ylabel ('y(t) = \int h(\tau)x(t-\tau) d\tau');
      axis ([tau(1) tau(end) -1.0 5.0]); 
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






