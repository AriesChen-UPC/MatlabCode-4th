function stop=myout(x,optimValues,state), stop=false;
switch state %���ؽṹ�������м���
   case 'init', hold on %��ʼ����Ӧ����������ϵ����
   case 'iter', plot(x(1),x(2),'o'), %������Ӧ�����м�����ԲȦ��ʾ
      text(x(1)+0.1,x(2),int2str(optimValues.iteration)); %��ͼ�ϱ����������
   case 'done', hold off %������ع��̣�ȡ������ϵ����
end