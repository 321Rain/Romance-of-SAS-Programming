*==============================================================================================*
Book: SAS�������/Romance of SAS Programming
Author:�Ⱥ���/Hongqiu Gu
Contact:guhongqiu(at)yeah(dot)net
Book:https://item.jd.com/12210370.html#crumb-wrap
Title: ������ ������ȥ���ݺ᣺�����۲�
*==============================================================================================*;


*���� 4-1  DATA�������÷�ʾ��;
*===��͵����DATA���;
data ; /*��ָ�����ݼ����Զ�����Ϊdata1,data2,...,dataN*/
	set sashelp.class;
run;

*===һ��ͬʱ���ɶ�����ݼ�;
data class1 class2;
	set sashelp.class;
run;

*===���������ݼ�;
data _null_;
	set sashelp.class;
run;


data tmp/debug;
  put _aLL_;
  set sashelp.class(drop=age);
  
run;




*���� 4-2  PROC SQL�������ݼ�;

*===����һ����SAShelp.classһ�������ݼ�;
proc sql;
	create table tmp as
	select *
	from sashelp.class;
quit;

*==����һ����SAShelp.class�ṹһ���ģ����κμ�¼�����ݼ�;
proc sql;
	create table tmp 
    like sashelp.class;
quit;


*===������Ҵ������ݼ�;
proc sql;
  create table tmp 
   (name char(15),
    gender char(1),
    age  num,
    locaiton  char(10));  /*���������������*/
 insert into tmp
   values('Hongqiu Gu', 'M',30,'Beijing')
   values('StatsThinking', 'M',1,'Beijing'); /*�����¼*/
select *
from tmp;
quit;
 



*���� 4-3 ���̲������ѡ�����������ݼ�;

*===���������ݼ�sortedclss�Ѿ���age����;
proc sort data=sashelp.class out=sortedclass;
	by age;
run;

*===output������������ݼ���ȡͳ�ƹ��̵�ͳ����;
proc means data=sashelp.class;
    var height weight;
	output out=outstat mean(height weight)= std(height weight)= /autoname;
run;


*===outѡ�����������ݼ���ȡ�ĸ��Ƶ���Ͱٷֱ�;
proc freq data=sashelp.bmt;
	table group*status/out=outfreq;
run;


*���� 4-4 ODS OUTPUT���ץȡK-M��������;

ods output SurvivalPlot=SurvPlotData;
proc lifetest data=sashelp.bmt;
	time t*status(0);
	strata group;
run;



*���� 4-5 ODS TRACE ON���׷�ټ�ع��̲�����;
*===ods trace ���׷��;
ods trace on;
ods output SurvivalPlot=SurvPlotData;
proc lifetest data=sashelp.bmt;
	time t*status(0);
	strata group;
run;
ods trace off;



*���� 4-6 IF��WHERE���ɸѡ�۲�;

*===��һ�׶Σ�ͨ��WHEREѡ���޶��������ݼ�;
data tmp;
	set sashlep.class(where=(sex="F"));
run;

*===�ڶ��׶�:ͨ��IF����WHERE���;
*===ͨ��where���;
data tmp;
	set sashlep.class;
	where sex="F";
run;

*===ͨ�����Ӽ�IF���;
data tmp;
	set sashlep.class;
	if sex="F";
run;

*===�����׶Σ�ͨ��WHEREѡ���޶�������ݼ�;
data tmp(where=(sex="F"));
	set sashlep.class;
run;



*���� 4-7 WHEREѡ��ɸѡ�۲�;
*===WHEREѡ��ɸѡ�۲�;
data want(where=(not missing(id)));
	set raw1(where=��age between  20 and 30��)  raw2(where=��sex="F"��);
run;



*���� 4 8 RENAME��KEEP��DROP;

*===��һ�׶Σ��������ݼ�ѡ��;
data want;
  set sashelp.class(drop=age rename=(sex=gender));
run;

*===�ڶ��׶Σ����;
data want;
  set sashelp.class;
  drop age;
  rename sex=gender;
run;

*===�����׶Σ�������ݼ�ѡ��;
data want(drop=age rename=(sex=gender));
  set sashelp.class;
run;



*���� 4-9 һ�������ӵĴ������;

*==��һ�׶Σ��������ݼ�֮���������ʾ;
data want;
  set sashelp.class(where=(sex="F")  rename=(sex=gender)keep=name gender);
run;

*==�ڶ��׶Σ���̴���ֵ���������ʾ;
data want;
  set sashelp.class;
  rename sex=gender;
  keep   name gender ;
  where gender="F";
run;

*==�����׶Σ�������ݼ�֮���������ʾ;
data want(where=(sex="F") rename=(sex=gender) keep=name gender);
  set sashelp.class;
