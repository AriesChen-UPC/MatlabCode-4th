function S=sylv_mat(A,B)
n=length(B)-1; m=length(A)-1; S=[]; % �ɸ���������n��m
A1=[A(:); zeros(n-1,1)]; B1=[B(:); zeros(m-1,1)]; % ��1����m + 1��
for i=1:n, S=[S A1]; A1=[0; A1(1:end-1)]; end % ���գ�4.60��������ϵ������
for i=1:m, S=[S B1]; B1=[0; B1(1:end-1)]; end; S=S.'; % ת�ú�õ�Sylvester����