function A=any_matrix(nn,sA,varargin) %�����������
v=varargin; n=nn(1); if length(nn)==1, m=n; else, m=nn(2); end
s=''; k=length(v); K=0; if n==1 | m==1, K=1; end
if k>0, s='('; for i=1:k, s=[s ',' char(v{i})]; end, s(2)=[]; s=[s ')']; end
for i=1:n, for j=1:m, %��ѭ���ṹ���Ԫ�ص�������
if K==0, str=[sA int2str(i),int2str(j) s]; else, str=[sA int2str(i*j) s]; end
eval(['syms ' str]); eval(['A(i,j)=' str ';']); %ָ����Ӧ�ľ���Ԫ��
end, end
