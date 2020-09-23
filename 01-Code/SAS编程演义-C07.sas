*==============================================================================================*
Book: SAS�������/Romance of SAS Programming
Author:�Ⱥ���/Hongqiu Gu
Contact:guhongqiu(at)yeah(dot)net
Book:https://item.jd.com/12210370.html#crumb-wrap
Title: ������ ���Ѵ�������ѣ����ø�ʽ
*==============================================================================================*;



*���� 7-1 ���������ʽ;

data tmp;
	input data  date7.;
	format data  yymmdd10.;
datalines;
11FEB17
20AUG16
;
run;

proc print data=tmp;
run;



*���� 7-2 SAS���ø�ʽ�嵥;

proc sql;
 create table SysFormats as
 select distinct fmtname from dictionary.formats;
quit;

proc print data= SysFormats;
run; 


*���� 7-3 PROC FORMAT�Զ����ʽ��

*===�Զ����ʽ;
proc format ;
  value $sexf F="Ů��"
              M="����";
  value level  1="��"
               2="��"
			   3="��";
run;


*���� 7-4 PROC FORMAT��CNTLOUTѡ�����ʽ��������;
proc format library=work cntlout=fmt;
run;


data fmt;
  set fmt;
run;

*���� 7-5 �����ݼ������ʽ;
proc format library=work cntlin=fmt(keep=fmtname start end label type);
run;



*���� 7-6 ��ʽ��ʹ�÷�Χ;
*===Data�� PUT�����ָ��;
data _null_;
  set sashelp.class(obs=5);
  put name sex $sexf.;
run;

*===Proc��Format���ָ��;
proc print data=sashelp.class(obs=5);
	var name sex ;
	format sex $sexf.;
run;

*===Proc sql��formatѡ��;
proc sql;
  select name , sex  format=$sexf.
  from sashelp.class(obs=5);
quit;



*���� 7-7 �Զ����ʽ���ڱ����ط���;

*===�����������ݼ�;
data obese;
length  status $ 15;
 set sashelp.class;
 BMI= weight*0.4536/(height*0.0254)**2;
run;


*===�Զ����ʽ;
proc format;
  value obefmt low-18.5="Underweight"
               18.5-<25="Normal"
			   25-<30="Overweight"
			   30-high="Obese";
run;

*===ԭ����+��ʽֱ��ͳ���·����Ƶ��;
proc freq data=obese;
	table bmi ;
	format bmi obefmt.;
run;




*���� 7-8 ͳ�ƹ����м����Զ����ʽ;
proc format;
  value obefmt  low-18.5="Underweight"
			    18.5-high="Normal or above";
run;

proc logistic data=obese;
     class sex;
	model bmi(event="Underweight")=age sex ;
	format bmi obefmt.;
run;



*���� 7-9 �����Զ����ʽͳ��ȱʧ����ȱʧ�۲���;
*===�Զ����ʽ;
proc format;
	value $ missfmt ' '="Missing"
	        other="Not Missing";
	value   nmissfmt . ="Missing"
	        other="Not Missing";
run;

*===�����������ݼ�;
data class;
  set sashelp.class;
  if rannor(123)<0.5 then call missing(sex);
  if rannor(456)<0.05 then call missing(age);
run;
  
*===ͳ��ȱʧ����ȱʧƵ��;
proc freq data=class;
	table sex  age/missing;
    format sex $missfmt. age nmissfmt.;
run;
	


*���� 7-10 �Զ����ʽ����������ʾ;

proc format;
  value obefmt  low-18.5="red"
			    18.5-high="black";
run;

proc report data=obese nowd split='~'
    style(report)=[background=white foreground=black];
	column name sex age bmi;
	define name/display;
	define sex/display;
	define age/display;
	define bmi/format=4.1 style=[foreground=obefmt.];
run;
