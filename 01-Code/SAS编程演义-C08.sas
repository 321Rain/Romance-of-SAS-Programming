*==============================================================================================*
Book: SAS�������/Romance of SAS Programming
Author:�Ⱥ���/Hongqiu Gu
Contact:guhongqiu(at)yeah(dot)net
Book:https://item.jd.com/12210370.html#crumb-wrap
Title: �ڰ��� �⻨������˫�����ٱ��ͼ
*==============================================================================================*;


*===�Զ�����ʽ;
proc template;
  define style styles.ggStyle;
	parent = Styles.Htmlblue;

	*==�޸�ͼ�δ�С;
	style Graph from Graph/
	OutputWidth=14cm
	OutputHeight=10cm 
	BorderWidth=0;
   
	*==�޸�ͼ�����߿�;
	style  GraphBorderLines from GraphBorderLines /
	LineThickness=0px 
	LineStyle=1;

    *==�޸�ͼ�α߿�;
	style GraphOutlines from GraphOutlines/
	LineStyle=1
	LineThickness=0px;
    
	*==�޸�����ͼ�α߿�;
    style  GraphWalls from GraphWalls/
	FrameBorder=off
	LineThickness=0px 
	LineStyle=1; 
   end;
run;




proc template;                                                                
   define style Styles.ggplot2;                                              
      parent = styles.listing; 

	  style color_list from color_list
	     "Abstract colors used in graph styles" /
		 'bgA'   = cxffffff; 

      class GraphColors
         "Abstract colors used in graph styles" /
         'gwalls' =cxebebeb
		 'glegend'=cxebebeb
		 'ggrid'  =cxFFFFFF
		  'gcdata7' = cxfb61d7
	      'gdata7' = cxfb61d7
	      'gcdata6' = cxa58aff
	      'gdata6' = cxa58aff
	      'gcdata5' = cx00b6eb
	      'gdata5' = cx00b6eb
	      'gcdata4' = cx00c094
	      'gdata4' = cx00c094
	      'gcdata3' = cx53b400
	      'gdata3' = cx53b400
	      'gcdata2' = cxc49a00
	      'gdata2' = cxc49a00
	      'gcdata1' = cxf8766d
	      'gdata1' = cxf8766d 
           'gcdata'=cxf8766d
           'gdata'=cxf8766d;

      class GraphWalls /                                                      
         linethickness = 1px                                                  
         linestyle = 1                                                        
         frameborder = on   
         contrastcolor = GraphColors('gwalls')                                 
         backgroundcolor = GraphColors('gwalls')                              
         color = GraphColors('gwalls');   

      class GraphGridLines /                                                  
         displayopts = "on"                                                 
         linethickness = 1px                                                  
         linestyle = 1                                                        
         contrastcolor = GraphColors('ggrid')                                 
         color = GraphColors('ggrid');

      class GraphAxisLines /                                                  
         tickdisplay = "outside"                                              
         linethickness = 1px                                                  
         linestyle = 1                                                        
         contrastcolor = GraphColors('gaxis');  
 
      class GraphBox /                                                        
         capstyle = "serif"                                                   
         connect = "mean"                                                     
        displayopts = "fill median mean outliers";

		*==�޸�ͼ�δ�С;
		style Graph from Graph/
		OutputWidth=14cm
		OutputHeight=10cm 
		BorderWidth=0;
	   
		*==�޸�ͼ�����߿�;
		style  GraphBorderLines from GraphBorderLines /
		LineThickness=0px 
		LineStyle=1;

	    *==�޸�ͼ�α߿�;
		style GraphOutlines from GraphOutlines/
		LineStyle=1
		LineThickness=0px;
	    
	    *==�޸�Markersymbol;
	   class GraphData1 from GraphData1 /
       markersymbol = "CircleFilled" ;
	   class GraphData2 from GraphData2 /
       markersymbol = "CircleFilled" ;
	   class GraphData3 from GraphData3 /
       markersymbol = "CircleFilled" ;
	   class GraphData4 from GraphData4 /
       markersymbol = "CircleFilled" ;
	   class GraphData5 from GraphData5 /
       markersymbol = "CircleFilled" ;
	   class GraphData6 from GraphData6 /
       markersymbol = "CircleFilled" ;
	   class GraphData7 from GraphData7 /
       markersymbol = "CircleFilled" ;

	   *==�޸�������;
		class GraphAxisLines from GraphAxisLines/
		tickdisplay = "outside"
		linethickness = 0px
		linestyle = 1;
 end;
run;




*===ʹ����ʽ;
ods html style=mystyle gpath="d:\03-Publishing\B01-Book\01 SAS�������\04 Out\StatsGraph" dpi=600;
ods graphics/ outputfmt=jpg;


ods html style=ggplot2 gpath="d:\03-Publishing\B01-Book\01 SAS�������\04 Out\StatsGraph" dpi=600;
ods graphics/ outputfmt=jpg;


ods html style=htmlblue gpath="d:\03-Publishing\B01-Book\01 SAS�������\04 Out\StatsGraph" dpi=600;
ods graphics/ outputfmt=jpg;



ods html style=ggplot2;

*���� 8-1 SAS/Graph ģ�黭ͼ����;

*===��ɢ��ͼ;
proc gplot data=sashelp.class;
   plot height*weight;
run;

symbol1 interpol=rcclm95  value=circle  cv=darkred   
        ci=black   co=blue   width=2;   
plot height*weight;
run;
quit;