run;



*���� 4-10 һ�������ӵĴ������ľ���;

*==��һ�׶Σ��������ݼ�֮��ȷ������ʾ;
data want;
  set sashelp.class(where=(gender="F") rename=(sex=gender) keep=name sex);
run;

*==�ڶ��׶Σ���̽׶�֮��ȷ������ʾ;
data want;
  set sashelp.class;
  rename sex=gender;
  keep   name sex ;
  where sex="F";
run;

*==�����׶Σ�������ݼ�֮��ȷ������ʾ;
data want( where=(gender="F")  rename=(sex=gender) keep=name sex);
  set sashelp.class;
run;


*���� 4-11  PROC SQLʵ�ֱ�����۲��ɸѡ;

proc sql;
	create table want as
	select name, sex as gender, height,weight
	from sashelp.class
	where sex="F";
quit;




*���� 4-11  PROC SQLʵ�ֱ�����۲��ɸѡ;
*===������ֵ�����±���;
*===��������ָ��BMI������BMI�ж�����״̬;
*===BMI=���أ�Kg��/ ��ߣ�m����ƽ��;
data Obese;
 	set sashelp.class;
	BMI= weight*0.4536/(height*0.0254)**2;  
	if  BMI<18.5 then  Status="Underweight";
	else if BMI<25 then Status="Normal";
	else if BMI<30 then Status="Overweight";
	else Status="Obese";
run;

proc print data=obese;
run;



*���� 4-13 ѭ�����������ֵ;
data hyp;
  *===��������;
  array sbp{7} sbp1-sbp7 (163 104 167 131 155 128 154);
  array hyp{7} hyp1-hyp7;
  *==-ѭ����ֵ;
  do i=1 to 7;
    if sbp{i}>=140 then hyp{i}=1;
	else hyp{i}=0;
  end;
run;

proc print data=hyp;
run;



*���� 4-14 LENGTH��������±���;
*===LENGTH��������±���;
*===��������ָ��BMI������BMI�ж�����״̬;
*===BMI=���أ�Kg��/ ��ߣ�m����ƽ��;
data Obese;
    length  status $ 15; /*ָ���ַ�����*/
 	set sashelp.class;
	BMI= weight*0.4536/(height*0.0254)**2;  
	if  BMI<18.5 then  Status="Underweight";
	else if BMI<25 then Status="Normal";
	else if BMI<30 then Status="Overweight";
	else Status="Obese";
run;

proc print data=obese;
run;



*���� 4-15 �ñ�̷�����ȡ���ݼ��۲���;

*===PROC SQL��ȡ�۲�;
proc sql;
  select count(name) as N
  from sashelp.class;
quit;

*===_N_��ȡ�۲���;
data _null_;
  set sashelp.class end=last;
if last then put _n_;
run;

*===���������ȡ�۲���;
 data _null_;
   if 0 then  set sashelp.class nobs=n;
   put _all_;
run;



*���� 4-17 ���ñ����������ʱ��������������;
*==�������;
 data sample;
  do i=1 to 5; /*�����5���۲�*/
    PickNo=ceil(ranuni(123)*N); /*��ȡһ��λ��1-N������Ĺ۲��*/
   set sashelp.class nobs=N point=PickNo; /*��ȡ�ܹ۲���N,�����ѡ�Ĺ۲��PickNo*/
   output; /*�ѳ��еĹ۲�����������ݼ�*/
  end;
  stop; /*����ʹ����Point���۲��Ƿ�˳���ȡ����Ҫ��STOP���ǿ��ֹͣ*/
run;

proc print data=sample;
run;



*���� 4-18 CALL���������±���;
*===CALL ����;
data rand;
 seed=123;
do i=1 to 10;
 x=rannor(seed); /*�ú�����ֵ*/
 call rannor(seed,y); /*��CALL����*/
 output;
end;
run;

proc print data=rand;
run;



*���� 4-19 �������͵�ת��;
data ConvertVar;
  d_n=123;
  d_c="123";

  *==������ת�ַ���;
  d1_n2c=put(d_n,best.);
  d2_n2c=put(d_n,3.) ;

  *==�ַ���ת������;
  d3_c2n=input(d_c,best.);
  d4_c2n=input(d_c,3.);
run;

*===�鿴���;
proc contents data=ConvertVar;
run;



*���� 4-20 IF-ELSE�����������;

data Obese;
    length  status $ 15; /*ָ���ַ�����*/
 	set sashelp.class;
	BMI= weight*0.4536/(height*0.0254)**2;  
	if  BMI<18.5 then  Status="Underweight";
	else if BMI<25 then Status="Normal";
	else if BMI<30 then Status="Overweight";
	else Status="Obese";
