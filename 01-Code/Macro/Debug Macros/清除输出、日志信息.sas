ods listing close;
ods output close;
ods results=off;/*����ʾ�ڡ����������*/
dm output 'clear' continue;	/*�����������ڡ�*/
dm log 'clear' continue;/*�������־���ڡ�*/
dm result 'clear' continue;	/*������༭���ڡ�*/
dm odsresult 'clear' continue;/*��������������*/
proc print data=sashelp.class;
run;