*==��ֱ��ͼ;
proc gchart data=sashelp.class;
  block sex/sumvar=weight ;
run;



*���� 8-2 ��������Զ�����K-M����;
proc lifetest data=sashelp.bmt;
	time t*status(0);
	strata group;
run;




*���� 8-3 ODS Graphics�������;

*===ODS GRAPHICS������ó���ͼƬ�����Լ���ʽ����Ҫ������ۻ��¼�ͼ;
ods graphics on/width=20cm height=18cm  noborder 
                imagename="failureplot" outputfmt=jpg;
proc lifetest data=sashelp.bmt plots=(s(f));
	time t*status(0);
	strata group;
run;


proc lifetest data=sashelp.bmt plots=(s);
	time t*status(0);
	strata group;
run;





*���� 8-4 SAS ODS Graphics�༭��;
ods html sge=on;
ods graphics on/width=20cm height=18cm  noborder 
                imagename="failureplot"  outputfmt=jpg;
proc lifetest data=sashelp.bmt plots=(s(f));
	time t*status(0);
	strata group;
run;
ods html sge=off;



*���� 8-5 Proc sgplot��ͼ;

*===ɢ��+�ع�;
proc sgplot data=sashelp.class;
   scatter x=height y=weight;
   reg   x=height y=weight/cli clm;   
run;

*==��ֱ��ͼ;
proc sgplot data=sashelp.class;
  vbar sex/respose=weight;
run;



*=���� 8-6 ��GTL����ɢ��ͻع���ͼ;

*==����;
proc template;
 define statgraph scattereg;
 	begingraph;
	layout overlay;
	scatterplot x=height y=weight;
	regressionplot x=height y=weight/name= "fitline" legendlabel="Regression line" clm="clm" cli="cli" ;
	modelband  "clm"/name="bandclm" legendlabel="95% CLI" datatransparency=0.3;
	modelband  "cli"/name="bandcli" legendlabel="95% CLM" display=(outline); 
    discretelegend "fitline" "bandclm"  "bandcli";
    endlayout;
   endgraph;
  end;
run;

*==��Ⱦ;
proc sgrender data=sashelp.class template=scattereg;
run;




*=======
 STYLE
========;

proc template;
   list styles;
run;

proc template;
	source styles.htmlblue;
    source styles.statistical;
	source styles.default;
run;







*=====================
 ͳ��ͼ�ξ�ѡ
======================;

dm odsresults 'clear' continue;

ods html style=ggplot2 gpath="d:\03-Publishing\B01-Book\01 SAS�������\04 Out\StatsGraph" dpi=300;
ods graphics/ outputfmt=jpg;


ods html style=htmlblue gpath="d:\03-Publishing\B01-Book\01 SAS�������\04 Out\StatsGraph" dpi=300;
ods graphics/ outputfmt=jpg;

ods html style=ggStyle gpath="d:\03-Publishing\B01-Book\01 SAS�������\04 Out\StatsGraph" dpi=300;
ods graphics/ outputfmt=jpg;


ods html style=ggplot2 gpath="d:\03-Publishing\B01-Book\01 SAS�������\04 Out\StatsGraph" dpi=300;
ods graphics/ outputfmt=jpg;



*���� 8-7 Proc Sgplot��hbar��vbar��������ͼ;

*===��ֱ��ͼ;

*==����;
proc sgplot data=sashelp.cars  ;
	vbar DriveTrain/categoryorder=respdesc  ;
run;

*==����;
proc sgplot data=sashelp.cars ;
	hbar DriveTrain/categoryorder=respdesc ;
run;



*���� 8-8 Proc freq���̵���ODS Graphicsϵͳ����Ƶ��ͼ;  
*===Ƶ��ͼ;
proc freq data=sashelp.cars;
	table DriveTrain/plots=freqplots;
run;



*���� 8 9 Proc sgplot��vbar�����ƴ�����޵�ʽ��ͼ;

*==�����;
proc sgplot data=sashelp.cars;
	vbar type/response=msrp stat=mean limitstat=stddev limits=upper ;
run;


/**/
/**=��������;*/
/*proc sgplot data=sashelp.cars;*/
/*	vbar type/response=msrp stat=mean;*/
/*run;*/
/**/




*���� 8-10 Prog Sgplot��hbar�����ưٷֱ���ͼ;

*===������������;
data cars;
	set sashelp.cars;
	Drive_Train="Drive Type";
run;

*===Statָ��ͳ�ưٷֱȣ�groupdisplayָ���ѵ���ʽ;
proc sgplot data=cars noborder;
	hbar Drive_Train/group=DriveTrain groupdisplay=stack 
                     stat=percent categoryorder=respdesc ;
run;



*���� 8-11 Proc sgplot��vbar�����Ƹ�ʽ��ͼ;
proc sgplot data=sashelp.cars  ;
	vbar origin/group=DriveTrain groupdisplay=cluster;
run;


*���� 8-12 Proc sgplot��vbar�����ƴ�ӵʽ��ʽ�������ͼ;
proc sgplot data=sashelp.cars;
	vbar origin/response=msrp stat=mean  group=type groupdisplay=cluster limitstat=stddev limits=upper ;
run;


*���� 8-13 Proc sgplot ��vbar�����Ƹ�ʽ�ٷֱ���ͼ;

*===��ʽ�ٷֱ���ͼ-��ӵʽ;
proc sgplot data=sashelp.cars  pctlevel=group;
	  vbar origin/group=DriveTrain groupdisplay=cluster stat=percent;
