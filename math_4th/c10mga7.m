  function [S,f]=c10mga7(S,options), x=S(1:2);
  f=-20-(x(1)/30-1)^2-(x(2)/20-1)^2+...
      10*(cos(pi*(x(1)/30-1))+cos(pi*(x(2)/20-1)));
