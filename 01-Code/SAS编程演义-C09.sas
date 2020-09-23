*==============================================================================================*
Book: SAS�������/Romance of SAS Programming
Author:�Ⱥ���/Hongqiu Gu
Contact:guhongqiu(at)yeah(dot)net
Book:https://item.jd.com/12210370.html#crumb-wrap
Title: �ھ��� ׾�в��ɻ���ɣ�ͳ�Ʊ��
*==============================================================================================*;


*���� 9 1 ͳ�ƻ���̻���ͳ�Ʊ��;
ods tagsets.rtf file="table1.rtf" style=journal3a;
proc freq data=sashelp.heart;
	table bp_status*sex/nopercent norow;
run;
ods tagsets.rtf close;

ods tagsets.rtf file="table2.rtf" style=journal3a;
proc means data=sashelp.heart   mean std maxdec=2 ;
	class sex;
	var height ;
run;
ods tagsets.rtf close;


ods tagsets.rtf file="table3.rtf" style=journal3a;
proc summary data=sashelp.heart mean std maxdec=2 print;
	class sex;
	var  height;
run;
ods tagsets.rtf close;




*���� 9-2 Proc tabulate����ͳ�Ʊ��;

ods tagsets.rtf file="table4.rtf" style=journal3a;
 title " Table 1. Blood Pressure and Height by Sex";
proc tabulate data=sashelp.heart;
	class sex bp_status;
	var  height;
	table sex,bp_status *(n rowpctn) height*(mean std);
run;
ods tagsets.rtf close;


ods tagsets.rtf file="table5.rtf" style=journal3a;
 title " Table 1. Blood Pressure and Height by Sex";
proc tabulate data=sashelp.heart;
	class sex bp_status;
	var  height;
	table bp_status *(n colpctn) height*(mean std),sex;
run;
ods tagsets.rtf close;


*���� 9-3  Proc report����ͳ�Ʊ��;

ods tagsets.rtf file="table6.rtf" style=journal3a;
ods escapechar='^';
 title "Table 1. Blood Pressure and Height by Sex";
proc report data=sashelp.heart nowd;
	column sex bp_status,("^R'\brdrb\brdrs'" n pct)  height,("^R'\brdrb\brdrs'" mean std);
	define sex/group;
	define bp_status/across ;
	define pct/computed format=5.2;
	define height/analysis format=5.2;

 compute before sex;
	  cntall=sum(_c2_,_c4_,_c6_);
  endcomp;

  compute pct;
	  _c3_=_c2_/cntall;
	  _c5_=_c4_/cntall;
	  _c7_=_c6_/cntall;
  endcomp;
run;
ods tagsets.rtf close;






*���� 9 4 SASͳ���Ʊ�����ʵ��;

*==1.Ѫѹ״̬��������;

*==1.1 ��ȡƵ���ٷֱ�;
proc freq  data=sashelp.heart;
	table bp_status*sex/missing nopercent outpct out=desc1;
run;

data desc1;
 set desc1;
 length value $25;
 value = compress(put(count,6.)) || ' (' ||compress( put(pct_col,4.1))||')';
run;
 
*==1.2 ת��,�Ա���Ϊ��;
proc transpose data=desc1 out=desc1(drop=_name_) prefix=col;
	var value;
	by bp_status;
	id sex;
run;

*==1.3 ��ȡ��������Pֵ;
proc freq data=sashelp.heart;
	table bp_status*sex/norow nocol nopercent chisq;
    output out=pvalue1(keep=p_pchi rename=(p_pchi=pvalue)) pchi;
run;

*==1.4 �ϲ�������ǩ���������ݣ�Pֵ;
data dslabel1;
	  set pvalue1;
	  length label $ 85;
	  label = cats("^S={font_weight=bold}" , "Blood pressure status"); *RTF���룬�Ӵֱ�ǩ;
run;


data merge1(keep=label col: pvalue);
   set  dslabel1 desc1;
  if _n_ > 1 then label= "^{nbspace 6}" ||bp_status; *RTF���룬��������;
run;


*==2.�����������;

*==2.1 ��ȡ��������;
ods output summary=desc2;
proc means data=sashelp.heart mean std ;
	class sex;
	var height;
run;

data desc2(keep=sex meanstd);
 set desc2;
 meanstd = cats(put(height_mean,12.1), "��", put(height_stddev,12.1));
run;

*==2.2 ת��,�Ա���Ϊ��; 
proc transpose data=desc2 out=desc2 prefix=col;
	var meanstd;
	id sex;
run;


*==2.3 �жϷ�������,��ȡt����Pֵ;
ods output equality=eq1 ttests=tt1; 
proc ttest data=sashelp.heart plots=none ;
	class sex;
	var height;
run;

data pvalue2(keep=Probt rename=(Probt=Pvalue));
  retain equV;
  set eq1 tt1;
  if ProbF<0.05 then equV=0;
  else equV=1;  
  if (equV=1 and variances="Equal") or (equV=0 and variances="Unequal");
run;

*==2.4 �ϲ�������ǩ���������ݣ�Pֵ;
data merge2(keep=label col: pvalue);
length label $ 85;
  merge desc2 pvalue2;
  label=cats("^S={font_weight=bold}" , "Height (in)"); *RTF���룬�Ӵֱ�ǩ;
run;


*==3�ϲ�����;

data dsreport;
  set merge:;
run;


*==4.Report���;

options nodate nonumber missing = ' ';
ods tagsets.rtf file="table6.rtf" style=journal3a;
ods escapechar='^';
 title "Table 1. Blood Pressure and Height by Sex";
proc report data=dsreport nowd;
	column label colFemale colmale pvalue;
	define label/display " Variables";
	define colfemale/display  "Female" right;
	define colmale /display "Male" right;
	define pvalue/analysis "P Value" f = pvalue6.4;
run;
footnote1 j=center height=10pt "^{nbspace}Note: This is a demo by Hongqiu Gu";
ods tagsets.rtf close;




*���� 9-5 %ggbaseline2�Ʊ�չʾ1;
%ggBaseline2(
data=sashelp.heart, 
var=bp_status|CHISQ|Blood pressure stuatus\
    height|ttest|Height(in),
grp=sex,
grplabel=Female|Male,  
file=d:\t1, 
title=Table 1. Blood Pressure and Height by Sex
);


*���� 9-5 %ggbaseline2�Ʊ�չʾ1;
%ggBaseline2(
data=sashelp.heart, 
var=bp_status|CHISQ|Blood pressure stuatus\
    height|ttest|Height(in)\
    weight|ttest|Weight(lbs),
grp=sex,
grplabel=Female|Male,  
file=d:\t2, 
title=Table 1. Blood Pressure and Height by Sex
);