run;

*===��ʽ�ٷֱ���ͼ-�ѵ�ʽ;
proc sgplot data=sashelp.cars  pctlevel=group;
	vbar origin/group=DriveTrain groupdisplay=stack stat=percent categoryorder=respdesc;
run;



*���� 8-14 Proc freq����plotsѡ�����������ͼ;
proc freq data=sashelp.cars;
	table origin*DriveTrain/plots=mosaicplot;
run;


*���� 8-15 Proc sgplot���ƾ��渴ʽ��ͼ;

*===�����������ݼ�;
data Pop;
  length AgeGroup $12; 
  do AgeGroup='Pre Teen', 'Teen', 'Young Adult', 'Adult', 'Senior';
    Male=round(500*(1+ranuni(2))); 
    Female=round(400*(1+ranuni(2))); 
    output;
  end;
run;

*===�任��������;
data butterfly;
  set pop;
  Male=-male; 
  zero=0; 
run;

*===��ʽ�趨;
proc format;
  picture positive low-<0='0000'
                   0<-high='0000';
run;

*===������;
proc sgplot data=ButterFly;
  format male female positive.;   
  hbarparm category=agegroup response=male ;
  hbarparm category=agegroup response=female;
  xaxis display=(noline nolabel) values=(-1000 to 1000 by 200) ;
  yaxis display=(noline nolabel);
  keylegend /  position=right across=1 noopaque ;
run;


*===������;
proc sgplot data=ButterFly;
  format male female positive.;   
  vbarparm category=agegroup response=male ;
  vbarparm category=agegroup response=female;
   xaxis display=(noline nolabel);
  yaxis display=(noline nolabel) values=(-1000 to 1000 by 200) ; 
  keylegend /  position=right across=1 noopaque ;
run;






*���� 8-16 Proc sgpanel���������ͼ;

*===��ӵʽ;
proc sgpanel data=sashelp.cars pctlevel=group;
    panelby type;
	vbar origin/group=DriveTrain groupdisplay=cluster stat=percent;
run;

*===�ѵ�ʽ;
proc sgpanel data=sashelp.cars pctlevel=group;
    panelby type;
	vbar origin/group=DriveTrain groupdisplay=stack stat=percent categoryorder=respdesc;
run;





/*================================

           ֱ��ͼ
================================*/


*���� 8-17 ��ֱ��ͼ��Sgplot��Univariate����;
*===��ֱ��ͼ��sgplot��;
proc sgplot data=sashelp.cars;
	histogram msrp/nbins=20;
run;

*===��ֱ��ͼ��univariate��;
proc univariate data=sashelp.cars;
  histogram msrp;
run;



*���� 8-18 Prog sgpot�����ص�ֱ��ͼ;
*===����ֱ��ͼ;

proc sgplot data=sashelp.cars;
	histogram msrp/nbins=20 group=type ;
run;

/*proc sgplot data=sashelp.cars;*/
/*	histogram msrp/nbins=20 group=origin transparency=0.4;*/
/*run;*/


*���� 8-19 ���histogram�������ص�ֱ��ͼ;
proc sgplot data=sashelp.cars;
  histogram mpg_city / binstart=0 binwidth=2 transparency=0.5  ;
  histogram mpg_highway / binstart=0 binwidth=2  transparency=0.5 ;
run;




*���� 8-20 GTL���ƾ���ֱ��ͼ;

*===������ֱ��;
proc template;
  define statgraph MirrorHistogramHorz;
    dynamic _binwidth;
      begingraph;

      entrytitle 'Mileage Distribution';
      layout lattice / order=columnmajor columnweights=(0.49 0.51) rowdatarange=union;

        cell;
		  cellheader;
		     entry 'City Mileage';
		  endcellheader;
          layout overlay / xaxisopts=(reverse=true griddisplay=on display=(tickvalues) 
                           linearopts=(tickvaluepriority=true tickvaluesequence=(start=0 end=25 increment=5))) 
                           yaxisopts=(display=none reverse=true griddisplay=on 
                           linearopts=(tickvaluesequence=(start=0 end=70 increment=10)));
           histogram mpg_city / binstart=0 binwidth=_binwidth orient=horizontal binaxis=false 
                                fillattrs=graphdata1 datatransparency=0.3 ;
	      endlayout;
		endcell;

        cell;
		  cellheader;
		     entry 'Highway Mileage';
		  endcellheader; 
          layout overlay / xaxisopts=(griddisplay=on display=(tickvalues) 
		                   linearopts=(tickvaluepriority=true tickvaluesequence=(start=0 end=25 increment=5))) 
                           yaxisopts=(display=(tickvalues) reverse=true griddisplay=on 
                           linearopts=(tickvaluesequence=(start=0 end=70 increment=10)));
	        histogram mpg_highway / binstart=0 binwidth=_binwidth  orient=horizontal binaxis=false 
                                    fillattrs=graphdata2 datatransparency=0.3;
	      endlayout;
		endcell;

	  endlayout;
	endgraph;
  end;
run;

proc sgrender data=sashelp.cars template=MirrorHistogramHorz;
  dynamic _binwidth=2;
run;




*===������ֱ��ͼ;

