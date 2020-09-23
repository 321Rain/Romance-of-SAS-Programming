*==============================================================================================*
Book: SAS�������/Romance of SAS Programming
Author:�Ⱥ���/Hongqiu Gu
Contact:guhongqiu(at)yeah(dot)net
Book:https://item.jd.com/12210370.html#crumb-wrap
Title: ��һ�� ������ֻ���������ʼSAS
*==============================================================================================*;


*���� 01-1 �鿴SAS��װ����ɵ�ģ��;
*===��*�ŵ�����ע����===;
*===�鿴SAS�Ѱ�װ��ģ��;
proc product_status;
run;

*===�鿴SAS����ɵ�ģ��;
proc setinit;
run;


*===�鿴������װ����;
%include  "D:\03_Publishig\SAS��̾�Ҫ\03 Code\Core\fusion_20390_1_sasinstallreporter4u.sas";
%SASinStallReporter;




*���� 01-2 ��ȡSAS�汾��;
*===�鿴�汾��;
%put SAS �汾�ţ� &SYSVER;
%put SAS �汾�ţ�������&SYSVLONG;



*���� 01-3 �汾�ŷ�����ʷ;
data Releases;
	format Date DATE7.;
	input Category $13. Release $9. Date DATE9. StatRelease $5.;
datalines;
Ancient      8.0      01Nov1999 
Ancient      8.1      01Jul2000 
Ancient      8.2      01Mar2001 
Ancient      9.0      01Oct2002 
Ancient      9.1      01Dec2003 
Ancient      9.1.3    01Aug2004 
Ancient      9.2      01Mar2008 9.2
Old          9.2m2    01Apr2010 9.22
Old          9.3      12Jul2011 9.3
Old          9.3m2    29Aug2012 12.1
Recent       9.4      10Jul2013 12.3
Recent       9.4m1    15Dec2013 13.1
Recent       9.4m2    05Aug2014 13.2
Recent       9.4m3    14Jul2015 14.1
Recent       9.4m4    16Nov2016 14.2
;
 
Proc format;
 value $ vfmt Ancient="����"
       Old="�ɰ�"
       Recent="���";
run;

title "SAS����ͷ�����Ʒ����Ҫ�汾����������";
proc sgplot data=Releases noautolegend ;
	styleattrs datacolors=(red yellow green);
	block x=date block=category / transparency = 0.8;
	scatter x=date y=release / datalabel=StatRelease datalabelpos=right
	                           markerattrs=(symbol=CircleFilled size=14);
	xaxis grid type=time offsetmin=0 label="���";
	yaxis type=discrete offsetmax=0.1 label="�汾";
	format category  $vfmt.;
run;
