     function [c,ceq]=c6minlp(x), ceq=[];
     c=-[-x(1)^2-x(2)^2-x(3)^2-x(4)^2-x(1)+x(2)-x(3)+x(4)+8;
         -x(1)^2-2*x(2)^2-x(3)^2-2*x(4)^2+x(1)+x(4)+10;
         -2*x(1)^2-x(2)^2-x(3)^2-2*x(4)^2+x(2)+x(4)+5];
