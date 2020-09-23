*==============================================================================================*
Book: SAS�������/Romance of SAS Programming
Author:�Ⱥ���/Hongqiu Gu
Contact:guhongqiu(at)yeah(dot)net
Book:https://item.jd.com/12210370.html#crumb-wrap
Title: ��ʮ�� һ��̴������������а���
*==============================================================================================*;




*=���� 10-1 ���ٻ�ȡϵͳ��Ϣ;

%put ��SAS������塷�ָ���ɵĲ���ϵͳ�� &sysscpl.��SASϵͳ��&sysver.��������ڣ�&sysdate9.��;


*���� 10-2 ������ظ�ִ��SAS����;

*==�ٶ�csv��������;
%macro importcsv;
%do i=1 %to 100;
	proc import out=csv&i datafile="d:\data\csv&i..csv"
				 dbms=csv replace;
	run;
%end;
%mend;

%importcsv



*���� 10-3 ���������ִ��SAS����;
%macro report;
	%if &sysday EQ FRIDAY %then %do;
	  proc print data=reportdata;
	  run;
	%else %put Not Friday, No report.;
%mend;

%report;




*���� 10-4 ��������;

*==�ı�;
%let bookname1=Romance of SAS Programming;
%let bookname2=SAS�������;
%let address1=%str(Author%'s address);
%let address2=%nrstr(PUMC&CAMS);

*==����;
%let  phone1=13800137000;
%let  phone2=;

*==�������ʽ;
%let ex1=99+1;
%let ex2=99.9+0.1;

*==�����������ʽ;
%let ex3=%eval(99+1);
%let ex4=%sysevalf(99.9+0.1);

*==����;
%let  prg=%str(proc print data=sashelp.classr;run;);

*==�鿴���;
%put _user_;




*���� 10-5 PROC SQL���������;
*==���������;
proc sql noprint;
	select count(name) into:nname
	from sashelp.class;
quit;
%put &nname;

*==������б�;
proc sql noprint;
	select name into:namelist separated by ","
	from sashelp.class;
quit;
%put &namelist;



*���� 10-6 CALL SYMPUTX��SYMPUTX���������;

*==���������;
data _null_;
	set sashelp.class end=last;
	if last then call symput('nname',_n_);
run;
%put &nname;

*==ϵ�к����;
data _null_;
	set sashelp.class;
	call symputx(cats('name',_n_), name);
run;
%put &name1 &name19;


*���� 10 7 �鿴����ű��Լ��жϺ�������;
%macro testMacroVar(a=,b=);
%global c;
%let c=Hi;

%put �����Զ�������:;
%put  _user_; 

%put ���оֲ������:;
%put  _local_;

%put �����Զ���ȫ�ֺ����:;
%put _global_;

%put a�Ƿ�ȫ�ֺ������ %symglobl(a);
%put c�Ƿ�ȫ�ֺ������ %symglobl(c);

%put b�Ƿ�ֲ��������%symlocal(b);
%mend;

%testMacroVar(a=Stats, b=Thinking);





*���� 10 8 ������ڱ���ʾ;

%let address1=PUMC&CAMS;
%let address2=%nrstr(PUMC&CAMS);

%put &address1;
%put &address2;


%put &address1;
WARNING: Apparent symbolic reference CAMS not resolved.
PUMC&CAMS
%put &address2;
PUMC&CAMS  ;


*���� 10-9 ϵͳѡ��SYMBOLGEN��ʾ�����ֵ;


options symbolgen;
%let title1=SAS�������;
%let title2=����������ͼ�����;
%let title=&title1.:&title2;

 *���� 10 10 %PUT�����ʾ�����ֵ;
options nosymbolgen;
%let title1=SAS�������;
%let title2=����������ͼ�����;
%let title=&title1.:&title2;
%put title1��title2 �ϲ����title����Ϊ��&title;



*���� 10-11 %PUT��������ʾ�����ֵ;
*��ʾ���к����;
%put _all_; 

*��ʾ�����Զ������;
%put _automatic_; 

*��ʾ�����Զ�������;
%put _user_; 

 *��ʾ����ȫ�ֺ����;
%put _global_;

*��ʾ���оֲ������;
%put _local_;





*=���� 10-12 ֱ�����ú����;

%let bookname2017=SAS�������;
%let year=2017;

data tmp;
  name="&bookname2";
  year=&year;
run;


*���� 10-13 ������ú����;
data tmp;
 name="&&bookname&year";
run;


*���� 10-14 ��������ı��ķָ�;
%let lib=sashelp;
data class;
	set &lib..class;
	bookname="&bookname2017.������������ͼ�����";
run;



*���� 10-15 ������������ʾ��;

*==һ��ʾ��;

*==��������;
%macro printds(dataset, obs=5);
  proc print data=&dataset(obs=&obs);
  run;
%mend printds;

*==���ú����;
%printds(sashelp.class, obs=5)



*���� 10-16 �洢����ܺ����;

*==����;
options mstored sasmstore=demo; 
%macro printds(dataset, obs=5)/store;
  options nomprint nosource;
  proc print data=&dataset(obs=&obs);
  run;
%mend printds;

*==����;
options mstored sasmstore=demo; 
%printds(sashelp.class, obs=5)


  filename maccat catalog 'demo.sasmacr.printds.macro';
  data _null_;
    infile maccat;
    input;
    list;
  run;

*���� 10-17 �꺯��Ӧ��ʾ��;

%macro macro_name <(parameter_list)> </ option(s)>; 
	<macro_text>
%mend <macro_name>; 

%macro_name<(parameter_list)>;


*===�����;

%macro printds(dataset, sex=F,obs=5,);
  %if &sex eq F %then %str( title "First &obs record for female";);
  %else %if &sex eq M %then %str(title "First &obs record for male";);
  %else  %str(title "Wrong gender"; %abort;);
  proc print data=&dataset(obs=&obs where=(sex="&sex"));
  run;
%mend printds;


%printds(sashelp.class,sex=M,obs=5)



*===ѭ��;

*==%do %while;
%macro importcsv;
%let i=1;
%do %while(&i<=100);
	proc import out=csv&i datafile="d:\data\csv&i..csv"
				 dbms=csv replace;
	run;
	%let i=&i+1;
%end;
%mend;

%importcsv;


*==%do until;


%macro importcsv;
%let i=1;
%do %until(&i<=99);
	proc import out=csv&i datafile="d:\data\csv&i..csv"
				 dbms=csv replace;
	run;
	%let i=&i+1;
%end;
%mend;

%importcsv;

%let title=SAS������壺����������ͼ�����;
%let n=%length(&title);
%let main_title=%scan(&title,1,��);

%put ���ȣ� &n ;
%put �����⣺&main_title;




*���� 10 18 S1��Ӳ�������ʵ�ֺ�����;
*==S1;

*==����SAV;
proc export data=sashelp.class
			 outfile="D:\01 SAS�������\02 Data\Raw\class.sav"
			 dbms=sav replace;
run;

*==����xls;
proc export data=sashelp.class
			 outfile="D:\01 SAS�������\02 Data\Raw\class.xls"
			 dbms=xls replace;
run;

*==����xlsx;
proc export data=sashelp.class
			 outfile="D:\01 SAS�������\02 Data\Raw\class.xlsx"
			 dbms=xlsx replace;
run;

*==����csv;
proc export data=sashelp.class
			 outfile="D:\01 SAS�������\02 Data\Raw\class.csv"
			 dbms=csv replace;
run;

*==txt;
proc export data=sashelp.class
			 outfile="D:\sashelp.class.txt"
			 dbms=tab replace;
run;


*���� 10 19 S2��Ӳ��������������;
*==S2-1;

%let dsname=sashelp.class;
%let filelocation=D:\01 SAS�������\02 Data\Raw;
%let filetype=sav;

proc export data=&dsname
			 outfile="&filelocation\&dsname..&filetype"
			 dbms=&filetype replace;
run;



*���� 10 20  S2��Ӳ��������������;
*===s2-2;

*==Ӳ����껯;
%macro exfile(dsname=sashelp.class, filelocation=D:\01 SAS�������\02 Data\Raw, filetype=sav);
proc export data=&dsname
			 outfile="&filelocation\&dsname..&filetype"
			 dbms= %if %upcase(&filetype) NE TXT %then &filetype ;
                   %else TAB; 
             replace;
run;
%mend exfile;


*���� 10 21 S3�����������Ż�;
*==���Ը�����������;
options mprint symbolgen mlogic;
%exfile(dsname=sashelp.class, filelocation=D:\01 SAS�������\02 Data\Raw, filetype=sav)
%exfile(dsname=sashelp.class, filelocation=D:\01 SAS�������\02 Data\Raw, filetype=xls)
%exfile(dsname=sashelp.class, filelocation=D:\01 SAS�������\02 Data\Raw, filetype=xlsx)
%exfile(dsname=sashelp.class, filelocation=D:\01 SAS�������\02 Data\Raw, filetype=csv)
%exfile(dsname=sashelp.class, filelocation=D:\01 SAS�������\02 Data\Raw, filetype=txt)
