function [x,f,key]=transport_linprog(F,s,d,intkey)
[m,n]=size(F); X=zeros(n*m,m); Y=zeros(n*m,n); %X��Y �����ʼ��
for i=0:m-1, X(i*(n+n*m)+1:i*(n+n*m)+n)=1; end %����X ����
for k=1:n*m+1:n*m*n, i=0:m-1; Y(k+n*i)=1; end %����Y ����
Aeq=[X Y]'; xm=zeros(1,n*m); F1=F.'; f=F1(:).'; Beq=[s(:); d(:)];
if nargin==3, [x,f,key]=linprog(f,[],[],Aeq,Beq,xm); %������Թ滮����
else, [x,f,key]=intlinprog(f,1:n*m,[],[],Aeq,Beq,xm); x=round(x); end
x=reshape(x,n,m).'; %�Ͼ�����������Թ滮���⣬���佫�����ͽ⻹ԭ�ɾ����������ʽ