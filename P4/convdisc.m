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
## @deftypefn {} {@var{retval} =} convdisc (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: rodo6 <rodo6@DESKTOP-JJTBP0C>
## Created: 2020-12-21

function retval = convdisc (x1,x2)

Tam1 = size(x1(1,:));
    Tam2 = size(x2(1,:));
    T1 = Tam1(2);
    T2 = Tam2(2);
    T3 = T1+T2-1;
    vec1 = zeros(1,T1+2*T2-2);
    vec2 = zeros(1,T1+2*T2-2);
    Tec2 = -(T2-1):(T1+T2-2);
    size(vec2);
    size(Tec2);
    x3=zeros(2,T3);
    x3(1,:)=0:T3-1;
    x3(1,:)=x3(1,:)+x1(1,1)+x2(1,1);
    vec1(1,T2:T2+T1-1)=x1(2,:);
    figure (1)
    hFig = figure();
    set(hFig, 'Position', [0 0 1000 1000])
    filename = 'testAnimated3.gif';
    ttt=1;
    for m=0:T1+T2-2
        vec2(1,1+m:T2+m)=fliplr(x2(2,:));
        x3(2,m+1)=sum(vec1.*vec2);
        subplot(4,1,4)
        stem(x3(1,:),x3(2,:),'r','LineWidth',3)
        axis([Tec2(1),T1+2*T2-2,  min(x3(2,:))-1 max(x3(2,:))+1])
        ylim('auto')
        ylabel('x_3[n]','FontWeight','bold','FontSize',16);
        xlabel('n','FontWeight','bold','FontSize',16);
        grid on
        subplot(4,1,1)
        stem(x2(1,:),x2(2,:),'k','LineWidth',3)
        ylabel('x_2[m]','FontWeight','bold','FontSize',16);
        xlabel('m','FontWeight','bold','FontSize',16);
        title('CONVOLUCI�N','FontWeight','bold','FontSize',16);
        grid on
        axis([Tec2(1),T1+2*T2-2, min(x2(2,:))-1 max(x2(2,:))+1])
        ylim('auto')
        subplot(4,1,2)
        stem(x1(1,:),x1(2,:),'b','LineWidth',3)
        ylabel('x_1[m]','FontWeight','bold','FontSize',16);
        xlabel('m','FontWeight','bold','FontSize',16);
        grid on
        axis([Tec2(1),T1+2*T2-2, min(x1(2,:))-1 max(x1(2,:))+1])
        ylim('auto')
        subplot(4,1,3)
        stem(Tec2,vec2(1,:),'g','LineWidth',3)
        axis([Tec2(1),T1+2*T2-2,min(vec2)-1, max(vec2)+1 ])
        ylim('auto')
        ylabel('x_2[n-m]','FontWeight','bold','FontSize',16);
        xlabel('m','FontWeight','bold','FontSize',16);
        grid on
        drawnow;
        pause(0.4)
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
