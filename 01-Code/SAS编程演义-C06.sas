*==============================================================================================*
Book: SAS�������/Romance of SAS Programming
Author:�Ⱥ���/Hongqiu Gu
Contact:guhongqiu(at)yeah(dot)net
Book:https://item.jd.com/12210370.html#crumb-wrap
Title: ������ ����ɽ�������㣺��������
*==============================================================================================*;



*���� 6-1 SAS����ʵ��;

data _null_;
  x=100;
  y=log10(x);
  put x= y=;
 run;



 *���� 6-2 ����ʾ��;
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



*���� 6-3 �������ֵVS.�������ֵ;
 data _null_;
   array  ex{7} (95 93 92 99 98 85 94);
   *===���������ֵ;
   sum=0;
   cnt=0;
   do i=1 to 7;
   	sum=sum+ex{i};
	cnt=cnt+1;
   end;
   avg_force=sum/cnt;

   *===���������ֵ;
   avg_function=mean(of ex:);

   put  avg_force=;
   put  avg_function=;
  run;


  *���� 6-4 ���������� VS. ���� ����

 data _null_;
   array  ex1{7} (95 93 92 99 98 85 94);
   array  ex2{7} (95 93 92 99 98 85 94);
   *===��������-ѡ������;
  do i=1 to dim(ex1)-1;
   min=i;
	  do j=i+1  to dim(ex1);
	      if (ex1[min]>ex1[j])  then  do; 
			min=j;
			tmp=ex1[i]; 
	        ex1[i]=ex1[min];
	        ex1[min]=tmp;
	      end;
	   end;
  end;
 *===��������;
  call sortn(of ex2:);

 *==�������Ƚ�;
 do i=1 to dim(ex1);
    put "ѡ�����򷨣�"ex1[i]  "��������" ex2[i] ;
 end;
 run;





*���� 6-5 �����﷨����;

  data _null_;
   array  ex{7} (95 93 92 99 98 85 94);
 
   *===������������;
   avg_function1=mean(ex1, ex2, ex3, ex4, ex5, ex6, ex7);
   *===�����嵥;
   avg_function2=mean(of ex1 ex2 ex3 ex4 ex5 ex6 ex7);
   avg_function3=mean(of ex1-ex7);
   avg_function4=mean(of ex:);
   *===������;
   avg_function5=mean(of ex[*]);
   put (avg_function1  avg_function2 avg_function3 avg_function4 avg_function5) (=);
  run;


  *���� 6-6  CALL�����﷨����;

  data tmp;
   array  str{3} $20 ("ͳ��˼ά","SAS�������","����������ͼ�����");
   length result1-result5 $50;
   *===������������;
   call catx("-",result1,str1,str2,str3);
   *===�����嵥;
   call catx("-",result2,of str1 str2 str3);
   call catx("-",result3,of str1-str3);
   call catx("-",result4,of str:);
   *===������;
   call catx("-",result5,of str[*]);;
   put (result1  result2  result3  result4  result5) (=);
 run;
 


 *���� 6-7 PROC FCMP �Զ��庯��;
*===���庯��study_day;
 proc fcmp outlib=sasuser.funcs.trial;
           function study_day(intervention_date, event_date); 
	           n=event_date - intervention_date;
	           if n >= 0 then
	            n=n + 1;
	            return(n);
		    endsub;
run;

*===ʹ�ú���studay_day;
options cmplib=sasuser.funcs;
data _null_;
   start='15Feb2010'd;
   today='27Mar2010'd;
   sd=study_day(start, today);  
put sd=;
run;
