*==============================================================================================*
Book: SAS�������/Romance of SAS Programming
Author:�Ⱥ���/Hongqiu Gu
Contact:guhongqiu(at)yeah(dot)net
Book:https://item.jd.com/12210370.html#crumb-wrap
Title: ��һ�� ����������᣺��ʵ����
*==============================================================================================*;

*���� 02-1 ����LIBNAME����Խ������߼���;

*===��*�ŵ�����ע����===;
*===�Խ����ÿ�===��
*===ȡ��Demo,��ַ��D:\03 Writting\01 SAS�������\02 Data\Clean;
libname  demo "D:\03 Writting\01 SAS�������\02 Data\Clean";




*���� 02-2 �鿴���ݼ�������Ϣ������ֵ;
*===�鿴�����ļ���������Ϣ;
proc contents data=demo.class_datafile;
run;

*===�鿴�����ļ�������ֵ;
proc print data=demo.class_datafile;
run;
*===�鿴��ͼ��������Ϣ;
proc contents data=demo.class_view;
run;

*===�鿴��ͼ������ֵ;
proc print data=demo.class_view;
run;



*���� 02-3 SET��佨�����������ļ�;
*===�Խ����ÿ�;
libname  demo "D:\03 Writting\01 SAS�������\02 Data\Clean";

*===���������ݼ���demo.����ʡ��;
data demo.class_datafile;
	set sashelp.class;
run;

*===����ʱ���ݼ���work.��ʡ��;
data  class_datafile;
	set sashelp.class;
run;


*���� 02-4 ����SAS��ͼ;
*===from data setp;
data demo.class_view/view=demo.class_view;
	set sashelp.class;
run;

*===from Proc sql;
proc sql;
	create view demo.class_view as 
	select * 
	from sashelp.class;
quit;



*���� 02-5 SAS���ڡ�ʱ���Ѿ�����ʱ��ı���;
data tmp;
  date="01Jan1960"d;
  time="00:00:00"t;
  datetime="01Jan1960 00:00:00"dt;
run;


*���� 02-6 SAS�������ݼ��ͱ�����;
*===���������ݼ�;
*===����������;

options validmemname=extend validvarname=any; 
data  ��������ʾ;
       SAS���ı�����="YES";
       SAS����׃����="YES";
      '2SAS���ı�����'n="YES";
      '2SAS����׃����'n="YES";
      'SAS�� �������'n="YES"; 
      'SAS��#  @ %�������ַ�������'n="YES";  
run;




*���� 02-7 ��̷�񣺹淶ԣ����;

*===�淶;
*===�Խ����ÿ�;
libname demo "D:\03 Writting\01
SAS�������\02 Data\Clean";

*===���������ݼ��� demo.����ʡ��;
data demo.class_datafile;
set sashelp.class;
run;

*===����ʱ���ݼ��� work.����ʡ��;
data class_datafile;
set sashelp.class;
run;

*===����;
libname demo "D:\03 Writting\01
SAS�������\
02 Data\Clean";
data demo.class_datafile;
set sashelp.class;
run; data class_datafile; set
sashelp.class;run;



*���� 02-8 SAS�еĳ���;
data _null_;
  *===�ַ�����;
  c1="Hongqiu Gu's Book";
  c2='Hongqiu Gu''s Book';

  c3='Hongqiu Gu"s Book';
  c4="Hongqiu Gu""s Book";

  *===���ֳ���;
  n1=123;
  n2=-123;
  n3=+123;
  n4=1.23;
  n5=0123;

  *===����ʱ�䳣��;
  d='08Sep2016'D;
  t='11:11'T;
  dt='08Sep2016:11:11'DT;

  *===����־�����;
  put  c1-c4 ;
  put  n1-n5 ;
  put d yymmdd10.;
  put t time.;
  put dt datetime.;
run;



*���� 02-9 SAS����Ԫ����ʾ;
*====������ʾ;
data test2;
   length ID $ 4;
 	input Name $  start yymmdd10.  end date8.  grade; *�����ʽ;
	FirstName=substr(Name,1,1);                       *����substr;
	GivenName=substr(Name,length(Name)-1,2);          *����substr;
	call cats(ID,FirstName, GivenName);               *CALL CATS����;
	if grade>=2  and  start<'01Jun2016'd  then  pay=(end-start)*150; *�Ƚϡ��߼�����������;
	else pay=(end-start)*100;
    datalines; 
ZhangXL 2016/08/09 06SEP16 1
WangSJ 2016/07/03 09SEP16 2
WenTC 2016/05/05 02SEP16 3
LiWC 2016/04/09 10SEP16 2
 ;
run;

 options nodate;                           *ϵͳѡ��;
proc print data=test2(obs=2);             *���ݼ�ѡ��;
  	var ID start end  pay ;
	format start yymmdd10.  end yymmdd10.;  *�����ʽ;
run;



*���� 02-10 IF-ELSE/THEN ʾ��;
data male female;
  set sashelp.class;
       if  sex="M" then output male;
  else if  sex="F" then output female;
  else put "Invalid sex :" sex ;
run;



*���� 02-11 IF-ELSE���DO-END;
data male female;
  set sashelp.class;
       if  sex="M" then do; gender="Male "; output male; end;
  else if  sex="F" then do; gender="Female"; output female; end;
  else put "Invalid sex :" sex ;
run;



*���� 02-12 DOѭ�����;
data schedule;
  do date='01Sep2016'd to '30Sep2016'd ; *����ѭ��;
     day=weekday(date);
	 if day in (1,7) then Activity="Running";
	 else if day in (2,4,6) then Activity="Writing";
	 else Activity="Reading";
	 output;
  end;
run;

data random;
	do i=1 to  10;
	 r=rannor(123);
	 output;
	end;
