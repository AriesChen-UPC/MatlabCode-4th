function P=fitting_poly(type,N,x)
switch type %����ͬ���������ʽ
   case {'P','Legendre'}, P=[1,x]; %Legendre����ʽ
      for n=2:N, P(n+1)=(2*n-1)/n*x*P(n)-(n-1)/n*P(n-1); end
   case {'T','Chebyshev'} %Chebyshev����ʽ
      P=[1,x]; for n=2:N, P(n+1)=2*x*P(n)-P(n-1); end
   case {'L','Laguerre'}, P=[1,1-x]; %Laguerre����ʽ
      for n=2:N, P(n+1)=(2*n-1-x)/n*P(n)-(n-1)/n*P(n-1); end
   case {'H','Hermite'}, %Hermite����ʽ
      P=[1,2*x]; for n=2:N, P(n+1)=2*x*P(n)-2*(n-1)*P(n-1); end
end
