function k=my_fact(n)
if nargin~=1, error('Error: Only one input variable accepted'); end
if abs(n-floor(n))>eps | n<0 %�ж�n�Ƿ�Ϊ�Ǹ�������������������������Ϣ
   error('n should be a non-negative integer'); %����������Ϣ
end
if n>1, k=n*my_fact(n-1); %��n > 1������õݹ����
elseif any([0 1]==n), k=1; end %0! = 1! = 1�������ĳ���