run;


*���� 4-21 SELECT-WHEN �����������;
data obese;
	length  status $ 15; /*ָ���ַ�����*/
	 set sashelp.class;
	 BMI= weight*0.4536/(height*0.0254)**2;  
	select ;
		when(BMI<18.5) Status="Underweight";
		when(BMI<25) Status="Normal";
		when(BMI<30) Status="Overweight";
		other Status="Obese";
	end;
run;


*���� 4-22 PROC SELECT-CASE�����������;

proc sql;
	create table obese as
	select *,  weight*0.4536/(height*0.0254)**2 as BMI,
	case when(calculated BMI<18.5 ) then "Underweight"
	     when(calculated BMI<25) then "Normal"
		 when(calculated BMI<30) then "Overweight"
		 else "Obese"
	end as Status
	from sashelp.class;
quit;


*���� 4-23 �Զ����ʽ�����������;

proc format;
  value obefmt low-18.5="Underweight"
               18.5-<25="Normal"
			   25-<30="Overweight"
			   30-high="Obese";
run;

data obese;
	length  status $ 15;
	 set sashelp.class;
	 BMI= weight*0.4536/(height*0.0254)**2;
	 Status=put(BMI,obefmt.);
run;

*���� 4-24 ����ȱʧ����;

*===����ʾ������;
data demo;
  id="S01";   name="StatsThinking";gender="";  age=2;Location="BJ";output; 
  id="";   name="ͳ��˼ά";gender="";  age=2;Location="BJ";output;
  id="S03"; name="Hongqiu Gu";gender="M";age=.;Location="";output;
run;

*===����ȱʧ����;
data demo(drop=n c);
  set demo;
  length mvarlist $ 300;
  array num{*} _numeric_;  /*�������������飬�������������ͱ���*/
  array char{*} _character_; /*�����ַ������飬���������ַ��ͱ���*/

  do n=1 to dim(num);
   	if missing(num{n}) then mvarlist=catx("," ,mvarlist,vname(num{n})); /*�����ͱ���ȱʧ�嵥*/
  end;

  do c=1 to dim(char);
   	if missing(char{c}) then mvarlist=catx(",", mvarlist,vname(char{c})); /*�ַ��ͱ���ȱʧ�嵥*/
  end;

run;

proc print data=demo;
run;




*���� 4-25 DATA���ۻ�������ֵ;

*====�����ۼ�;
*===�����������ݼ�;
  data class;
    set sashelp.class;
  run;

*==���ۼӵ�Ŀǰ������ƽ������;
data want;
  set class end=last;
  cum_weight+weight;  /*�ۼ����ش洢������cum_weight*/
  cnt_weight+1;      /*�ۼӼ����洢������cum_weight*/
  avg_weight=cum_weight/cnt_weight; /*���ۼӵ�Ŀǰ������ƽ������*/
run;


*���� 4-26  Retain�͸�ֵ������ֵ;
*==���ۼӵ�Ŀǰ������ƽ������;
data want;
  set class end=last;
  retain cum_weight cnt_weight   (0 0 );
  cum_weight=cum_weight+weight ; 
  cnt_weight=cnt_weight+1;      
  avg_weight=cum_weight/cnt_weight; 
run;



*���� 4-27 �����ۼ�;
*===����ƽ������;
proc sort data=class;
	by sex;
run;

data want;
  set class end=last;
  by sex;
  if first.sex then do;
   cum_weight=0;
   cnt_weight=0;
  end;

  cum_weight+weight;
  cnt_weight+1;

  *===ֻ���ÿ�����һ��;
  if last.sex then  do;
    avg_weight=cum_weight/cnt_weight;
	output;
  end;
run;



*���� 4-28 BY��������FIRST.VAR ��LAST.VAR;
data want;
  set class;
  by sex;
  put (_n_  name  sex  first.sex  last.sex) (=);
run;


*���� 4-29 PROC SQL ʵ���������;

*===PROC SQL;
*===PROC SQLʵ�������ƽ������;
proc sql;
	select sex, sum(weight) as cum_weight, count(weight) as cnt_weight, avg(weight) as avg_weight
	from sashelp.class
	group by sex;
quit;


*���� 4-30 PROC MEANSʵ���������;
proc means data=sashelp.class sum n mean;
   var weight;
   class sex;
run;



*���� 4-31 LAG��DIF��������ȡ��;
*===����ȡ��;
data want;
  set sashelp.class;
  *===ǰ��������˭;
  pre1name=lag1(name);
  pre2name=lag2(name);
  pre3name=lag3(name);
  *===��߲����;
  dif1height=dif1(height);
  dif2height=dif2(height);
  dif3height=dif3(height);
run;

proc print;
run;




