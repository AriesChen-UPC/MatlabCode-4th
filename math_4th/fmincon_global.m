function [x,f0]=fmincon_global(f,a,b,n,N,varargin)
x0=rand(n,1); k0=0; if strcmp(class(f),'struct'), k0=1; end %����ṹ��
if k0==1, f.x0=x0; [x f0]=fmincon(f); %����ǽṹ�����������⣬ֱ�����
else, [x f0]=fmincon(f,x0,varargin{:}); end %������ǽṹ�������ģ�ֱ�����
for i=1:N, x0=a+(b-a)*rand(n,1); %��ѭ���ṹ���Բ�ͬ�����������ֵ
   if k0==1, f.x0=x0; [x1 f1 key]=fmincon(f); %�ṹ���������
   else, [x1 f1 key]=fmincon(f,x0,varargin{:}); end %�ǽṹ���������
   if key>0 & f1<f0, x=x1; f0=f1; end %����ҵ��Ľ��������е���ý⣬�洢�ý�
end