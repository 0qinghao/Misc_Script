hadamard(8)
% hadmard �任���ϵ��Ƶ�ʷֲ���ȡ����ÿһ��/�з��ű仯��Ƶ��
had_f_1d = [zeros(1,8);zeros(1,8)+7;zeros(1,8)+3;zeros(1,8)+4;zeros(1,8)+1;zeros(1,8)+6;zeros(1,8)+2;zeros(1,8)+5];

% �б仯��+�б仯��
had_f = had_f_1d + had_f_1d';

had_f

% ����
had_f_1d_sort = had_f_1d + 1;
had_f_sort = had_f_1d_sort + had_f_1d_sort' - 1;
had_f_sort;