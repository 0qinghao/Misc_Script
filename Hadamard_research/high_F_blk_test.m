% ���ɸ�Ƶͼ�� tv1
tv1 = zeros(8);tv1(2:2:8,2:2:8)=ones(4);tv1(1:2:8,1:2:8)=ones(4);
tv1 = tv1 * 255

% DCT ���� tv1 ȷʵΪ��Ƶ�ź�
round(dct2(tv1))

% hadmard �任���� tv1�����ִ����Ƶ��ϵ�������� (1,1) ��
hadamard(8)*tv1*hadamard(8)'

