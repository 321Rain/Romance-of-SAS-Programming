*==============================================================================================*
Book: SAS�������/Romance of SAS Programming
Author:�Ⱥ���/Hongqiu Gu
Contact:guhongqiu(at)yeah(dot)net
Book:https://item.jd.com/12210370.html#crumb-wrap
Title: ������ ̦����������ࣺ��ȡ����
*==============================================================================================*;




*���� 03-1 libname������db2�����ļ�;

libname  mydb2  db2 user=guhq password="88guhq88" datasrc=datadb;

proc export data=sashelp.class
             outfile="d:\03-Publishing\B01-Book\01 SAS�������\02 Data\Raw\myspssdata.sav"
			 dbms=spss replace;
run;


*���� 03-2 ����SPSS�ļ�;

*==IMPORT����;
proc import out=mysasdata 
             datafile="D:\03-Publishing\B01-Book\01 SAS�������\02 Data\Raw\myspssdata.sav" ;
run;


*==LIBNAME���;
libname  mysav spss "D:\03-Publishing\B01-Book\01 SAS�������\02 Data\Raw\myspssdata.sav";




*���� 3-3 ��������� EXCEL �ļ�;

*===����EXCEL�ļ�;
filename myxlsx "d:\03-Publishing\B01-Book\01 SAS�������\02 Data\Raw\class.xlsx";

libname  myexcel xlsx "d:\03-Publishing\B01-Book\01 SAS�������\02 Data\Raw\class.xlsx";

proc import out=myxls datafile=myexcel
             dbms=excel replace;
run;


*���� 3-4 �����ض��������ݵ� EXCEL �ļ�;
*===����ָ����Χ��EXCEL�ļ�;
proc import out=myxls datafile=myexcel
             dbms=excel replace;
			 range="'sheet1$A1:E20'n";  /*����sheet1��A1~E20���������*/
			 getnames=yes;
run;

*===����ָ����ֹ��;
proc import out=myxls datafile=myexcel
             dbms=excel replace;
			 dbdsopts="firstobs=3  obs=18"; /*����sheet1��3~8�����������*/
			 getnames=yes;
run;



*���� 3-5 PROC IMPORT ���� CSV �ļ�;
filename mycsv "D:\03 Writting\01 SAS�������\02 Data\Raw\class.csv";
proc import out=tmp datafile=mycsv
			 dbms=csv replace;
			 getnames=yes;
			 guessingrows=20;
			 datarow=2;
run;


*���� 3-6 PROC IMPORT �����Ʊ���Ϳո�ָ����ı�;
*===�����ļ�;
filename mytxttab "D:\03 Writting\01 SAS�������\02 Data\Raw\class_tab.txt";
filename mytxtblk "D:\03 Writting\01 SAS�������\02 Data\Raw\class_blk.txt";

*==�����Ʊ���ָ��ı�;
proc import out=tmp datafile=mytxttab
			dbms=dlm replace;
			delimiter='09'x;
			getnames=yes;
run;

*==����ո�ָ��ı�;
proc import out=tmp datafile=mytxtblk
				dbms=dlm replace;
				delimiter='20'x;
				getnames=yes;
run;



*���� 3-7 INPUT ��������ĸ������;
data trial;
  do group="T","C";
  	do Survive="Yes","No";
	  input freqs@@;  /*��Dataline��������*/
	 output;           /*д�����ݵ����ݼ�*/   
	end;
 end;
datalines;
95 5 90 10
;
run;


*����ĸ�����;
proc freq data=trial;
	table group*survive/nopercent norow nocol ;
	weight freqs;
run;


*���� 3-8 INPUT �б����ʽ����;

*==�������ϲ�����;
data tmp;
  input name $  gender$  age location $;
  datalines;
GHQ M 30 Beijing
TJSW M 1 Beijing
  ;
run;

*===�ַ�name���������ַ����ȹ�8;
data tmp;
  input name :$13.  gender$  age location $; /* :��ʾ�����ո���ߵ�13�У�����name���������� */
  datalines;
GHQ M 30 Beijing
GuHongqiu M 30 Beijing
StatsThinking M 1 Beijing
  ;
run;

*===�ַ�name���пո�;
data tmp;
  input name & $  gender$  age location $; /* &����һ���ո񲻻���Ϊ�˱�������������������� */
  datalines ;
HQ Gu  M 30 Beijing
TJ SW  M 1 Beijing
  ;
run;

*===�ַ�name���пո����ַ����ȹ�8;
data tmp;
  input name : & $10. gender$  age location $;
  datalines ;
  HQ Gu  M 30  Beijing
  Hongqiu Gu  M 30  Beijing
  ;
run;

*===�����ָ�������,�ַ�affiliation���зָ���;
data tmp;
  infile datalines delimiter=',' dsd;
  input name $  gender$  age location $ affiliation $12.;
  datalines ;
  HQ Gu,M,30,Beijing,"PUMC,CAMS"
  Hongqiu Gu,M,30,Beijing,"PUMC,CAMS"
  ;
run;



*���� 3-9 INPUT����ж��밸��;

*===�ж���;
data tmp;
  input name $ 1-10  gender $ 12  age 14-15 location $ 17-23;
  datalines ;
HQ Gu      M 30 Beijing
Hongqiu Gu M 30 Beijing
  ;
run;


*���� 3-10 INPUT����ʽ���밸��;

*===��ʽ����; 
*===gender��Ȼ����1�У���������ʱҪ����������һ���ո�age,locaiotn����;
data tmp;
  input name : & $10. gender$2.  age 3.  location $8. fee comma6. ;
  datalines ;
  HQ Gu  M 30 Beijing 12,345
  Hongqiu Gu  M 30 Beijing 54,321
  ;
run;


*���� 3 11 INPUT����������밸��;
*===����ʽ;
data tmp;
  input name= $  gender= $  age= location= $;
  datalines;
name=GHQ gender=M age=30  location=Beijing
name=TJSW gender=M age=1 location=Beijing
;
run;


*���� 3-12 INPUT������ʽ���밸��;

*===�ۺϰ���;
data tmp;
  input name : & $10. gender $  age location $ 17-24 +1 fee comma6. ;
  datalines ;
HQ Gu       M 30 Beijing 12,345
Hongqiu Gu  M 30 Beijing 54,321
;
run;



*���� 3-13 PROC EXPORT����ʵ��;

*===����TXT�ļ�;
proc export data=sashelp.class
             outfile="D:\03-Publishing\B01-Book\01 SAS�������\02 Data\Raw\class_tab.txt"
			 dbms=dlm replace;
			 delimiter='09'x;
run;


proc export data=sashelp.class
             outfile="D:\03-Publishing\B01-Book\01 SAS�������\02 Data\Raw\class_blk.txt"
			 dbms=dlm replace;
			 delimiter='20'x;
run;


*===����ΪEXCEL�ļ�;
proc export data=sashelp.class
             outfile="D:\03 Writting\01 SAS�������\02 Data\Raw\class.xlsx"
			 dbms=excel replace;
run;

*===����ΪCSV�ļ�;
proc export data=sashelp.class
             outfile="D:\03 Writting\01 SAS�������\02 Data\Raw\class.csv"
			 dbms=csv replace;
run;

