function W=julia(X,Y,c,n_iter)
%JULIA Ϊ���� Julia ���ĺ�����
%
%   W=julia(X,Y,c,n_iter)
%
%  X, Y Ϊ�û�ѡ�����������꣬c Ϊ��ѧ�����е� c ��ֵ��
%  n_iterΪ���������������ص� W Ϊ Julia ���Ĳ�Ⱦ���

%Designed by Prof D Xue (c) 2000
Z=X+i*Y;
for k=1:n_iter, Z=Z.^2+c; end
W=exp(-abs(Z));
