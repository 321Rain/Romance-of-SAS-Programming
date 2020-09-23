*==============================================================================================*
Book: SAS�������/Romance of SAS Programming
Author:�Ⱥ���/Hongqiu Gu
Contact:guhongqiu(at)yeah(dot)net
Book:https://item.jd.com/12210370.html#crumb-wrap
Title: ������ ��Ӧ���˺����ݿ⼯
*==============================================================================================*;



*���� 5-1 MODIFY����޸����й۲�;

*==�����������ݼ�;
data class;
  set sashelp.class;
run;

*==SET����޸�;
data class1;
 set class;
 weight=weight*0.4536;
 height=height*0.0254;
run;

*==MODIFY����޸�;
data class;
 modify class;
 weight=weight*0.4536;
 height=height*0.0254;
run;





*���� 5-2 MODIFY����޸�ƥ��۲�;

*===���������ݼ�;
data raw;
   name="ͳ��˼ά";gender=""; age=2; Location="BJ";output;
   name="GUHQ";gender="M";    age=.; Location="BJ";output;
run;

*===�����������ݼ�;
data new;
	name="ͳ��˼ά";gender="M";output;
	name="GUHQ";age=35;output;
	name="GUHQ";age=30;output;
run;

*===���������ݼ����������ݼ�;
data raw;
 modify raw new;
 by name;
run;


*���� 5 3 MODIFY����޸�ƥ��۲ⲹȫĬ��ʡ�Ե����;

data raw;
 modify raw new;
 by name;
 replace;
run;



*���� 5-4 MODIFY���OUTPUT, REMOVE�Լ�REPLACE�÷�;

data class;
  set sashelp.class;
run;

data class class_female;
  	modify class;
	*===���ΪŮ��
	   �����뵽class_female���ݼ�
	   ���Ѵ����۲��ԭ���ݼ��Ƴ�;	   
	if sex="F" then do;
      output class_female;
	  remove class;
	end;
    *===�޸�Height����
	    �滻CLASS���ݼ���height����;
	else do;
      height=height+5;
      replace class ;	 
	end;
run;


*���� 5 5 UPDATE���������ݼ�;

*===���������ݼ�;
data raw;
   name="ͳ��˼ά";gender="";  age=2;Location="BJ";output;
   name="GUHQ";gender="M";age=.;Location="BJ";output;
run;

*===�����������ݼ�;
data new;
	name="ͳ��˼ά";gender="M";output;
	name="GUHQ";age=30;output;
run;

*===����;
proc sort data=raw;
 	by name;
run;

proc sort data=new;
	by name;
run;

*===���������ݼ����������ݼ�����ȫ�Ա��������;
data want;
 update raw new;
 by name;
run;



*���� 5 6 PROC TRANSPOSE��ARRAYʵ����ת��;
*===������Ŀ��Գɼ����ݼ�;
data wide;
input SID $  Programming  Stats  English;  
datalines;
S01  98 100 80
S02  84 98 94
S03  89  92 88
;
run;


*===proc transposeת��;
proc transpose data= wide out=long(rename=(_name_=Coursename col1=Score));
   var Programming  Stats  English; /*��Ҫת�õı���*/
   by  SID;                         /*�ظ��ķ������*/
run;


*===doѭ��+array;
data long(keep=SID Coursename Score);
    set wide;
    array scores{*} Programming  Stats  English;
	do i=1 to dim(scores);
	  Coursename=vname(scores{i});
	  Score=scores{i};
	  output;
	end;
run;
  

*���� 5 7 PROC TRANSPOSE��ARRAYʵ����ת��;

*====��ԭ���;
*===proc transposeת��;
proc transpose data=long out=Rewide(drop=_name_);
	var Score;       /*��Ҫת�õı���*/
	by SID;
	id Coursename; /*��ʾ��ת�к���ֶ���*/
run;

*===doѭ��+array;
data Rewide(keep=SID Programming  Stats  English);
format SID  Programming  Stats  English;
  array Course{3} Programming  Stats  English;
  do i=1 to 3;
     set long;
	 Course{i}=Score;
  end;
run;




*���� 5-8 һ��һ����;

*�����������ݼ�;
data class1(keep=name sex)  class2(keep=age height weight);
	set sashelp.class ;
	output class1;
    output class2;
run;
   
*===һ��һ����;
data class;
	set class1;
	set class2;
run;


*���� 5-9 һ��һ����;
*===һ��һ����;
data class;
  merge class1 class2;
