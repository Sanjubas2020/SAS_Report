/** REPORTING PROCEDURES/ SUMMARY PROCEDURES **/
 
/* FREEQUENCY PEOCEDURE:- proc freq; */
/* it will generates freq counts  */
/* 1. one way frequency */
/* 2. two way frequency(cross tabulation frequency)  */
proc freq data=sashelp.class;
run;


/** in one way frequency will generate frequency, percentage, cummulate frequency, cummulative percentage **/

proc format;
value $gender
'M' = 'MALE'
'F'='FEMALE' ;
value ages
11='kid'
12='child'
13='minor'
14='major';
run;

proc sort data=sashelp.class out=clsssort;
by sex ;
run;

proc freq data=clsssort;
table age height /   out=dsname ;
by sex;
format sex $gender. age ages.;
run;

proc freq data=clsssort;
table age height / nocum nopercent  out=dsname ;
by sex;
format sex $gender. age dollar8.;
run;

/** Two way frequency(cross tabulation freq) **/
/** it will generates rowpercentage column percentage percentage frequency **/

proc freq data=sashelp.class;
table  sex*age sex*height sex*weight  /   out=dsname ;
run;

proc freq data=sashelp.class;
table  sex*age sex*height sex*weight  / missing norow nocol nopercent out=dsname ;
run;

proc freq data=sashelp.class;
table  sex*age sex*height sex*weight  /   out=dsname crosslist;
run;

/* MEANS PROCEDURE:- proc means; */
/* it will generates default discriptive statistics */

proc means data=sashelp.class;
run;

proc means data=sashelp.class;
class sex; /** grouping the data **/
var age; /** numeric variables * */
output out=dsname  
n=analysis_n
min=analysis_min
max=analysis_max
mean=analysis_avg
std=analysis_std;
run;

proc means data=sashelp.class  n min max std mean nmiss;
class sex; /** grouping the data **/
var age; /** numeric variables **/
output out=dsname  
n=
min()=
max()=
mean()=
std()= /autoname;
run;

/* SUMMARY PROCEDURE:- proc summary; */
/* it will generates default summary statistics */
proc summary data=sashelp.class print;
run; /** it will give the number of observations **/

proc summary data=sashelp.class print;
var age; /** numeric variables **/
run;

proc summary data=sashelp.class print;
class sex;
var age; /** numeric variables **/
run;

proc summary data=sashelp.class print;
class sex; /** grouping the data **/
var age; /** numeric variables **/
output out=dsname  
n=analysis_n
min=analysis_min
max=analysis_max
mean=analysis_avg
std=analysis_std;
run;

proc summary data=sashelp.class print;
class sex; /** grouping the data **/
var age height; /** numeric variables **/
output out=dsname  
n=
min()=
max()=
mean()=
std()= /autoname;
run;

/* UNIVARIATE PROCEDURE:- proc univariate; */
/* it will generate all possibile statistics */
proc univariate data=sashelp.class;
class sex;
var age;
run;
/* TABLUATE PROCEDURE: proc tabulate; */
/* genarates user defined reports(table structure) */

proc tabulate data=sashelp.class;
class sex name;
var age height weight;
table  age*(n min max sum median) height*(max sum) weight*(sum), sex*name / box='tabulate';
run;



/* REPORT PROCEDURE: proc report; */
/* generate both detailed and summarized results and enhances the output report results for each variable  */

proc import datafile='D:\Sudha\sas\SAS\5. BANKING PROJECT\EAG Report\EAGBR.csv' out=EAGBR
dbms=csv replace;
run;

proc import datafile='D:\Sudha\sas\SAS\5. BANKING PROJECT\EAG Report\EAGTN.csv' out=EAGTN
dbms=csv replace;
run;

proc format;
value $fmt
'EQUITY BROKERAGE'='Equity Brokerage'
'DERIVATIVE BROKERAGE'='Derivative Brokerage'
;
run;

ods html file='E:\EAG_BROKERAGE.html';
PROC REPORT DATA=EAGBR split='*'
style(header)={background=#A9A9A9 foreground=blue}
style(column)={background=#D3D3D3};
COLUMN  PRODUCT ("EAG + PCG" EAG_EQUITY_REVENUE PCG_EQUITY_REVENUE RELIGARE_REVENUE a b)
("NRI" NRI_EQUITY_REVENUE NRI_IDIRECT_REVENUE c)
("Total Revenue" TEAM_WISE_TOTAL TOTAL_EQUITY_REVENUE d);
DEFINE  PRODUCT / DISPLAY  "PRODUCT" format=$fmt.;
DEFINE  EAG_EQUITY_REVENUE /  "EAG" ;
DEFINE  PCG_EQUITY_REVENUE /  "PCG" ;
DEFINE  RELIGARE_REVENUE /  "RELIGARE" ;
DEFINE  NRI_EQUITY_REVENUE /  "NRI_EQUITY_REVENUE" ;
DEFINE  TEAM_WISE_TOTAL /  "TEAM_WISE_TOTAL" ;
DEFINE  TOTAL_EQUITY_REVENUE /  "TOTAL_EQUITY_REVENUE" ;
DEFINE  NRI_IDIRECT_REVENUE /  "NRI_IDIRECT_REVENUE" ;
define a/ computed "EAG % of*RELIGARE*Revenue" format=percent8.2;
define b/ computed "PCG % of*RELIGARE*Revenue" format=percent8.2;
define c/ computed "NRI % of*RELIGARE*Revenue" format=percent8.2;
define d/ computed "% of RELIGARE*Revenuee" format=percent8.2;
compute a;
a=_c2_/_c4_;
endcomp;
compute b;
b=_c3_/_c4_;
endcomp;
compute c;
c=_c7_/_c8_;
endcomp;
compute d;
d=_c10_/_c11_;
endcomp;
rbreak after  / summarize style={background=#A9A9A9};
compute after ;
PRODUCT='Total';
endcomp;
title bold ITALIC j=c 'EAG Brokerage Report (In Lakhs)';
RUN;
ods html close;


proc sgplot data=sashelp.class;
vbar sex;
run;

proc gchart data=sashelp.class;
hbar sex;
run;

proc corr data=sashelp.class;
var age ;
run;

proc gplot data=sashelp.class;
plot sex*age;
run;



