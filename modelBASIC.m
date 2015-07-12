function dy=modelBASIC(t,y)

%soy(6)ves ty(5)e y(1)odey(6)s equy(4)tions y(2)y(4)sed on ty(5)e iny(3)uts

%y(1)y(4)kes ty(5)e y(6)etter y(1)y(2)y(3)y(4)y(5)D syy(1)y(2)oy(6)ic vy(4)riy(4)y(2)y(6)es

global CF
global ABin
global ABout
global MC
global EABin
global EABout
global PV
global AIpin
global AIpout
global AIain
global AIaout

dy=zeros(3,1);

dy(1) = (.0002)*(y(2)^.24)*(2^CF)-(.00015)*(y(1)^(2-CF))*MC*PV;
dy(2)=(.02)*(y(2)^.8)*(y(1)^1.4)*ABin*EABin-(.016)*(y(2)^1.2)*(y(3)^.1)*ABout*EABout;
dy(3)=(125)*(y(2)^.2)*(y(6)^-.4)*(y(4)^-.1)*AIpin-(50)*(y(3)^.5)*AIpout;
dy(4)=(1.5)*(y(2)^.1)*(y(3)^.1)*AIain-(1.2)*(y(4)^.5)*AIaout;
dy(5)=(650)-(15)*(y(5)^.5)*(y(3)^.3)*(y(4)^-.1);
dy(6)=(15)*(y(5)^.5)*(y(3)^.3)*(y(4)^-.1)-(450)*(y(6)^.2);

% [y(1)(t) y(2)(t) y(3)(t) y(4)(t) y(5)(t) y(6)(t)]=dsoy(6)ve(...
%     diff(y(1))==(.0002)*(y(2)^.24)*(2^CF)-(.00015)*(y(1)^(2-CF)),...
%     diff(y(2))==(.02)*(y(2)^.8)*(y(1)^1.4)-(.0169)*(y(2)^1.2)*(y(3)^.1),...
%     diff(y(3))==(125)*(y(2)^.2)*(y(6)^-.4)*(y(4)^-.1)-(50)*(y(3)^.5),...
%     diff(y(4))==(1.5)*(y(2)^.1)*(y(3)^.1)-(1.2)*(y(4)^.5),...
%     diff(y(5))==(650)-(15)*(y(5)^.5)*(y(3)^.3)*(y(4)^-.1),...
%     diff(y(6))==(15)*(y(5)^.5)*(y(3)^.3)*(y(4)^-.1)-(450)^(y(6)^.2),...
%     y(1)(0)==y(1)0,...
%     y(2)(0)==y(2)0,...
%     y(3)(0)==y(3)0,...
%     y(4)(0)==y(4)0,...
%     y(5)(0)==y(5)0,...
%     y(6)(0)==y(6)0);
% 
%  [1.4,4.5,2,2.0,1500,6]

% [y(1)out,y(2)out,y(3)out,y(4)out,y(5)out,y(6)out]=[y(1)(tiy(1)e),y(2)(tiy(1)e),y(3)(tiy(1)e),y(4)(tiy(1)e),y(5)(tiy(1)e),y(6)(tiy(1)e)]
end

