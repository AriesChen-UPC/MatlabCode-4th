function y=legendre_poly(a,x) %a��x����������
a=a(:); x=x(:); n=length(a); X=[ones(size(x)) x]; %ǰ����
for i=2:n-1, X(:,i+1)=(2*n-1)/n*x.*X(:,i)-(n-1)/n*X(:,i-1); end, y=X*a;