run;


*���� 5-10 Merge+by���ƥ�䲢�����ݼ�;
*===�����������ݼ�;
data class1(keep=name sex)  class2(keep=name age  height weight);
	set sashelp.class ;
	output class1;
    output class2;
run;

*===ƥ�䲢��;
proc sort data=class1;
	by name;
run;

proc sort data=class2;
	by name;
run;

data class;
	merge class1 class2;
    by name;
run;


*���� 5-11 Merge���ʵ�ָ�����������;
*===�����������ݼ�;
data class1(keep=name sex)  class2(keep=name age  height weight);
	set sashelp.class ;
	output class1;
    if _n_ in (1, 5, 10, 15) then output class2;
run;

data class2;
  set class2;
  if name="Janet" then name="Janey";
run;

*===����׼��;
proc sort data=class1;
	by name;
run;

proc sort data=class2;
	by name;
run;

data class_left;
	merge class1(in=ds1) class2(in=ds2);
    by name;
	if ds1; /*������*/
run;

data class_right;
	merge class1(in=ds1) class2(in=ds2);
    by name;
	if ds2; /*������*/
run;
 

data class_innner;
	merge class1(in=ds1) class2(in=ds2);
    by name;
	if ds1 and ds2; /*������*/
run;

data class_full;
	merge class1(in=ds1) class2(in=ds2);
    by name;
	if ds1 or ds2; /*ȫ����*/
run;




*���� 5-12 PROC SQLʵ�ָ�������;

*===������;
proc sql;
	create table class_left as
	select a.*,b.*
	from class1 as a left join class2 as b
	on a.name=b.name;
quit;

*===������;
proc sql;
	create table class_right as
	select a.*,b.*
	from class1 as a right join class2 as b
	on a.name=b.name;
quit;

*===������;
proc sql;
	create table class_inner as
	select a.*,b.*
	from class1 as a inner join class2 as b
	on a.name=b.name;
quit;


*===ȫ����;
proc sql;
	create table class_full as
	select a.*,b.*
	from class1 as a full join class2 as b
	on a.name=b.name;
quit;



*=���� 5 13 Set��䴮�����ݼ�;

*===�������Լ�;

**===�����������ݼ�;
data class1  class2   class3(keep=name sex)  class4(keep=name age  height weight);
	set sashelp.class ;
    if _n_<=10 then do;
      output class1;
	  output class3;
	end;
	else do;
      output class2;
	  output class4;
	end;
run;

*===Set��䴮��ʵ��1;
data class;
  	set class1 class2;
run;

*===Set��䴮��ʵ��2;
data class;
  set class3 class4;
run;



*���� 5-14 proc append�������ݼ�;
*===����ʵ��1;
proc append base=class1 data=class2;
run;

*===����ʵ��2;
proc append base=class3 data=class4 force;
run;
 


*���� 5-15 proc sql�������ݼ�;
proc sql;
	create table class as
	select *
		from class1
	union
	select *
    	from class2;
quit;

*===�������еı���;
proc sql;
	create table class as
	select *
		from class3
	outer union 
	select *
    	from class4;
quit;

*===ֻ������ͬ�ı���;
proc sql;
	create table class as
	select *
		from class3
	union corr
	select *
    	from class4;
quit;





*=���� 5-16 Proc SQL������;

*===�����������ݼ�;
data class1(keep=name sex)  class2(keep=name age  height weight);
	set sashelp.class ;
	output class1;
    if _n_ in (1, 5, 10, 15) then output class2;
run;

data class2;
  set class2;
  if name="Janet" then name="Janey";
run;


*===������;
proc sql;
	create table class_left as
	select a.*,b.*
	from class1 as a left join class2 as b
	on a.name=b.name;
quit;



*���� 5-17 Proc SQL������;
*===������;
proc sql;
	create table class_right as
	select a.*,b.*
	from class1 as a right join class2 as b
	on a.name=b.name;
quit;


*���� 5-18 Proc SQL������;
*===������;
*===ʵ��1;
proc sql;
	create table class_inner as
	select a.*,b.*
	from class1 as a inner join class2 as b
	on a.name=b.name;
quit;

*===ʵ��2;
proc sql;
	create table class_inner as
	select a.*,b.*
	from class1 as a , class2 as b
	where a.name=b.name;
quit;


*���� 5-19 Proc SQLȫ����;
*===ȫ����;
proc sql;
	create table class_full as
	select a.*,b.*
	from class1 as a full join class2 as b
	on a.name=b.name;