*���δ�����Sanjay Matange�Ĳ�����������Ȩ������Ѫѹ����ͼ�����޸ġ��ڴ���л;
*===����ģ��;
proc template;
  define statgraph MirrorHistogramVert;
    dynamic _binwidth;
      begingraph;
      entrytitle 'Mileage Distribution';
     *==���岼��;
     layout lattice /columndatarange=union rowgutter=0;
	      *==�������;
	      columnaxes;
		    columnaxis /display=(tickvalues) griddisplay=on 
                        linearopts=(tickvaluesequence=(start=0 end=60 increment=10) tickvaluepriority=true);
		  endcolumnaxes;

		  *==�ϲ���ֱ��ͼ;
          layout overlay /walldisplay=none xaxisopts=(griddisplay=on)
		                  yaxisopts=(griddisplay=on display=(tickvalues label) 
                          linearopts=(tickvaluesequence=(start=5 end=25 increment=5) tickvaluepriority=true));
            histogram mpg_city /binstart=0 binwidth=_binwidth  binaxis=false 
                                fillattrs=graphdata1 datatransparency=0.3 ;
		    entry halign=right 'City Mileage' /valign=top;
	      endlayout;
          
		  *==�²���ֱ��ͼ;
          layout overlay /walldisplay=none  xaxisopts=(griddisplay=on)
                          yaxisopts=(reverse=true griddisplay=on display=(tickvalues label)  
                          linearopts=(tickvaluesequence=(start=5 end=25 increment=5) tickvaluepriority=true));                           ;
		    histogram mpg_highway /binstart=0 binwidth=_binwidth binaxis=false 
		                           fillattrs=graphdata2 datatransparency=0.3;
		    entry halign=right 'Highway Mileage' /valign=bottom;
	    endlayout;

	endlayout;
  endgraph;
  end;
run;

*===��Ⱦģ��;
ods graphics /NOBORDER reset width=5in height=3in imagename='MirrorHistogramVert';
proc sgrender data=sashelp.cars template=MirrorHistogramVert;
  dynamic _binwidth=2;
run;



ods graphics/ reset=all  outputfmt=jpg;
/*ods html style=htmlblue gpath="d:\03-Publishing\B01-Book\01 SAS�������\04 Out\StatsGraph" dpi=300;*/
/*ods html style=ggStyle gpath="d:\03-Publishing\B01-Book\01 SAS�������\04 Out\StatsGraph" dpi=300;*/
ods html style=ggplot2 gpath="d:\03-Publishing\B01-Book\01 SAS�������\04 Out\StatsGraph" dpi=300;



*���� 8-21 Proc sgpanel�������ֱ��ͼ;
proc sgpanel data=sashelp.cars;
  panelby origin/layout=columnlattice;
  histogram mpg_city / binstart=0 binwidth=2 transparency=0.5  ;
  histogram mpg_highway / binstart=0 binwidth=2  transparency=0.5 ;
run;




*====================
   ����ͼ
=====================;


*���� 8-22 Proc sgplot��������ͼ;
*==����;
proc sgplot data=sashelp.cars;
	vbox msrp;
run;

*==����;
proc sgplot data=sashelp.cars;
	hbox msrp;
run;


*���� 8-23 Proc sgplot���Ʒ�������ͼ;
*===����;
proc sgplot data=sashelp.cars;
	vbox msrp/group=type ;
run;



*���� 8-24 Proc sgpanle�����������ͼ;
*===���;
proc sgpanel data=sashelp.cars;
     panelby origin/layout=columnlattice;
	vbox msrp/group=type ;
run;




*=====================
   ɢ�㣻
=====================;


*���� 8-25 Proc sgplot����ɢ��ͼ;
proc sgplot  data=sashelp.cars;
  scatter x=horsepower  y=mpg_highway;
run;


*���� 8-26 Proc sgpot����ɢ��ع�ͼ;
proc sgplot  data=sashelp.cars;
  scatter x=horsepower  y=mpg_highway;
  reg x=horsepower  y=mpg_highway;
run;



*���� 8-27 Proc sgplot���Ʒ���ɢ��ͼ;
proc sgplot  data=sashelp.cars;
  scatter x=horsepower  y=mpg_highway/group=type;
run;


*���� 8-28 Proc sgpanel�������ɢ��ͼ;
proc sgpanel  data=sashelp.cars;
  panelby origin/layout=columnlattice;
  scatter x=horsepower  y=mpg_highway/group=type;
run;



*���� 8-29 Proc sgplot��������ͼ;
proc sgplot data=sashelp.cars  ;
	bubble x=horsepower y=mpg_highway size=enginesize;
run;


*���� 8-30 Proc sgscatter���ƾ���ɢ��ͼ;
proc sgscatter data=sashelp.cars;
 	matrix mpg_highway   horsepower enginesize/diagonal=(histogram normal);
run;


proc sgscatter data=sashelp.cars;
 	matrix mpg_highway   horsepower enginesize/diagonal=(histogram normal) group=type;
run;

	


*=================
  ����ͼ
=================;

*���� 8-31 Proc sgplot��series�����Ƽ�����ͼ;
proc sgplot data=sashelp.stocks(where=(date >= "01jan2002"d and stock = "IBM"));
  series x=date y=close ;
run;

*���� 8-32 Proc sgplot��vline�����Ƽ�����ͼ;
proc sgplot data=sashelp.cars;
	vline cylinders/response=msrp stat=mean markers;
run;

*���� 8-33 Proc sgplot�������������ͼ;
proc sgplot data=sashelp.cars;
	vline cylinders/response=msrp stat=mean limits=both  limitstat=stddev markers;