run;



*==���� 02-13 ѭ�����do while ��do unti;
data dowhile;
  i=0;
  do while(i<5);
      i+1;
	 output;
  end;
run;

data dountil;
  i=0;
  do until(i>=5);
      i+1;
	 output;
  end;
run;



*���� 02-14 ��������;

 *===��������;
 *===sbp1-sbp7��sbp1��sbp7������д��;
 array sbp{7} sbp1-sbp7;
 array dbp{1:7} dbp1-dbp7;


 *===����ʼֵ;
 array sbp{7} sbp1-sbp7 (163 164 167 171 155 158 154);
 array dbp{7} dbp1-dbp7 (98 99 92 94 95 93 93);


 *===�����ά����;
 array bp{2,1:7} sbp1-sbp7 dbp1-dbp7 ;
 array bp{2,7} sbp1-sbp7 dbp1-dbp7 (163 164 167 171 155 158 154 98 99 92 94 95 93 93);



 
 *���� 02-15 ��������Ԫ��;

data tmp;
  input sbp1-sbp7 dbp1-dbp7;
  datalines;
163 164 167 171 155 158 154 98 99 92 94 95 93 93
164 165 163 161 165 168 164 99 98 96 99 95 91 96
;
run;


*===��������Ԫ��;
data tmp;
*===��������;
  array sbp{7} sbp1-sbp7 (163 164 167 171 155 158 154);
  array dbp{7} dbp1-dbp7 (98 99 92 94 95 93 93);
  array bp{2,7} sbp1-sbp7 dbp1-dbp7 (163 164 167 171 155 158 154 98 99 92 94 95 93 93);
 *===����һά����;
  do i=1 to 7;
    put "��" i "�β�����SBPΪ��" sbp{i};
    put "��" i "�β�����DBPΪ��" dbp{i};
  end;
 *===������ά����;
  do m=1 to 2;
    do n=1 to 7;
	  put "Ѫѹ����Ϊ��" m "��Ѫѹ��������Ϊ��" n  "��Ѫѹ����ֵΪ��" bp{m,n};
	end;
  end;
run;

 
 
 *���� 02-16 �������г�Ӧ��ʾ��; 
 
data _null_;
   length  FullName_ByFunction FullName_ByRoutine $10;
   FamilyName="Gu";
   GivenName="Hongqiu";

   *===�ú�������ȫ��;
   FullName_ByFunction=catx(" ",GivenName, FamilyName);

   *===���г�����ȫ��;
   call catx(" ",FullName_ByRoutine, GivenName, FamilyName );

   *===Log�в鿴���;
   put "Fullname Generatedy by Function: " FullName_ByFunction;
   put "Fullname Generatedy by Routine: " FullName_ByRoutine;

run;



*==���� 02-17 ���һ��SQL����;
proc sql;
	select name, sex, age
	from sashelp.class;
quit;



*==���� 02-18 PROC SQL SELECT���ȫ�Ӿ�ʾ��;

proc sql;
	select sex, count(name) as cnt_name ,mean(height) as m_height
	from sashelp.class
    where age>=12
	group by sex
	having m_height>62
    order by cnt_name;
quit;




*===���� 02-19 �����;

*===�Զ���;
%let PUMC=Peking Union Medical College;

*===�鿴ϵͳ�Դ�;
%put &sysdate;

*===�鿴�Զ���;
%put &PUMC;




*���� 02-20  ����͵���Macro;

*===����Macro;
%macro prtdsvar(data=, var=);
proc print data=&data;
	var &var;
run;
%mend;

*===����Macro;
%prtdsvar(data=sashelp.class, var=name sex)




*���� 02-21 DPV��ʾ����;

data demoPDV;
	input ID $  Chinese  Math  English;
	Sum=Chinese+Math+English;
datalines;
S001  80  99  93
S002  90  85  95
S003  83  88  81
;
run;


*���� 02-22 ��֤PDV;

data demoPDV;
    put "��" _n_ "������ǰ��" _all_;
	input ID $  Chinese  Math  English;
	Sum=Chinese+Math+English;
    put  "��" _n_ "�����к�" _all_;
datalines;
S001  80  99  93
S002  90  85  95
S003  83  88  81
;
run;



*���� 02-23 @��@@ʾ������;
*===��������=������=4;
data test1;
	 input id x y z;
	 datalines;
 1 98 99 97
 2 93 91 92
 ;
run;


*===��������=�����������input���;
data test1;
	 input id@;
	 input x@;
	 input y@;
	 input z@;
	 datalines;
 1 98 99 97
 2 93 91 92
 ;
 run;


*=== ��������=k*������;
data test3;
 input id x y z @@;
 datalines;
 1 98 99 97 2  93 91 92
 ;
run;


 
 
 *���� 02-24 @��@@��̾Ϣ;
data test;
    input x @;       /*����@����Hס����Ч�ڵ���һ��input���*/
    input y;         /*û��@��H��ס����һ��input����ȥ���µ�һ��*/
    input z @@;      /*����@��Hסû���⣬��Ч���ӳ���Data����һȦ*/
datalines;
1 2 3
4 5 6
7
;
run;

data test;
    input x;      
    input y@@;         
    input z @;      
datalines;
1 2 3
4 5 6
7
;
run;



*===select����﷨;
SELECT <DISTINCT | UNIQUE> object-item-1 <, object-item-2, ...>
<INTO macro-variable-specification-1 <, macro-variable-specification-2, ...>>
FROM from-list
<WHERE sql-expression>
<GROUP BY group-by-item-1 <, group-by-item-2, ...>>
<HAVING sql-expression>
<ORDER BY order-by-item-1 <, order-by-item-2 <ASC | DESC>, ...>>; 