quit;




*���� 5-20 Proc SQL Except����;

*===������������;
data class1  class2   class3(keep=name sex)  class4(keep=name age  height weight);
	set sashelp.class ;
    output class1;
    output class3;	
	if _n_<=10 then do;
      output class2;
	  output class4;
	end;
run;

data class2;
  set class2;
  if name="Janet" then name="Janey";
run;


*===Except;
proc sql;
	create table class as
	select *
		from class1
	except 
    select *
		from class2;
quit;


*���� 5-21 Proc SQL Union����;

*===Union;
proc sql;
	create table class as
	select *
		from class1
	union 
    select *
		from class2;
quit;



*���� 5-22 Proc SQL Intersect����;
*===Intersect;
proc sql;
	create table class as
	select *
		from class1
	intersect 
    select *
		from class2;
quit;



*���� 5-23 Proc SQL Outer Union����;
*===Outer Union;
proc sql;
	create table class as
	select *
		from class3
	outer union 
    select *
		from class4;
quit;




*���� 5 24 ���������ֵ��;
ods output Position=codebook;
proc contents data=sashelp.cars order=varnum ;
run;

proc export data=codebook
             outfile="d:\03-Publishing\B01-Book\01 SAS�������\02 Data\codeBook.csv"
			 dbms=csv replace;
run;



*���� 5-25 Proc Datasets��ȡ������Ϣ;

*===�����������ݼ�;
data class;
 set sashelp.class;
run;

*===��ȡ������Ϣ;
proc datasets lib=work;
	contents data=class;
quit;



*���� 5-26  Proc Datasets �޸����ݼ���ǩ��Ȩ��;
*===�޸�������Ϣ;
proc datasets lib=work;
	modify class(label="ѧ���������ݼ�"  read=r2017);
quit;


proc datasets lib=work;
	contents data=class;
quit;




*���� 5-27 Proc Datasets ѡ�񣬿�����������ɾ�����ݼ�;

proc datasets ;
	 copy  in=sashelp out=work; /*���ݼ����忽��*/
	 select class;	            /*ѡ�����ݼ�*/
quit;

proc datasets lib=work;
	change class=student;    /*���ݼ�����*/
quit;

proc datasets lib=work;
	delete student;        /*ɾ�����ݼ�*/
quit;



*���� 5-28 ���� 05 25 Proc Datasets ������ɾ�����ݼ�;

proc datasets lib=work kill memtype=data; /*ɾ��Work�����������ݼ�*/
run;

proc datasets lib=work;
	save class; /*������class*/
run; 



*���� 5-29 Proc Datasets��ȡ������Ϣ;
*===�޸�������Ϣ;
proc datasets lib=work;
	contents data=class;
quit;




*���� 5-30 Proc Datasets�޸ı�����Ϣ;
proc datasets lib=work;
	modify class;
	  format height weight 3.0;
	  rename sex=gender;
	  label name="����"
	        gender="�Ա�";
quit;

proc datasets lib=work;
	contents data=class varnum;
quit;



*===SAS�����ֵ�;

  proc sql;
    title "Dictionary�������еı�";
    select  unique memname,memlabel
 	from dictionary.dictionaries;
   quit;   


proc contents data=sashelp._all_ memtype=view;
run;


*���� 5-31 Proc SQL�鿴�����ֵ��Ľṹ;
proc sql; 
   describe table dictionary.columns;
quit;



*���� 5 32 ��ȡSASHELP�����������ݼ���Ϣ;
*===���ֵ���л�ȡ;
proc sql;
	create table desds as
	select memname, nobs ,nvar
	from dictionary.tables
	where libname="SASHELP" and memtype="DATA";
quit;

*===����ͼ�л�ȡ;
proc sql;
	create table desds as
	select memname, nobs ,nvar
	from sashelp.vtable
	where libname="SASHELP" and memtype="DATA";
quit;



*���� 5-33 ��ȡ���ݼ�Cars�����б�����Ϣ;

*===���ֵ���л�ȡ;
proc sql;
	create table varlist as
	select name, type ,length,label
	from dictionary.columns
	where libname="SASHELP" and memname="CARS";
quit;

*===����ͼ�л�ȡ;
proc sql;
	create table varlist as
	select name, type ,length, label
	from sashelp.vcolumn
	where libname="SASHELP" and memname="CARS";
quit;