run;
	
	

*���� 8-34 Proc sgplot���Ʒ�������ͼ;
proc sgplot data=sashelp.cars;
	vline cylinders/response=msrp stat=mean group=type
                    limits=both  limitstat=stddev markers;
run;
	


*���� 8-35 Proc sgplot�����������ͼ;
proc sgpanel data=sashelp.cars;
    panelby origin/layout=columnlattice;
	vline cylinders/response=msrp stat=mean group=type
                    limits=both  limitstat=stddev markers;
run;



*===Area plot;

*���� 8 36 Proc sgplot�������ͼ;
*==���ص����ͼ;
proc sgplot data=sashelp.stocks(where=(date >= "01jan2002"d and stock = "IBM"));
	band x=date lower=0 upper=high/legendlabel="High";
run;

*==�ص����ͼ;
proc sgplot data=sashelp.stocks(where=(date >= "01jan2002"d and stock = "IBM"));
	band x=date lower=0 upper=high/legendlabel="High";
    band x=date lower=0 upper=low/legendlabel="Low";
run;


*���� 8 37 Proc sgplot���ƴ�״ͼ;
*==��״ͼ;
proc sgplot data=sashelp.stocks(where=(date >= "01jan2002"d and stock = "IBM"));
	band x=date lower=low upper=high;
run;




*==============================

   ���ͼ��
==============================;


*���� 8-38 ����ܶ�����;
ods html dpi=300;
ods graphics /width=10cm height=8cm;

*===ͳ�ƹ���;
proc univariate data=sashelp.cars;
	histogram msrp/normal;
run;

*===��ͼ����;
proc sgplot data=sashelp.cars;
	histogram msrp/nbins=20;
	density msrp;
run;




*���� 8-39 ��ϻع���;
*==ͳ�ƹ���;
proc reg data=sashelp.cars plots(only)=fitplot;
  model mpg_highway=horsepower;
quit;

*==��ͼ����;
proc sgplot  data=sashelp.cars;
  scatter x=horsepower  y=mpg_highway;
  reg x=horsepower  y=mpg_highway/cli clm;
run;


*���� 8-40 Proc sgplot������Բ����;
proc sgplot data=sashelp.cars;
    scatter x=horsepower y=mpg_highway;
	ellipse x=horsepower y=mpg_highway;
run;



*���� 8-41 Proc Logistic����ROC����;
proc logistic data=sashelp.heart plots=roc;
	class sex Chol_Status  BP_Status  Weight_Status  Smoking_Status;
    model Status(event="Dead")=AgeAtStart sex Chol_Status  BP_Status  Weight_Status  Smoking_Status;
run;



*���� 8-42 Prco lifetest���������������ۻ��¼�����;
*==��������;
proc lifetest data=sashelp.bmt plots=s;
	time t*status(0);
	strata group;
run;

*==�ۻ��¼�;
proc lifetest data=sashelp.bmt plots=s(failure);
	time t*status(0);
	strata group;
run;



*���� 8-43 Proc sgplot��Proc loess����LOESS����;

*==Proc sgplot;
proc sgplot data=sashelp.cars;
	loess x=horsepower y=mpg_highway;
run;

*===Proc loess;
proc loess data=sashelp.cars  plots(only)=(FitPlot);
      model mpg_highway=horsepower/select= AICC  alpha=.05 all;
run;


*���� 8-44 Proc sgplot����������������;

proc sgplot data=sashelp.cars;
	pbspline  x=horsepower y=mpg_highway ;
run;




/*=========================

       ɭ��ͼ
=========================*/


proc import out=fr 
			 datafile="D:\03-Publishing\B01-Book\01 SAS�������\02 Data\Clean\forest_t.csv"
			 dbms="csv" replace;
run;



*���� 8 45 Proc sgplot���Ƽ�ɭ��ͼ;
ods graphics /height=10cm;
proc sgplot data=fr noautolegend nocycleattrs nowall noborder;
     
	*==����;
	yaxistable Study	CABG	PCI_DES	RR  / position=left labelattrs=(size=7);
	*==ͼ;
	scatter y=study x=rr_m / markerattrs=graphdata2(symbol=squarefilled);
	scatter y=study x=rr_2 / markerattrs=graphdata2(symbol=diamondfilled size=10);
	highlow y=study low=rr_l high=rr_u / type=line;

	*==�ײ��ı�;
	text y=study x=xlbl text=lbl /position=center contributeoffsets=none;
	
	*==������;
	xaxis  max=3  minor display=(nolabel) valueattrs=(size=7);
	yaxis display=none fitpolicy=none reverse  colorbands=even valueattrs=(size=7) colorbandsattrs=Graphdatadefault(transparency=0.8);

	*==�ο���;
	refline 1 / axis=x noclip;
run;



*���� 8 46 SAS 9.40M3 sgplotʵ���������ɭ��ͼ���ĳ���;

