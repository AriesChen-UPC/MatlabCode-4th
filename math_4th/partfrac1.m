function f=partfrac1(F,s)
f=sym(0); if nargin==1, syms s; end, [num,den]=numden(F); x0=vpasolve(den);
[x,ii]=sort(double(x0)); x0=x0(ii); x=[x0; rand(1)]; %��ԭ����ʽ��������Ƹ�x 0
kvec=find(diff(double(x))~=0); ee=x(kvec); kvec=[kvec(1); diff(kvec(:,1))];
a0=limit(den/s^length(x0),s,inf); F1=num/(a0*prod(s-x0)); %�ع���ĸ����ʽ
for i=1:length(kvec), for j=1:kvec(i), %��ѭ���ṹ��ÿ���ع����������ַ�ʽչ��
   m=kvec(i); s0=ee(i); k=subs(diff(F1*(s-s0)^m,s,j-1),s,s0); %�������չ��ϵ��
   k/(s-s0)^(m-j+1)/factorial(j-1);
   f=f+k/(s-s0)^(m-j+1)/factorial(j-1); %���첿�ַ�ʽչ�����ʽ
end, end