*==�˶δ���ԭ����Sanjay Matange�����߽�����ע������;
proc sgplot data=forest_subgroup_2 nowall noborder nocycleattrs dattrmap=attrmap noautolegend;
  styleattrs axisextent=data;
  *==�������;
  yaxistable subgroup  / location=inside position=left textgroup=id labelattrs=(size=7) 
             textgroupid=text indentweight=indentWt ;
  yaxistable countpct / location=inside position=left labelattrs=(size=7) valueattrs=(size=7);
  yaxistable PCIGroup group pvalue / location=inside position=left  pad=(right=15px) 
             labelattrs=(size=7) valueattrs=(size=7);
  *==����95%CIBAR;
  highlow y=obsid low=low high=high; 
  *==����Bar���е�;
  scatter y=obsid x=mean / markerattrs=(symbol=squarefilled);
  *==���λ���Bar�е�,����x2axis;
  scatter y=obsid x=mean / markerattrs=(size=0) x2axis;
  *==�ײ�����;
  text x=xl y=obsid text=text / position=bottom contributeoffsets=none strip;
  format text $txt.;
  *==������;
  yaxis reverse display=none colorbands=odd colorbandsattrs=(transparency=1) offsetmin=0.0;
  xaxis display=(nolabel) values=(0.0 0.5 1.0 1.5 2.0 2.5);
  x2axis label='Hazard Ratio' display=(noline noticks novalues) labelattrs=(size=8);
  *==�ο���;
  refline 1 / axis=x;
  refline ref / lineattrs=(thickness=13 color=cxf0f0f7);
run;



*====GTLʵ��;

%macro  PltRatio(Dataset=, ObsID=obsid, Indent=indent, FactorVar=factor, FactorLbl=Factor,n1=n1,p1=p1,ctnpct1Lbl=Treat, n2=n2, p2=p2, ctnpct2Lbl=Control, ratio=ratio, lcl=lcl, ucl=ucl, ratiocllbl=%str(Ratio(95% CI)), P=p,Plbl=P value, width=10, height=7);

 ods graphics / reset width=&width.cm height=&height.cm ; 
  data ForestRatioDS;
	  set &dataset;
    FactorLbl="&FactorLbl";
    ctnpct1Lbl="&ctnpct1Lbl";
    ctnpct2Lbl="&ctnpct2Lbl";
		RatioclLbl="&ratiocllbl";
    Plbl="&Plbl";

		%if &n1 NE %str() and &p1 NE %str() %then %str(
		ctnpct1=cats(&n1,'(',put(&p1,6.2),')');
		ctnpct2=cats(&n2,'(',put(&p2,6.2),')');
    );
		
		ratiocl=cats(put(&ratio,6.2),'(',put(&lcl,6.2),'-',put(&ucl,6.2),')');
	  pv=put(&p,6.4);

		%if &n1 NE %then %do;
      if missing(&n1) then call missing(ctnpct1,ctnpct2,ratiocl,ratiocl,pv);
		%end;
run;


proc template;
	define statgraph Forest_DataLabel_Indent_93;
		dynamic  _bandcolor;
		begingraph;
			layout lattice / columns=2 columnweights=(0.8 0.2);

				/*--First column for Subgroup and patient counts--*/
				layout overlay / walldisplay=none 
					x2axisopts=(display=(tickvalues) offsetmin=0.05 offsetmax=0.1 tickvalueattrs=(size=8)) 
					yaxisopts=(reverse=true display=none tickvalueattrs=(weight=bold) offsetmin=0);

					referenceline y=ref / lineattrs=(thickness=14 color=_bandcolor);

					scatterplot y=eval(ifn(&Indent=0, &ObsID, .)) x=FactorLbl / datalabel=&FactorVar markerattrs=(size=0) datalabelposition=right 
						xaxis=x2 discreteoffset=-0.25 datalabelattrs=(weight=bold size=7  color=black); /*subgroup title*/

			        scatterplot y=eval(ifn(&Indent=1, &ObsID, .)) x=FactorLbl / datalabel=&FactorVar markerattrs=(size=0) datalabelposition=right 
						xaxis=x2 discreteoffset=-0.15 datalabelattrs=(weight=normal size=7  color=black); /*subgoup value*/


					scatterplot y=&ObsID  x=ctnpct1Lbl / datalabel=ctnpct1 markerattrs=(size=0) datalabelposition=center 
						xaxis=x2 datalabelattrs=(weight=normal size=7);

					scatterplot y=&ObsID  x=ctnpct2Lbl / datalabel=ctnpct2 markerattrs=(size=0) datalabelposition=center 
						xaxis=x2 datalabelattrs=(weight=normal size=7);

					scatterplot y=&ObsID  x=ratioclLbl / datalabel=ratiocl markerattrs=(size=0) datalabelposition=center 
						xaxis=x2 datalabelattrs=(weight=normal size=7);

					scatterplot y=&ObsID  x=plbl / datalabel=Pv markerattrs=(size=0) datalabelposition=center 
						xaxis=x2 datalabelattrs=(weight=normal size=7);

				endlayout;

				/*--Second column showing odds ratio graph--*/
				layout overlay / yaxisopts=(reverse=true display=none offsetmin=0) walldisplay=none
					xaxisopts=(type=log label="Ratio" tickvalueattrs=(size=8) labelattrs=(size=9)  );
					referenceline y=ref / lineattrs=(thickness=14 color=_bandcolor);
					highlowplot y=&ObsID low=&lcl  high=&ucl;
					scatterplot y=&ObsID x=&ratio  / markerattrs=(symbol=squarefilled);
					referenceline x=1;
				endlayout;
			endlayout;
		endgraph;
	end;
run;

proc sgrender data=ForestRatioDS template=Forest_DataLabel_Indent_93;
	dynamic _bandcolor='cxf0f0f0';
run;
%mend;


proc import out=plotds datafile="D:\03-Publishing\B01-Book\01 SAS�������\02 Data\Clean\plot data1.csv"
			 dbms=csv replace;
run;

ods html dpi=300;

%PltRatio(Dataset=plotds, ObsID=id,FactorVar=endpoint,width=18, height=14)






*================================
 ͳ�Ƶ�ͼ
================================;

*===�Ļ����;
*==GMAP����;
proc gmap map=maps.china data=maps.china ;
      id id; 
     choro id /nolegend;
run;
quit;

*==GMAP����;
proc gmap map=mapsgfk.china data=mapsgfk.china ;
      id id; 
     choro id /nolegend;
run;
quit;

*===SGPLOT����;
proc sgplot data = maps.china ;
 scatter x = x y = y /markerattrs=(size=2);
 xaxis  display=none ; 
 yaxis  display=none ;
run;


*==��������;
proc gmap map=mapsgfk.world data=mapsgfk.world ;
	id id;
	choro id/nolegend;
run;
quit;


proc gmap map=mapsgfk.us data=mapsgfk.us ;
	id id;
	choro id/nolegend;
run;
quit;





*===�ӵ���;

*==�й�;
*==�����Դ���;
%annomac
%maplabel(mapsgfk.china, mapsgfk.China_attr(keep=id1 id1nameU), anno_label,id1nameU,id1)




/* Determine the center of the map areas */
%centroid(mapsgfk.china,centers,id);
%maplabel(centers, mapsgfk.China_attr(keep=id1 id1nameU), anno_label,id1nameU,id1)

data anno_label;
	set anno_label;
	text=input(Id1nameU, $uesc50.);
run;
proc gmap map=mapsgfk.china  data=mapsgfk.china;
	id id1;
	choro id1/nolegend anno=anno_label;
run;
quit;


data names; 
   merge centers(in=a) mapsgfk.china_attr;
   by id;
   if a;
   retain xsys '2' ysys '2' when 'a' function 'label';
   length text $20 color $8;
   text=input(Id1nameU, $uesc50.);
   position='5'; color='black'; size=1;
   output;
   text=trim(id1name);
   position='8'; color='gray11'; size=0.5;
   output;
run;


proc sort data=names(where=(position='5' and isoname="CHINA")) nodupkey;
  by text;
run;

ods graphics /width =25cm  height=18cm;
proc gmap data=mapsgfk.china map=mapsgfk.china ;
   id  id1 id  ; 
   choro id/ anno=names coutline=graybb  nolegend;
run; 
quit; 



*===ͳ�Ƶ�ͼ;
proc import out=gdp2013 
             datafile="D:\03-Publishing\B01-Book\01 SAS�������\02 Data\Clean\gdp.csv"
			 dbms=csv replace;
run;



proc sql;
 create table chinagdp as
 select a.*, b.*
 from maps.china as a left join  gdp2013 as b
 on a.id=b.id;
quit;


*===������ͼ;
ods listing style=styles.colorramp;
proc gmap map=maps.china data=chinagdp ;
      id id; 
      choro avggdp2013;
run;
quit;

ods listing style=styles.colorramp;
proc gmap map=maps.china data=chinagdp ;
      id id; 
      choro pm25;
run;
quit;




/*================
  ����
================*/

*���� 8-47  PROC GMAP����������ͼ;
proc gmap map=maps.us  data=maps.us;
	id state;
	choro state/nolegend ;
run;
quit;

proc gmap map=mapsgfk.us data=mapsgfk.us ;
	id id;
	choro id/nolegend;
run;
quit;

proc sgplot data=mapsgfk.us;
 scatter x = x y = y /markerattrs=(size=4);
 xaxis  display=none ; 
 yaxis  display=none ;
run;



*===��ע����;
%annomac
%maplabel(mapsgfk.us, mapsgfk.us_states_attr(keep=id idname), anno_label,idname,id)

*===��ͼ;
proc gmap map=maps.us  data=maps.us;
	id state;
	choro state/nolegend anno=anno_label;
run;

quit;



*���� 8-48 Proc gmap����ͳ�Ƶ�ͼ;
data sample;
   input st $  pop2010 @@;
   state=stfips(st);
   datalines;
AL 4779736 AK 710231 AZ 6392017 AR 2915918
CA 37253956 CO 5029196 CT 3574097 DE 897934
DC 601723 FL 18801310 GA 9687653 HI 1360301
ID 1567582 IL 12830632 IN 6483802 IA 3046355
KS 2853118 KY 4339367 LA 4533372 ME 1328361
MD 5773552 MA 6547629 MI 9883640 MN 5303925
MS 2967297 MO 5988927 MT 989415 NE 1826341
NV 2700551 NH 1316470 NJ 8791894 NM 2059179
NY 19378102 NC 9535483 ND 672591 OH 11536504
OK 3751351 OR 3831074 PA 12702379 RI 1052567
SC 4625364 SD 814180 TN 6346105 TX 25145561
UT 2763885 VT 625741 VA 8001024 WA 6724540
WV 1852994 WI 5686986 WY 563626 PR 3725789 
;
run;


*===ͳ�Ƶ�ͼ;
proc gmap map=maps.us data=sample ;
      id state; 
      block pop2010/levels=6;
	  format est2015 pop2010 comma12.;
run;
quit;


*���� 8-49 Proc gmap����������ͼ;
ods listing style=styles.ggplot2;
proc gmap map=maps.us data=sample ;
      id state; 
      choro pop2010/levels=6 anno=anno_label;
	  format pop2010 comma12.;
run;
quit;




/*===============================
  �޸���ʽ
================================*/

*���� 8-50 ODS HTMLĬ�������ʽ��
ods html style=htmlblue;
proc sgplot data=sashelp.cars;
	histogram weight/binwidth=500  binstart=2000;
	density weight/type=normal;
    density weight/type=kernel;
run;

*���� 8-51 ���������ʽ;
ods html style=analysis;
proc sgplot data=sashelp.cars;
	histogram weight/binwidth=500  binstart=2000;
	density weight/type=normal;
    density weight/type=kernel;
run;

ods html style=journal;
proc sgplot data=sashelp.cars;
	histogram weight/binwidth=500  binstart=2000;
	density weight/type=normal;
    density weight/type=kernel;
run;




*=���� 8-52 SG�������ѡ���޸�ͼ�����;


ods html  gpath="d:\03-Publishing\B01-Book\01 SAS�������\04 Out\StatsGraph" dpi=300;
ods graphics/outputfmt=jpg;

*==Ĭ��Ч��;
ods html style=htmlblue;
proc sgplot data=sashelp.cars;
	histogram weight/binwidth=500  binstart=2000;
	density weight/type=normal;
    density weight/type=kernel;
run;


*==SG����ѡ���޸�Ч��;
ods graphics /noborder;
proc sgplot data=sashelp.cars noborder;
	histogram weight/binwidth=500  binstart=2000 nooutline fillattrs=(color=green);
	density weight/type=normal lineattrs=graphfit2;
    density weight/type=kernel lineattrs=graphfit3(color=blue);
	keylegend /noborder;
run;


*���� 8-53 GTL���ѡ���޸�ͼ�����;
proc template;
	define statgraph hisdensity;
	  begingraph;
		layout overlay /walldisplay=none;
	    	histogram weight/binwidth=500  binstart=2000  fillattrs=(color=green) outlineattrs=(thickness=0);
			densityplot weight/normal() lineattrs=graphfit2;
	        densityplot weight/kernel() lineattrs=graphfit3(color=blue);
		endlayout;
	endgraph;
	end;
run;

		
proc sgrender data=sashelp.cars template=hisdensity;
run;



*==========================
  SAS ����R;
*==========================;

*==����Ƿ������Ƶ�ϵͳѡ��;
proc options restrict;
run;
	

*==���Rѡ��;
proc options option=Rlang;
run;


*���� 8 54 �ó���鿴��ʽԴ�ļ�;
proc template;
  source styles.default;
run;

*���� 8-55 PROC TEMPLATE�Զ�����ʽ�ļ�

*===�Զ�����ʽ;
proc template;
  define style styles.ggStyle;
	parent = Styles.Htmlblue;

	*==�޸�ͼ�δ�С;
	style Graph from Graph/
	OutputWidth=14cm
	OutputHeight=10cm 
	BorderWidth=0;
   
	*==�޸�ͼ�����߿�;
	style  GraphBorderLines from GraphBorderLines /
	LineThickness=0px 
	LineStyle=1;

    *==�޸�ͼ�α߿�;
	style GraphOutlines from GraphOutlines/
	LineStyle=1
	LineThickness=0px;
    
	*==�޸�����ͼ�α߿�;
    style  GraphWalls from GraphWalls/
	FrameBorder=off
	LineThickness=0px 
	LineStyle=1; 
   end;
run;



*���� 8-56 �Զ�����ʽ�ļ�ģ��R��ggplot2���;

*==SASģ��ggplot2���;
ods graphics/ outputfmt=jpg width=18cm height=20cm;
ods html style=ggplot2;
proc sgplot  data=sashelp.cars;
  scatter x=horsepower  y=mpg_highway/group=type;
  keylegend /position=right across=1 noopaque;
run;

*==SAS����R�Ա�;
proc iml;
	call ExportDatasetToR("SAShelp.cars","df");
	submit/R;
	library(ggplot2)
	ggplot(data = df, mapping = aes(x=Horsepower,y=MPG_Highway,color=Type))+
		geom_point() 
	endsubmit;
quit;



*==��ͼ�Ƚ�;

*===ʹ����ʽ;
ods html style=mystyle gpath="d:\03-Publishing\B01-Book\01 SAS�������\04 Out\StatsGraph" dpi=600;
ods graphics/ outputfmt=jpg;


ods html style=ggplot2 gpath="d:\03-Publishing\B01-Book\01 SAS�������\04 Out\StatsGraph" dpi=300;
ods graphics/ outputfmt=jpg ;
*===ɢ��;



*���� 8-57  ODS�������ͼƬ����;

ods html style=ggStyle gpath="d:\B01-Book\01 SAS�������\04 Out\StatsGraph" dpi=600;
ods graphics/  width=14cm height=10cm  outputfmt=jpg;



*���� 8-58  ODS�������ͼƬ����;

ods listing gpath="D:\myGraph" dpi=300;
*===ʸ��ͼ;
ods graphics on/imagename="myeps" outputfmt=EPS;

*===λͼ;
ods graphics on/imagename="mytif" outputfmt=TIF;


*���� 8-59 һ�����㶨ѧ���ڿ�ͼƬ��ʽ����;

*===ʸ��ͼ;
ods printer printer=Postscript FILE="D:\myeps.eps" dpi=300;
��ͼ���
ods printer close;

*===λͼ;
ods printer printer=tiff FILE="D:\mytiff.tiff" dpi=300;
��ͼ���
ods printer close;
