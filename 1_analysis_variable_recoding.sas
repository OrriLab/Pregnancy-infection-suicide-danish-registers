libname  DATAAK 'E:\rawdata\708082\Grunddata';
libname  DATAAK2 'E:\rawdata\708082\Population';
libname  DATAAK3 'E:\rawdata\708082\Eksterne data';
libname  BASE 'E:\workdata\708082\AE\DATA\BASECAMP';
libname  DATA 'E:\workdata\708082\MO\DATA\';
libname  RESULTS 'E:\workdata\708082\MO\Paper_1_infections\RESULTS_infections';
RUN;


options compress=on;
OPTIONS OBS=max;

%macro age (date,fdato);
floor ((intck('month',&fdato,&date) - (day(&date) < day(&fdato))) / 12)
%mend age;


*birth weight (P_1);
proc format;
value P_1f 
low - 1499 = '0- 1500'
1500 - 2499 = '1500 to 2499'
2500 - 2999 = '2500 to 2999'
3000 - 3499 = '3000 to 3499'
3500 - 3999 = '3500 to 3999'
4000 - 4499 = '4000 to 4499'
4500 - 99998 = '4500 or more'
99999  = 'missing'
;

value P_1fb 
low - 1499 = '0- 1500'
1500 - 2499 = '1500 to 2499'
2500 - 4499 = '2500 to 4499'
4500 - 99998 = '4500 or more'
99999  = 'missing'
;

value P_1fc 
low - 2499 = 'low'
2500 - 99998 = 'not low'
99999  = 'missing'
;

*apgar score (P_2);
value P_2f
low - 6 = 'low'
7 - 99998 = 'not low'
99999  = 'missing';
;

*gestational age in weeks(P_3);
*value P_3f
low - 34.9 = 'less 35'
35 - 36.9 = '35 to 36.9'
37 - 39.9 = '37 to 39.9'
40 - 99998 = '40 or more'
99999  = 'missing'
;


value P_3f low - 244.9 = 'less 35'
	       245 - 258.9 = '35 to 36.9'
		   259 - 279.9 = '37 to 39.9'
		   280 - 99998 = '40 or more'
		   99999  = 'missing';


*length (P_4);
value P_4f
low - 47.9 = 'less 48'
48 - 49.9 = '48 to 49.9'
50 - 51.9 = '50 to 51.9'
52 - 53.9 = '52 to 53.9'
54 - 99998 = '54 or more'
99999  = 'missing'
;


*smoking (P_5);
value P_5f 
0 = 'not smoking'
1 = 'smoker (past/present)'
99999  = 'missing';

*year ;
value period
1980-1989= '1980-89'
1990-1999= '1990-99'
2000-2009= '2000-09'
2010-2021= '2010-21'
;

*age ;
value age2group
1,2='3-9'
3,4='10-19'
5,6='20-29'
7,8='30-39'
9,10='40-49'
11,12='50-59'
13,14='60-69'
15,16='70-79'
17,18='80-89'
19 - high='90+'
;

*sex ;
value sex
1='male'
2 ='female'
;


value living
1='livling alone'
2 ='cohabiting'
;


value civ
1='never married'
2, other = 'couple'
3 ='divorced'
4 ='widowed'
;

value socio
3='working'
4='unemployed'
1,2,5-high='others+retire'
other='missing'
;

value education
1='Elementary' 
2='Vocational' 
3='HighSchool'
4='Higher Education' 
5='On-going' 
9='missing' 
;

value psychdisorder
0='no mental disorder'
1 - high ='mental disorder'
;

value mom_alone
0='cohabitating'
1='alone'
;

value n_mom_psych_diag
0 ='no disorders'
1 ='one disorder'
2 - high ='comorbid disorders'
;

Quit;






* ==============================================================================================================================


					DATA PREPARATION STEPS: NEW VARIABLES


* ============================================================================================================================== ;


********************************************************************************************************************************************************* ;
* 	Individual marker
********************************************************************************************************************************************************* ;

proc sort data= data.prebirth_all ;
by  PNR time;
run;

data data.prebirth_all;
set data.prebirth_all (where = (fail_sa NE 999));
by pnr;
if last.pnr then id=1;
run;


proc mean data = data.prebirth_all;
var id;
by sex;
OUTPUT out=RESULTS.count_individuals (drop=_TYPE_ _FREQ_) SUM(id) = id;
run;



********************************************************************************************************************************************************* ;
* 	Parental income
********************************************************************************************************************************************************* ;

data data.Prebirth_all;
set data.Prebirth_all;
parental_income  = max(mom_income,dad_income);
run;

proc freq data= data.Prebirth_all;
tables parental_income;
run;


********************************************************************************************************************************************************* ;
* 	Low Birth Weight
********************************************************************************************************************************************************* ;


data data.Prebirth_all;
set data.Prebirth_all;
lbw =0;
if Birth_1 < 2500 THEN lbw =1;
if Birth_1 > 15000 THEN lbw=99999;
if Birth_1 < 800 THEN lbw=99999;
run;


proc freq data= data.Prebirth_all;
tables lbw;
run;




********************************************************************************************************************************************************* ;
* 	Prematurity
********************************************************************************************************************************************************* ;


data data.Prebirth_all;
set data.Prebirth_all;
prematurity =0;
if Birth_3 < 259 THEN prematurity =1;
if Birth_3 > 315 THEN prematurity=99999;
if Birth_3 < 168 THEN prematurity=99999;
run;




********************************************************************************************************************************************************* ;
* 	Mom_alone - mom living alone (1) vs cohabitating (0) at child birth
********************************************************************************************************************************************************* ;

* note: there is a third category in mom_cohab that is unspecified. I merged it to the "cohabitating" categories because these have similar suicide beh rates ; 
data data.Prebirth_all;
set data.Prebirth_all;
mom_alone = mom_cohab;
if mom_cohab=2 THEN mom_alone=0;
run;

proc freq data= data.Prebirth_all;
format mom_alone mom_alone.;
tables mom_cohab*mom_alone;
run;



********************************************************************************************************************************************************* ;
* 	Mental disorders in the parents
********************************************************************************************************************************************************* ;

data data.Prebirth_all;
set data.Prebirth_all;
n_parents_psyk =  sum(mompsykk9, dad_psych9);
run;

proc freq data= data.Prebirth_all;
tables any_parent_psyk;
run;



********************************************************************************************************************************************************* ;
* 	Income
********************************************************************************************************************************************************* ;

data data.Prebirth_all;
set data.Prebirth_all;
low_parental_income =99999;
if parental_income EQ 0 THEN low_parental_income=1;
if parental_income  > 0 THEN low_parental_income=0;
run;

PROC FREQ data= data.Prebirth_all ;
table low_parental_income;
run;



********************************************************************************************************************************************************* ;
* 	Age
********************************************************************************************************************************************************* ;

PROC FREQ data= data.Prebirth_all ;
table agegp;
run;


data data.Prebirth_all;
set data.Prebirth_all;
newagegp =99999;
if agegp < 5 THEN newagegp =1;
if agegp EQ 5 THEN newagegp=2;
if agegp EQ 6 THEN newagegp=2;
if agegp EQ 7 THEN newagegp=3;
if agegp EQ 8 THEN newagegp=3;
if agegp EQ 9 THEN newagegp=4;
if agegp EQ 10 THEN newagegp=4;
run;

data data.Prebirth_all;
set data.Prebirth_all;
newagegp2 =99999;
if agegp < 5   THEN newagegp2=1;
if agegp EQ 5  THEN newagegp2=2;
if agegp EQ 6  THEN newagegp2=2;
if agegp EQ 7  THEN newagegp2=2;
if agegp EQ 8  THEN newagegp2=2;
if agegp EQ 9  THEN newagegp2=2;
if agegp EQ 10 THEN newagegp2=2;
run;





********************************************************************************************************************************************************* ;
* 	Period
********************************************************************************************************************************************************* ;

PROC FREQ data= data.Prebirth_all ;
table period;
run;


data data.Prebirth_all;
set data.Prebirth_all;
newperiod =99999;
if period < 5 THEN newperiod =1;
if period EQ 5 THEN newperiod=2;
if period EQ 6 THEN newperiod=2;
if period EQ 7 THEN newperiod=3;
if period EQ 8 THEN newperiod=3;
run;


data data.Prebirth_all;
set data.Prebirth_all;
newperiod2 =99999;
if year LE 2000 THEN newperiod2 =0;
if year > 2000 THEN newperiod2 =1;
run;




********************************************************************************************************************************************************* ;
* 	Maternal age
********************************************************************************************************************************************************* ;

data data.Prebirth_all;
set data.Prebirth_all;
teen_mom =0;
if mom_age_birth < 20 THEN teen_mom =1;
run;


PROC FREQ data= data.Prebirth_all ;
tables mom_age_birth;
run;


* correlation with paternal age ;
PROC CORR data= data.Prebirth_all (where=(id EQ 1) ) ;
 var age period mom_age_birth dad_age_birth;
 run;




********************************************************************************************************************************************************* ;
* 	Maternal antidepressant and antipsychotic use
********************************************************************************************************************************************************* ;

data data.Prebirth_all;
set data.Prebirth_all;
mom_psych_med = max(mom_antidep, mom_antipsyk);
run;

PROC FREQ data= data.Prebirth_all ;
table mom_psych_med;
run;






********************************************************************************************************************************************************* ;
* 	Exclusive periods of infection - mom
********************************************************************************************************************************************************* ;

* momD1 ;

proc freq data= data.Prebirth_all  ;
tables mom_pre_preg_D4*momD4*mom_post_preg_D4 / list missing;
run;

proc freq data= data.Prebirth_all (where=(id EQ 1) ) ;
tables mom_pre_preg_D4*momD4*mom_post_preg_D4 / list missing;
run;

data data.Prebirth_all;
set data.Prebirth_all;
momD4period = .;
If momD4 = 0 AND mom_pre_preg_D4 = 0 AND mom_post_preg_D4 = 0 THEN momD4period = 0; * never;
else If momD4 = 1 AND mom_pre_preg_D4 = 0 AND mom_post_preg_D4 = 0 THEN momD4period = 1; * pregnancy only;
else If momD4 = 0 AND mom_pre_preg_D4 = 1 AND mom_post_preg_D4 = 0 THEN momD4period = 2; * pre-preg only;
else If momD4 = 0 AND mom_pre_preg_D4 = 0 AND mom_post_preg_D4 = 1 THEN momD4period = 3; * post-preg only;
else If momD4 = 1 AND mom_pre_preg_D4 = 1 AND mom_post_preg_D4 = 0 THEN momD4period = 4; * pregnancy and pre-preg;
else If momD4 = 1 AND mom_pre_preg_D4 = 0 AND mom_post_preg_D4 = 1 THEN momD4period = 5; * pregnancy and post-preg;
else If momD4 = 0 AND mom_pre_preg_D4 = 1 AND mom_post_preg_D4 = 1 THEN momD4period = 6; * pre-preg and post-preg;
else If momD4 = 1 AND mom_pre_preg_D4 = 1 AND mom_post_preg_D4 = 1 THEN momD4period = 7; * all periods;
run;

proc freq data= data.Prebirth_all;
tables momD4period;
run;



data data.Prebirth_all;
set data.Prebirth_all;
momD4period2 = .;
If momD4 = 0 AND mom_pre_preg_D4 = 0 AND mom_post_preg_D4 = 0 THEN momD4period2 = 0; * never;
else If momD4 = 1 AND mom_pre_preg_D4 = 0 AND mom_post_preg_D4 = 0 THEN momD4period2 = 1; * pregnancy only;
else If momD4 = 0 AND mom_pre_preg_D4 = 1 AND mom_post_preg_D4 = 0 THEN momD4period2 = 2; * pre-preg only;
else If momD4 = 0 AND mom_pre_preg_D4 = 0 AND mom_post_preg_D4 = 1 THEN momD4period2 = 3; * post-preg only;
else If momD4 = 1 AND mom_pre_preg_D4 = 1 AND mom_post_preg_D4 = 0 THEN momD4period2 = 4; * pregnancy and pre-preg;
else If momD4 = 1 AND mom_pre_preg_D4 = 0 AND mom_post_preg_D4 = 1 THEN momD4period2 = 4; * pregnancy and post-preg;
else If momD4 = 0 AND mom_pre_preg_D4 = 1 AND mom_post_preg_D4 = 1 THEN momD4period2 = 4; * pre-preg and post-preg;
else If momD4 = 1 AND mom_pre_preg_D4 = 1 AND mom_post_preg_D4 = 1 THEN momD4period2 = 4; * all periods;
run;

proc freq data= data.Prebirth_all;
tables momD4period2;
run;


data data.Prebirth_all;
set data.Prebirth_all;
if momD4period in (0,1) then momD4x = momD4period;
else momD4x = .;
run;


data data.Prebirth_all;
set data.Prebirth_all;
If momD4period = 0 THEN mom_pre_preg_D4x = 0; * never;
else if momD4period = 2 THEN mom_pre_preg_D4x = 1; * pre-pregnancy only;
else mom_pre_preg_D4x = .;
run;

data data.Prebirth_all;
set data.Prebirth_all;
If momD4period = 0 THEN mom_post_preg_D4x = 0; * never;
else if momD4period = 3 THEN mom_post_preg_D4x = 1; * pre-pregnancy only;
else mom_post_preg_D4x = .;
run;

data data.Prebirth_all;
set data.Prebirth_all;
If momD4period = 0 THEN mom_pre_preg_D4x = 0; * never;
else if momD4period > 3 THEN mom_other_D4x = 1; * pre-pregnancy only;
else mom_other_D4x = .;
run;

proc freq data= data.Prebirth_all;
tables momD4x mom_pre_preg_D4x mom_post_preg_D4x mom_other_D4x;
run;





* momI1 ;

proc freq data= data.Prebirth_all  ;
tables mom_pre_preg_I1*momI1*mom_post_preg_I1 / list missing;
run;

proc freq data= data.Prebirth_all (where=(id EQ 1) ) ;
tables mom_pre_preg_I1*momI1*mom_post_preg_I1 / list missing;
run;

data data.Prebirth_all;
set data.Prebirth_all;
momI1period2 = .;
If momI1 = 0 AND mom_pre_preg_I1 = 0 AND mom_post_preg_I1 = 0 THEN momI1period2 = 0; * never;
else If momI1 = 1 AND mom_pre_preg_I1 = 0 AND mom_post_preg_I1 = 0 THEN momI1period2 = 1; * pregnancy only;
else If momI1 = 0 AND mom_pre_preg_I1 = 1 AND mom_post_preg_I1 = 0 THEN momI1period2 = 2; * pre-preg only;
else If momI1 = 0 AND mom_pre_preg_I1 = 0 AND mom_post_preg_I1 = 1 THEN momI1period2 = 3; * post-preg only;
else If momI1 = 1 AND mom_pre_preg_I1 = 1 AND mom_post_preg_I1 = 0 THEN momI1period2 = 4; * pregnancy and pre-preg;
else If momI1 = 1 AND mom_pre_preg_I1 = 0 AND mom_post_preg_I1 = 1 THEN momI1period2 = 4; * pregnancy and post-preg;
else If momI1 = 0 AND mom_pre_preg_I1 = 1 AND mom_post_preg_I1 = 1 THEN momI1period2 = 4; * pre-preg and post-preg;
else If momI1 = 1 AND mom_pre_preg_I1 = 1 AND mom_post_preg_I1 = 1 THEN momI1period2 = 4; * all periods;
run;

proc freq data= data.Prebirth_all;
tables momI1period2;
run;




* momI2 ;

proc freq data= data.Prebirth_all  ;
tables mom_pre_preg_I2*momI2*mom_post_preg_I2 / list missing;
run;

proc freq data= data.Prebirth_all (where=(id EQ 1) ) ;
tables mom_pre_preg_I2*momI2*mom_post_preg_I2 / list missing;
run;

data data.Prebirth_all;
set data.Prebirth_all;
momI2period2 = .;
If momI2 = 0 AND mom_pre_preg_I2 = 0 AND mom_post_preg_I2 = 0 THEN momI2period2 = 0; * never;
else If momI2 = 1 AND mom_pre_preg_I2 = 0 AND mom_post_preg_I2 = 0 THEN momI2period2 = 1; * pregnancy only;
else If momI2 = 0 AND mom_pre_preg_I2 = 1 AND mom_post_preg_I2 = 0 THEN momI2period2 = 2; * pre-preg only;
else If momI2 = 0 AND mom_pre_preg_I2 = 0 AND mom_post_preg_I2 = 1 THEN momI2period2 = 3; * post-preg only;
else If momI2 = 1 AND mom_pre_preg_I2 = 1 AND mom_post_preg_I2 = 0 THEN momI2period2 = 4; * pregnancy and pre-preg;
else If momI2 = 1 AND mom_pre_preg_I2 = 0 AND mom_post_preg_I2 = 1 THEN momI2period2 = 4; * pregnancy and post-preg;
else If momI2 = 0 AND mom_pre_preg_I2 = 1 AND mom_post_preg_I2 = 1 THEN momI2period2 = 4; * pre-preg and post-preg;
else If momI2 = 1 AND mom_pre_preg_I2 = 1 AND mom_post_preg_I2 = 1 THEN momI2period2 = 4; * all periods;
run;

proc freq data= data.Prebirth_all;
tables momI2period2;
run;





* momI3 ;

proc freq data= data.Prebirth_all  ;
tables mom_pre_preg_I3*momI3*mom_post_preg_I3 / list missing;
run;

proc freq data= data.Prebirth_all (where=(id EQ 1) ) ;
tables mom_pre_preg_I3*momI3*mom_post_preg_I3 / list missing;
run;


data data.Prebirth_all;
set data.Prebirth_all;
momI3period2 = .;
If momI3 = 0 AND mom_pre_preg_I3 = 0 AND mom_post_preg_I3 = 0 THEN momI3period2 = 0; * never;
else If momI3 = 1 AND mom_pre_preg_I3 = 0 AND mom_post_preg_I3 = 0 THEN momI3period2 = 1; * pregnancy only;
else If momI3 = 0 AND mom_pre_preg_I3 = 1 AND mom_post_preg_I3 = 0 THEN momI3period2 = 2; * pre-preg only;
else If momI3 = 0 AND mom_pre_preg_I3 = 0 AND mom_post_preg_I3 = 1 THEN momI3period2 = 3; * post-preg only;
else If momI3 = 1 AND mom_pre_preg_I3 = 1 AND mom_post_preg_I3 = 0 THEN momI3period2 = 4; * pregnancy and pre-preg;
else If momI3 = 1 AND mom_pre_preg_I3 = 0 AND mom_post_preg_I3 = 1 THEN momI3period2 = 4; * pregnancy and post-preg;
else If momI3 = 0 AND mom_pre_preg_I3 = 1 AND mom_post_preg_I3 = 1 THEN momI3period2 = 4; * pre-preg and post-preg;
else If momI3 = 1 AND mom_pre_preg_I3 = 1 AND mom_post_preg_I3 = 1 THEN momI3period2 = 4; * all periods;
run;

proc freq data= data.Prebirth_all;
tables momI3period2;
run;







* momI4 ;

proc freq data= data.Prebirth_all  ;
tables mom_pre_preg_I4*momI4*mom_post_preg_I4 / list missing;
run;

proc freq data= data.Prebirth_all (where=(id EQ 1) ) ;
tables mom_pre_preg_I4*momI4*mom_post_preg_I4 / list missing;
run;


data data.Prebirth_all;
set data.Prebirth_all;
momI4period2 = .;
If momI4 = 0 AND mom_pre_preg_I4 = 0 AND mom_post_preg_I4 = 0 THEN momI4period2 = 0; * never;
else If momI4 = 1 AND mom_pre_preg_I4 = 0 AND mom_post_preg_I4 = 0 THEN momI4period2 = 1; * pregnancy only;
else If momI4 = 0 AND mom_pre_preg_I4 = 1 AND mom_post_preg_I4 = 0 THEN momI4period2 = 2; * pre-preg only;
else If momI4 = 0 AND mom_pre_preg_I4 = 0 AND mom_post_preg_I4 = 1 THEN momI4period2 = 3; * post-preg only;
else If momI4 = 1 AND mom_pre_preg_I4 = 1 AND mom_post_preg_I4 = 0 THEN momI4period2 = 4; * pregnancy and pre-preg;
else If momI4 = 1 AND mom_pre_preg_I4 = 0 AND mom_post_preg_I4 = 1 THEN momI4period2 = 4; * pregnancy and post-preg;
else If momI4 = 0 AND mom_pre_preg_I4 = 1 AND mom_post_preg_I4 = 1 THEN momI4period2 = 4; * pre-preg and post-preg;
else If momI4 = 1 AND mom_pre_preg_I4 = 1 AND mom_post_preg_I4 = 1 THEN momI4period2 = 4; * all periods;
run;

proc freq data= data.Prebirth_all;
tables momI4period2;
run;







* momI5 ;

proc freq data= data.Prebirth_all  ;
tables mom_pre_preg_I5*momI5*mom_post_preg_I5 / list missing;
run;

proc freq data= data.Prebirth_all (where=(id EQ 1) ) ;
tables mom_pre_preg_I5*momI5*mom_post_preg_I5 / list missing;
run;


data data.Prebirth_all;
set data.Prebirth_all;
momI5period2 = .;
If momI5 = 0 AND mom_pre_preg_I5 = 0 AND mom_post_preg_I5 = 0 THEN momI5period2 = 0; * never;
else If momI5 = 1 AND mom_pre_preg_I5 = 0 AND mom_post_preg_I5 = 0 THEN momI5period2 = 1; * pregnancy only;
else If momI5 = 0 AND mom_pre_preg_I5 = 1 AND mom_post_preg_I5 = 0 THEN momI5period2 = 2; * pre-preg only;
else If momI5 = 0 AND mom_pre_preg_I5 = 0 AND mom_post_preg_I5 = 1 THEN momI5period2 = 3; * post-preg only;
else If momI5 = 1 AND mom_pre_preg_I5 = 1 AND mom_post_preg_I5 = 0 THEN momI5period2 = 4; * pregnancy and pre-preg;
else If momI5 = 1 AND mom_pre_preg_I5 = 0 AND mom_post_preg_I5 = 1 THEN momI5period2 = 4; * pregnancy and post-preg;
else If momI5 = 0 AND mom_pre_preg_I5 = 1 AND mom_post_preg_I5 = 1 THEN momI5period2 = 4; * pre-preg and post-preg;
else If momI5 = 1 AND mom_pre_preg_I5 = 1 AND mom_post_preg_I5 = 1 THEN momI5period2 = 4; * all periods;
run;

proc freq data= data.Prebirth_all;
tables momI5period2;
run;







* momI6 ;

proc freq data= data.Prebirth_all  ;
tables mom_pre_preg_I6*momI6*mom_post_preg_I6 / list missing;
run;

proc freq data= data.Prebirth_all (where=(id EQ 1) ) ;
tables mom_pre_preg_I6*momI6*mom_post_preg_I6 / list missing;
run;

data data.Prebirth_all;
set data.Prebirth_all;
momI6period2 = .;
If momI6 = 0 AND mom_pre_preg_I6 = 0 AND mom_post_preg_I6 = 0 THEN momI6period2 = 0; * never;
else If momI6 = 1 AND mom_pre_preg_I6 = 0 AND mom_post_preg_I6 = 0 THEN momI6period2 = 1; * pregnancy only;
else If momI6 = 0 AND mom_pre_preg_I6 = 1 AND mom_post_preg_I6 = 0 THEN momI6period2 = 2; * pre-preg only;
else If momI6 = 0 AND mom_pre_preg_I6 = 0 AND mom_post_preg_I6 = 1 THEN momI6period2 = 3; * post-preg only;
else If momI6 = 1 AND mom_pre_preg_I6 = 1 AND mom_post_preg_I6 = 0 THEN momI6period2 = 4; * pregnancy and pre-preg;
else If momI6 = 1 AND mom_pre_preg_I6 = 0 AND mom_post_preg_I6 = 1 THEN momI6period2 = 4; * pregnancy and post-preg;
else If momI6 = 0 AND mom_pre_preg_I6 = 1 AND mom_post_preg_I6 = 1 THEN momI6period2 = 4; * pre-preg and post-preg;
else If momI6 = 1 AND mom_pre_preg_I6 = 1 AND mom_post_preg_I6 = 1 THEN momI6period2 = 4; * all periods;
run;

proc freq data= data.Prebirth_all;
tables momI6period2;
run;








* momI7 ;

proc freq data= data.Prebirth_all  ;
tables mom_pre_preg_I7*momI7*mom_post_preg_I7 / list missing;
run;

proc freq data= data.Prebirth_all (where=(id EQ 1) ) ;
tables mom_pre_preg_I7*momI7*mom_post_preg_I7 / list missing;
run;

data data.Prebirth_all;
set data.Prebirth_all;
momI7period2 = .;
If momI7 = 0 AND mom_pre_preg_I7 = 0 AND mom_post_preg_I7 = 0 THEN momI7period2 = 0; * never;
else If momI7 = 1 AND mom_pre_preg_I7 = 0 AND mom_post_preg_I7 = 0 THEN momI7period2 = 1; * pregnancy only;
else If momI7 = 0 AND mom_pre_preg_I7 = 1 AND mom_post_preg_I7 = 0 THEN momI7period2 = 2; * pre-preg only;
else If momI7 = 0 AND mom_pre_preg_I7 = 0 AND mom_post_preg_I7 = 1 THEN momI7period2 = 3; * post-preg only;
else If momI7 = 1 AND mom_pre_preg_I7 = 1 AND mom_post_preg_I7 = 0 THEN momI7period2 = 4; * pregnancy and pre-preg;
else If momI7 = 1 AND mom_pre_preg_I7 = 0 AND mom_post_preg_I7 = 1 THEN momI7period2 = 4; * pregnancy and post-preg;
else If momI7 = 0 AND mom_pre_preg_I7 = 1 AND mom_post_preg_I7 = 1 THEN momI7period2 = 4; * pre-preg and post-preg;
else If momI7 = 1 AND mom_pre_preg_I7 = 1 AND mom_post_preg_I7 = 1 THEN momI7period2 = 4; * all periods;
run;

proc freq data= data.Prebirth_all;
tables momI7period2;
run;








* momI8 ;

proc freq data= data.Prebirth_all  ;
tables mom_pre_preg_I8*momI8*mom_post_preg_I8 / list missing;
run;

proc freq data= data.Prebirth_all (where=(id EQ 1) ) ;
tables mom_pre_preg_I8*momI8*mom_post_preg_I8 / list missing;
run;

data data.Prebirth_all;
set data.Prebirth_all;
momI8period2 = .;
If momI8 = 0 AND mom_pre_preg_I8 = 0 AND mom_post_preg_I8 = 0 THEN momI8period2 = 0; * never;
else If momI8 = 1 AND mom_pre_preg_I8 = 0 AND mom_post_preg_I8 = 0 THEN momI8period2 = 1; * pregnancy only;
else If momI8 = 0 AND mom_pre_preg_I8 = 1 AND mom_post_preg_I8 = 0 THEN momI8period2 = 2; * pre-preg only;
else If momI8 = 0 AND mom_pre_preg_I8 = 0 AND mom_post_preg_I8 = 1 THEN momI8period2 = 3; * post-preg only;
else If momI8 = 1 AND mom_pre_preg_I8 = 1 AND mom_post_preg_I8 = 0 THEN momI8period2 = 4; * pregnancy and pre-preg;
else If momI8 = 1 AND mom_pre_preg_I8 = 0 AND mom_post_preg_I8 = 1 THEN momI8period2 = 4; * pregnancy and post-preg;
else If momI8 = 0 AND mom_pre_preg_I8 = 1 AND mom_post_preg_I8 = 1 THEN momI8period2 = 4; * pre-preg and post-preg;
else If momI8 = 1 AND mom_pre_preg_I8 = 1 AND mom_post_preg_I8 = 1 THEN momI8period2 = 4; * all periods;
run;

proc freq data= data.Prebirth_all;
tables momI8period2;
run;




* momI9 ;

proc freq data= data.Prebirth_all  ;
tables mom_pre_preg_I9*momI9*mom_post_preg_I9 / list missing;
run;

proc freq data= data.Prebirth_all (where=(id EQ 1) ) ;
tables mom_pre_preg_I9*momI9*mom_post_preg_I9 / list missing;
run;

data data.Prebirth_all;
set data.Prebirth_all;
momI9period2 = .;
If momI9 = 0 AND mom_pre_preg_I9 = 0 AND mom_post_preg_I9 = 0 THEN momI9period2 = 0; * never;
else If momI9 = 1 AND mom_pre_preg_I9 = 0 AND mom_post_preg_I9 = 0 THEN momI9period2 = 1; * pregnancy only;
else If momI9 = 0 AND mom_pre_preg_I9 = 1 AND mom_post_preg_I9 = 0 THEN momI9period2 = 2; * pre-preg only;
else If momI9 = 0 AND mom_pre_preg_I9 = 0 AND mom_post_preg_I9 = 1 THEN momI9period2 = 3; * post-preg only;
else If momI9 = 1 AND mom_pre_preg_I9 = 1 AND mom_post_preg_I9 = 0 THEN momI9period2 = 4; * pregnancy and pre-preg;
else If momI9 = 1 AND mom_pre_preg_I9 = 0 AND mom_post_preg_I9 = 1 THEN momI9period2 = 4; * pregnancy and post-preg;
else If momI9 = 0 AND mom_pre_preg_I9 = 1 AND mom_post_preg_I9 = 1 THEN momI9period2 = 4; * pre-preg and post-preg;
else If momI9 = 1 AND mom_pre_preg_I9 = 1 AND mom_post_preg_I9 = 1 THEN momI9period2 = 4; * all periods;
run;

proc freq data= data.Prebirth_all;
tables momI9period2;
run;






* momI10 ;

proc freq data= data.Prebirth_all  ;
tables mom_pre_preg_I10*momI10*mom_post_preg_I10 / list missing;
run;

proc freq data= data.Prebirth_all (where=(id EQ 1) ) ;
tables mom_pre_preg_I10*momI10*mom_post_preg_I10 / list missing;
run;

data data.Prebirth_all;
set data.Prebirth_all;
momI10period2 = .;
If momI10 = 0 AND mom_pre_preg_I10 = 0 AND mom_post_preg_I10 = 0 THEN momI10period2 = 0; * never;
else If momI10 = 1 AND mom_pre_preg_I10 = 0 AND mom_post_preg_I10 = 0 THEN momI10period2 = 1; * pregnancy only;
else If momI10 = 0 AND mom_pre_preg_I10 = 1 AND mom_post_preg_I10 = 0 THEN momI10period2 = 2; * pre-preg only;
else If momI10 = 0 AND mom_pre_preg_I10 = 0 AND mom_post_preg_I10 = 1 THEN momI10period2 = 3; * post-preg only;
else If momI10 = 1 AND mom_pre_preg_I10 = 1 AND mom_post_preg_I10 = 0 THEN momI10period2 = 4; * pregnancy and pre-preg;
else If momI10 = 1 AND mom_pre_preg_I10 = 0 AND mom_post_preg_I10 = 1 THEN momI10period2 = 4; * pregnancy and post-preg;
else If momI10 = 0 AND mom_pre_preg_I10 = 1 AND mom_post_preg_I10 = 1 THEN momI10period2 = 4; * pre-preg and post-preg;
else If momI10 = 1 AND mom_pre_preg_I10 = 1 AND mom_post_preg_I10 = 1 THEN momI10period2 = 4; * all periods;
run;

proc freq data= data.Prebirth_all;
tables momI10period2;
run;





* momI11 ;

proc freq data= data.Prebirth_all  ;
tables mom_pre_preg_I11*momI11*mom_post_preg_I11 / list missing;
run;

proc freq data= data.Prebirth_all (where=(id EQ 1) ) ;
tables mom_pre_preg_I11*momI11*mom_post_preg_I11 / list missing;
run;

data data.Prebirth_all;
set data.Prebirth_all;
momI11period2 = .;
If momI11 = 0 AND mom_pre_preg_I11 = 0 AND mom_post_preg_I11 = 0 THEN momI11period2 = 0; * never;
else If momI11 = 1 AND mom_pre_preg_I11 = 0 AND mom_post_preg_I11 = 0 THEN momI11period2 = 1; * pregnancy only;
else If momI11 = 0 AND mom_pre_preg_I11 = 1 AND mom_post_preg_I11 = 0 THEN momI11period2 = 2; * pre-preg only;
else If momI11 = 0 AND mom_pre_preg_I11 = 0 AND mom_post_preg_I11 = 1 THEN momI11period2 = 3; * post-preg only;
else If momI11 = 1 AND mom_pre_preg_I11 = 1 AND mom_post_preg_I11 = 0 THEN momI11period2 = 4; * pregnancy and pre-preg;
else If momI11 = 1 AND mom_pre_preg_I11 = 0 AND mom_post_preg_I11 = 1 THEN momI11period2 = 4; * pregnancy and post-preg;
else If momI11 = 0 AND mom_pre_preg_I11 = 1 AND mom_post_preg_I11 = 1 THEN momI11period2 = 4; * pre-preg and post-preg;
else If momI11 = 1 AND mom_pre_preg_I11 = 1 AND mom_post_preg_I11 = 1 THEN momI11period2 = 4; * all periods;
run;

proc freq data= data.Prebirth_all;
tables momI11period2;
run;






* momI12 ;

proc freq data= data.Prebirth_all  ;
tables mom_pre_preg_I12*momI12*mom_post_preg_I12 / list missing;
run;

proc freq data= data.Prebirth_all (where=(id EQ 1) ) ;
tables mom_pre_preg_I12*momI12*mom_post_preg_I12 / list missing;
run;

data data.Prebirth_all;
set data.Prebirth_all;
momI12period2 = .;
If momI12 = 0 AND mom_pre_preg_I12 = 0 AND mom_post_preg_I12 = 0 THEN momI12period2 = 0; * never;
else If momI12 = 1 AND mom_pre_preg_I12 = 0 AND mom_post_preg_I12 = 0 THEN momI12period2 = 1; * pregnancy only;
else If momI12 = 0 AND mom_pre_preg_I12 = 1 AND mom_post_preg_I12 = 0 THEN momI12period2 = 2; * pre-preg only;
else If momI12 = 0 AND mom_pre_preg_I12 = 0 AND mom_post_preg_I12 = 1 THEN momI12period2 = 3; * post-preg only;
else If momI12 = 1 AND mom_pre_preg_I12 = 1 AND mom_post_preg_I12 = 0 THEN momI12period2 = 4; * pregnancy and pre-preg;
else If momI12 = 1 AND mom_pre_preg_I12 = 0 AND mom_post_preg_I12 = 1 THEN momI12period2 = 4; * pregnancy and post-preg;
else If momI12 = 0 AND mom_pre_preg_I12 = 1 AND mom_post_preg_I12 = 1 THEN momI12period2 = 4; * pre-preg and post-preg;
else If momI12 = 1 AND mom_pre_preg_I12 = 1 AND mom_post_preg_I12 = 1 THEN momI12period2 = 4; * all periods;
run;

proc freq data= data.Prebirth_all;
tables momI12period2;
run;





* momI13 ;

proc freq data= data.Prebirth_all  ;
tables mom_pre_preg_I13*momI13*mom_post_preg_I13 / list missing;
run;

proc freq data= data.Prebirth_all (where=(id EQ 1) ) ;
tables mom_pre_preg_I13*momI13*mom_post_preg_I13 / list missing;
run;

data data.Prebirth_all;
set data.Prebirth_all;
momI13period2 = .;
If momI13 = 0 AND mom_pre_preg_I13 = 0 AND mom_post_preg_I13 = 0 THEN momI13period2 = 0; * never;
else If momI13 = 1 AND mom_pre_preg_I13 = 0 AND mom_post_preg_I13 = 0 THEN momI13period2 = 1; * pregnancy only;
else If momI13 = 0 AND mom_pre_preg_I13 = 1 AND mom_post_preg_I13 = 0 THEN momI13period2 = 2; * pre-preg only;
else If momI13 = 0 AND mom_pre_preg_I13 = 0 AND mom_post_preg_I13 = 1 THEN momI13period2 = 3; * post-preg only;
else If momI13 = 1 AND mom_pre_preg_I13 = 1 AND mom_post_preg_I13 = 0 THEN momI13period2 = 4; * pregnancy and pre-preg;
else If momI13 = 1 AND mom_pre_preg_I13 = 0 AND mom_post_preg_I13 = 1 THEN momI13period2 = 4; * pregnancy and post-preg;
else If momI13 = 0 AND mom_pre_preg_I13 = 1 AND mom_post_preg_I13 = 1 THEN momI13period2 = 4; * pre-preg and post-preg;
else If momI13 = 1 AND mom_pre_preg_I13 = 1 AND mom_post_preg_I13 = 1 THEN momI13period2 = 4; * all periods;
run;

proc freq data= data.Prebirth_all;
tables momI13period2;
run;








* momI14 ;

proc freq data= data.Prebirth_all  ;
tables mom_pre_preg_I14*momI14*mom_post_preg_I14 / list missing;
run;

proc freq data= data.Prebirth_all (where=(id EQ 1) ) ;
tables mom_pre_preg_I14*momI14*mom_post_preg_I14 / list missing;
run;

data data.Prebirth_all;
set data.Prebirth_all;
momI14period2 = .;
If momI14 = 0 AND mom_pre_preg_I14 = 0 AND mom_post_preg_I14 = 0 THEN momI14period2 = 0; * never;
else If momI14 = 1 AND mom_pre_preg_I14 = 0 AND mom_post_preg_I14 = 0 THEN momI14period2 = 1; * pregnancy only;
else If momI14 = 0 AND mom_pre_preg_I14 = 1 AND mom_post_preg_I14 = 0 THEN momI14period2 = 2; * pre-preg only;
else If momI14 = 0 AND mom_pre_preg_I14 = 0 AND mom_post_preg_I14 = 1 THEN momI14period2 = 3; * post-preg only;
else If momI14 = 1 AND mom_pre_preg_I14 = 1 AND mom_post_preg_I14 = 0 THEN momI14period2 = 4; * pregnancy and pre-preg;
else If momI14 = 1 AND mom_pre_preg_I14 = 0 AND mom_post_preg_I14 = 1 THEN momI14period2 = 4; * pregnancy and post-preg;
else If momI14 = 0 AND mom_pre_preg_I14 = 1 AND mom_post_preg_I14 = 1 THEN momI14period2 = 4; * pre-preg and post-preg;
else If momI14 = 1 AND mom_pre_preg_I14 = 1 AND mom_post_preg_I14 = 1 THEN momI14period2 = 4; * all periods;
run;

proc freq data= data.Prebirth_all;
tables momI14period2;
run;












********************************************************************************************************************************************************* ;
* 	Exclusive periods of infection - dad
********************************************************************************************************************************************************* ;

* dadD1 ;

proc freq data= data.Prebirth_all  ;
tables dad_pre_preg_D4*dadD4*dad_post_preg_D4 / list missing;
run;

proc freq data= data.Prebirth_all (where=(id EQ 1) ) ;
tables dad_pre_preg_D4*dadD4*dad_post_preg_D4 / list missing;
run;

data data.Prebirth_all;
set data.Prebirth_all;
dadD4period = .;
If dadD4 = 0 AND dad_pre_preg_D4 = 0 AND dad_post_preg_D4 = 0 THEN dadD4period = 0; * never;
else If dadD4 = 1 AND dad_pre_preg_D4 = 0 AND dad_post_preg_D4 = 0 THEN dadD4period = 1; * pregnancy only;
else If dadD4 = 0 AND dad_pre_preg_D4 = 1 AND dad_post_preg_D4 = 0 THEN dadD4period = 2; * pre-preg only;
else If dadD4 = 0 AND dad_pre_preg_D4 = 0 AND dad_post_preg_D4 = 1 THEN dadD4period = 3; * post-preg only;
else If dadD4 = 1 AND dad_pre_preg_D4 = 1 AND dad_post_preg_D4 = 0 THEN dadD4period = 4; * pregnancy and pre-preg;
else If dadD4 = 1 AND dad_pre_preg_D4 = 0 AND dad_post_preg_D4 = 1 THEN dadD4period = 5; * pregnancy and post-preg;
else If dadD4 = 0 AND dad_pre_preg_D4 = 1 AND dad_post_preg_D4 = 1 THEN dadD4period = 6; * pre-preg and post-preg;
else If dadD4 = 1 AND dad_pre_preg_D4 = 1 AND dad_post_preg_D4 = 1 THEN dadD4period = 7; * all periods;
run;

proc freq data= data.Prebirth_all;
tables dadD4period;
run;



data data.Prebirth_all;
set data.Prebirth_all;
dadD4period2 = .;
If dadD4 = 0 AND dad_pre_preg_D4 = 0 AND dad_post_preg_D4 = 0 THEN dadD4period2 = 0; * never;
else If dadD4 = 1 AND dad_pre_preg_D4 = 0 AND dad_post_preg_D4 = 0 THEN dadD4period2 = 1; * pregnancy only;
else If dadD4 = 0 AND dad_pre_preg_D4 = 1 AND dad_post_preg_D4 = 0 THEN dadD4period2 = 2; * pre-preg only;
else If dadD4 = 0 AND dad_pre_preg_D4 = 0 AND dad_post_preg_D4 = 1 THEN dadD4period2 = 3; * post-preg only;
else If dadD4 = 1 AND dad_pre_preg_D4 = 1 AND dad_post_preg_D4 = 0 THEN dadD4period2 = 4; * pregnancy and pre-preg;
else If dadD4 = 1 AND dad_pre_preg_D4 = 0 AND dad_post_preg_D4 = 1 THEN dadD4period2 = 4; * pregnancy and post-preg;
else If dadD4 = 0 AND dad_pre_preg_D4 = 1 AND dad_post_preg_D4 = 1 THEN dadD4period2 = 4; * pre-preg and post-preg;
else If dadD4 = 1 AND dad_pre_preg_D4 = 1 AND dad_post_preg_D4 = 1 THEN dadD4period2 = 4; * all periods;
run;

proc freq data= data.Prebirth_all;
tables dadD4period2;
run;


data data.Prebirth_all;
set data.Prebirth_all;
if dadD4period in (0,1) then dadD4x = dadD4period;
else dadD4x = .;
run;


data data.Prebirth_all;
set data.Prebirth_all;
If dadD4period = 0 THEN dad_pre_preg_D4x = 0; * never;
else if dadD4period = 2 THEN dad_pre_preg_D4x = 1; * pre-pregnancy only;
else dad_pre_preg_D4x = .;
run;

data data.Prebirth_all;
set data.Prebirth_all;
If dadD4period = 0 THEN dad_post_preg_D4x = 0; * never;
else if dadD4period = 3 THEN dad_post_preg_D4x = 1; * pre-pregnancy only;
else dad_post_preg_D4x = .;
run;

data data.Prebirth_all;
set data.Prebirth_all;
If dadD4period = 0 THEN dad_pre_preg_D4x = 0; * never;
else if dadD4period > 3 THEN dad_other_D4x = 1; * pre-pregnancy only;
else dad_other_D4x = .;
run;

proc freq data= data.Prebirth_all;
tables dadD4x dad_pre_preg_D4x dad_post_preg_D4x dad_other_D4x;
run;





* dadI1 ;

proc freq data= data.Prebirth_all  ;
tables dad_pre_preg_I1*dadI1*dad_post_preg_I1 / list missing;
run;

proc freq data= data.Prebirth_all (where=(id EQ 1) ) ;
tables dad_pre_preg_I1*dadI1*dad_post_preg_I1 / list missing;
run;

data data.Prebirth_all;
set data.Prebirth_all;
dadI1period2 = .;
If dadI1 = 0 AND dad_pre_preg_I1 = 0 AND dad_post_preg_I1 = 0 THEN dadI1period2 = 0; * never;
else If dadI1 = 1 AND dad_pre_preg_I1 = 0 AND dad_post_preg_I1 = 0 THEN dadI1period2 = 1; * pregnancy only;
else If dadI1 = 0 AND dad_pre_preg_I1 = 1 AND dad_post_preg_I1 = 0 THEN dadI1period2 = 2; * pre-preg only;
else If dadI1 = 0 AND dad_pre_preg_I1 = 0 AND dad_post_preg_I1 = 1 THEN dadI1period2 = 3; * post-preg only;
else If dadI1 = 1 AND dad_pre_preg_I1 = 1 AND dad_post_preg_I1 = 0 THEN dadI1period2 = 4; * pregnancy and pre-preg;
else If dadI1 = 1 AND dad_pre_preg_I1 = 0 AND dad_post_preg_I1 = 1 THEN dadI1period2 = 4; * pregnancy and post-preg;
else If dadI1 = 0 AND dad_pre_preg_I1 = 1 AND dad_post_preg_I1 = 1 THEN dadI1period2 = 4; * pre-preg and post-preg;
else If dadI1 = 1 AND dad_pre_preg_I1 = 1 AND dad_post_preg_I1 = 1 THEN dadI1period2 = 4; * all periods;
run;

proc freq data= data.Prebirth_all;
tables dadI1period2;
run;




* dadI2 ;

proc freq data= data.Prebirth_all  ;
tables dad_pre_preg_I2*dadI2*dad_post_preg_I2 / list missing;
run;

proc freq data= data.Prebirth_all (where=(id EQ 1) ) ;
tables dad_pre_preg_I2*dadI2*dad_post_preg_I2 / list missing;
run;

data data.Prebirth_all;
set data.Prebirth_all;
dadI2period2 = .;
If dadI2 = 0 AND dad_pre_preg_I2 = 0 AND dad_post_preg_I2 = 0 THEN dadI2period2 = 0; * never;
else If dadI2 = 1 AND dad_pre_preg_I2 = 0 AND dad_post_preg_I2 = 0 THEN dadI2period2 = 1; * pregnancy only;
else If dadI2 = 0 AND dad_pre_preg_I2 = 1 AND dad_post_preg_I2 = 0 THEN dadI2period2 = 2; * pre-preg only;
else If dadI2 = 0 AND dad_pre_preg_I2 = 0 AND dad_post_preg_I2 = 1 THEN dadI2period2 = 3; * post-preg only;
else If dadI2 = 1 AND dad_pre_preg_I2 = 1 AND dad_post_preg_I2 = 0 THEN dadI2period2 = 4; * pregnancy and pre-preg;
else If dadI2 = 1 AND dad_pre_preg_I2 = 0 AND dad_post_preg_I2 = 1 THEN dadI2period2 = 4; * pregnancy and post-preg;
else If dadI2 = 0 AND dad_pre_preg_I2 = 1 AND dad_post_preg_I2 = 1 THEN dadI2period2 = 4; * pre-preg and post-preg;
else If dadI2 = 1 AND dad_pre_preg_I2 = 1 AND dad_post_preg_I2 = 1 THEN dadI2period2 = 4; * all periods;
run;

proc freq data= data.Prebirth_all;
tables dadI2period2;
run;





* dadI3 ;

proc freq data= data.Prebirth_all  ;
tables dad_pre_preg_I3*dadI3*dad_post_preg_I3 / list missing;
run;

proc freq data= data.Prebirth_all (where=(id EQ 1) ) ;
tables dad_pre_preg_I3*dadI3*dad_post_preg_I3 / list missing;
run;

data data.Prebirth_all;
set data.Prebirth_all;
dadI3period2 = .;
If dadI3 = 0 AND dad_pre_preg_I3 = 0 AND dad_post_preg_I3 = 0 THEN dadI3period2 = 0; * never;
else If dadI3 = 1 AND dad_pre_preg_I3 = 0 AND dad_post_preg_I3 = 0 THEN dadI3period2 = 1; * pregnancy only;
else If dadI3 = 0 AND dad_pre_preg_I3 = 1 AND dad_post_preg_I3 = 0 THEN dadI3period2 = 2; * pre-preg only;
else If dadI3 = 0 AND dad_pre_preg_I3 = 0 AND dad_post_preg_I3 = 1 THEN dadI3period2 = 3; * post-preg only;
else If dadI3 = 1 AND dad_pre_preg_I3 = 1 AND dad_post_preg_I3 = 0 THEN dadI3period2 = 4; * pregnancy and pre-preg;
else If dadI3 = 1 AND dad_pre_preg_I3 = 0 AND dad_post_preg_I3 = 1 THEN dadI3period2 = 4; * pregnancy and post-preg;
else If dadI3 = 0 AND dad_pre_preg_I3 = 1 AND dad_post_preg_I3 = 1 THEN dadI3period2 = 4; * pre-preg and post-preg;
else If dadI3 = 1 AND dad_pre_preg_I3 = 1 AND dad_post_preg_I3 = 1 THEN dadI3period2 = 4; * all periods;
run;

proc freq data= data.Prebirth_all;
tables dadI3period2;
run;







* dadI4 ;

proc freq data= data.Prebirth_all  ;
tables dad_pre_preg_I4*dadI4*dad_post_preg_I4 / list missing;
run;

proc freq data= data.Prebirth_all (where=(id EQ 1) ) ;
tables dad_pre_preg_I4*dadI4*dad_post_preg_I4 / list missing;
run;

data data.Prebirth_all;
set data.Prebirth_all;
dadI4period2 = .;
If dadI4 = 0 AND dad_pre_preg_I4 = 0 AND dad_post_preg_I4 = 0 THEN dadI4period2 = 0; * never;
else If dadI4 = 1 AND dad_pre_preg_I4 = 0 AND dad_post_preg_I4 = 0 THEN dadI4period2 = 1; * pregnancy only;
else If dadI4 = 0 AND dad_pre_preg_I4 = 1 AND dad_post_preg_I4 = 0 THEN dadI4period2 = 2; * pre-preg only;
else If dadI4 = 0 AND dad_pre_preg_I4 = 0 AND dad_post_preg_I4 = 1 THEN dadI4period2 = 3; * post-preg only;
else If dadI4 = 1 AND dad_pre_preg_I4 = 1 AND dad_post_preg_I4 = 0 THEN dadI4period2 = 4; * pregnancy and pre-preg;
else If dadI4 = 1 AND dad_pre_preg_I4 = 0 AND dad_post_preg_I4 = 1 THEN dadI4period2 = 4; * pregnancy and post-preg;
else If dadI4 = 0 AND dad_pre_preg_I4 = 1 AND dad_post_preg_I4 = 1 THEN dadI4period2 = 4; * pre-preg and post-preg;
else If dadI4 = 1 AND dad_pre_preg_I4 = 1 AND dad_post_preg_I4 = 1 THEN dadI4period2 = 4; * all periods;
run;

proc freq data= data.Prebirth_all;
tables dadI4period2;
run;







* dadI5 ;

proc freq data= data.Prebirth_all  ;
tables dad_pre_preg_I5*dadI5*dad_post_preg_I5 / list missing;
run;

proc freq data= data.Prebirth_all (where=(id EQ 1) ) ;
tables dad_pre_preg_I5*dadI5*dad_post_preg_I5 / list missing;
run;

data data.Prebirth_all;
set data.Prebirth_all;
dadI5period2 = .;
If dadI5 = 0 AND dad_pre_preg_I5 = 0 AND dad_post_preg_I5 = 0 THEN dadI5period2 = 0; * never;
else If dadI5 = 1 AND dad_pre_preg_I5 = 0 AND dad_post_preg_I5 = 0 THEN dadI5period2 = 1; * pregnancy only;
else If dadI5 = 0 AND dad_pre_preg_I5 = 1 AND dad_post_preg_I5 = 0 THEN dadI5period2 = 2; * pre-preg only;
else If dadI5 = 0 AND dad_pre_preg_I5 = 0 AND dad_post_preg_I5 = 1 THEN dadI5period2 = 3; * post-preg only;
else If dadI5 = 1 AND dad_pre_preg_I5 = 1 AND dad_post_preg_I5 = 0 THEN dadI5period2 = 4; * pregnancy and pre-preg;
else If dadI5 = 1 AND dad_pre_preg_I5 = 0 AND dad_post_preg_I5 = 1 THEN dadI5period2 = 4; * pregnancy and post-preg;
else If dadI5 = 0 AND dad_pre_preg_I5 = 1 AND dad_post_preg_I5 = 1 THEN dadI5period2 = 4; * pre-preg and post-preg;
else If dadI5 = 1 AND dad_pre_preg_I5 = 1 AND dad_post_preg_I5 = 1 THEN dadI5period2 = 4; * all periods;
run;

proc freq data= data.Prebirth_all;
tables dadI5period2;
run;







* dadI6 ;

proc freq data= data.Prebirth_all  ;
tables dad_pre_preg_I6*dadI6*dad_post_preg_I6 / list missing;
run;

proc freq data= data.Prebirth_all (where=(id EQ 1) ) ;
tables dad_pre_preg_I6*dadI6*dad_post_preg_I6 / list missing;
run;

data data.Prebirth_all;
set data.Prebirth_all;
dadI6period2 = .;
If dadI6 = 0 AND dad_pre_preg_I6 = 0 AND dad_post_preg_I6 = 0 THEN dadI6period2 = 0; * never;
else If dadI6 = 1 AND dad_pre_preg_I6 = 0 AND dad_post_preg_I6 = 0 THEN dadI6period2 = 1; * pregnancy only;
else If dadI6 = 0 AND dad_pre_preg_I6 = 1 AND dad_post_preg_I6 = 0 THEN dadI6period2 = 2; * pre-preg only;
else If dadI6 = 0 AND dad_pre_preg_I6 = 0 AND dad_post_preg_I6 = 1 THEN dadI6period2 = 3; * post-preg only;
else If dadI6 = 1 AND dad_pre_preg_I6 = 1 AND dad_post_preg_I6 = 0 THEN dadI6period2 = 4; * pregnancy and pre-preg;
else If dadI6 = 1 AND dad_pre_preg_I6 = 0 AND dad_post_preg_I6 = 1 THEN dadI6period2 = 4; * pregnancy and post-preg;
else If dadI6 = 0 AND dad_pre_preg_I6 = 1 AND dad_post_preg_I6 = 1 THEN dadI6period2 = 4; * pre-preg and post-preg;
else If dadI6 = 1 AND dad_pre_preg_I6 = 1 AND dad_post_preg_I6 = 1 THEN dadI6period2 = 4; * all periods;
run;

proc freq data= data.Prebirth_all;
tables dadI6period2;
run;








* dadI7 ;

proc freq data= data.Prebirth_all  ;
tables dad_pre_preg_I7*dadI7*dad_post_preg_I7 / list missing;
run;

proc freq data= data.Prebirth_all (where=(id EQ 1) ) ;
tables dad_pre_preg_I7*dadI7*dad_post_preg_I7 / list missing;
run;

data data.Prebirth_all;
set data.Prebirth_all;
dadI7period2 = .;
If dadI7 = 0 AND dad_pre_preg_I7 = 0 AND dad_post_preg_I7 = 0 THEN dadI7period2 = 0; * never;
else If dadI7 = 1 AND dad_pre_preg_I7 = 0 AND dad_post_preg_I7 = 0 THEN dadI7period2 = 1; * pregnancy only;
else If dadI7 = 0 AND dad_pre_preg_I7 = 1 AND dad_post_preg_I7 = 0 THEN dadI7period2 = 2; * pre-preg only;
else If dadI7 = 0 AND dad_pre_preg_I7 = 0 AND dad_post_preg_I7 = 1 THEN dadI7period2 = 3; * post-preg only;
else If dadI7 = 1 AND dad_pre_preg_I7 = 1 AND dad_post_preg_I7 = 0 THEN dadI7period2 = 4; * pregnancy and pre-preg;
else If dadI7 = 1 AND dad_pre_preg_I7 = 0 AND dad_post_preg_I7 = 1 THEN dadI7period2 = 4; * pregnancy and post-preg;
else If dadI7 = 0 AND dad_pre_preg_I7 = 1 AND dad_post_preg_I7 = 1 THEN dadI7period2 = 4; * pre-preg and post-preg;
else If dadI7 = 1 AND dad_pre_preg_I7 = 1 AND dad_post_preg_I7 = 1 THEN dadI7period2 = 4; * all periods;
run;

proc freq data= data.Prebirth_all;
tables dadI7period2;
run;








* dadI8 ;

proc freq data= data.Prebirth_all  ;
tables dad_pre_preg_I8*dadI8*dad_post_preg_I8 / list missing;
run;

proc freq data= data.Prebirth_all (where=(id EQ 1) ) ;
tables dad_pre_preg_I8*dadI8*dad_post_preg_I8 / list missing;
run;

data data.Prebirth_all;
set data.Prebirth_all;
dadI8period2 = .;
If dadI8 = 0 AND dad_pre_preg_I8 = 0 AND dad_post_preg_I8 = 0 THEN dadI8period2 = 0; * never;
else If dadI8 = 1 AND dad_pre_preg_I8 = 0 AND dad_post_preg_I8 = 0 THEN dadI8period2 = 1; * pregnancy only;
else If dadI8 = 0 AND dad_pre_preg_I8 = 1 AND dad_post_preg_I8 = 0 THEN dadI8period2 = 2; * pre-preg only;
else If dadI8 = 0 AND dad_pre_preg_I8 = 0 AND dad_post_preg_I8 = 1 THEN dadI8period2 = 3; * post-preg only;
else If dadI8 = 1 AND dad_pre_preg_I8 = 1 AND dad_post_preg_I8 = 0 THEN dadI8period2 = 4; * pregnancy and pre-preg;
else If dadI8 = 1 AND dad_pre_preg_I8 = 0 AND dad_post_preg_I8 = 1 THEN dadI8period2 = 4; * pregnancy and post-preg;
else If dadI8 = 0 AND dad_pre_preg_I8 = 1 AND dad_post_preg_I8 = 1 THEN dadI8period2 = 4; * pre-preg and post-preg;
else If dadI8 = 1 AND dad_pre_preg_I8 = 1 AND dad_post_preg_I8 = 1 THEN dadI8period2 = 4; * all periods;
run;

proc freq data= data.Prebirth_all;
tables dadI8period2;
run;




* dadI9 ;

proc freq data= data.Prebirth_all  ;
tables dad_pre_preg_I9*dadI9*dad_post_preg_I9 / list missing;
run;

proc freq data= data.Prebirth_all (where=(id EQ 1) ) ;
tables dad_pre_preg_I9*dadI9*dad_post_preg_I9 / list missing;
run;

data data.Prebirth_all;
set data.Prebirth_all;
dadI9period2 = .;
If dadI9 = 0 AND dad_pre_preg_I9 = 0 AND dad_post_preg_I9 = 0 THEN dadI9period2 = 0; * never;
else If dadI9 = 1 AND dad_pre_preg_I9 = 0 AND dad_post_preg_I9 = 0 THEN dadI9period2 = 1; * pregnancy only;
else If dadI9 = 0 AND dad_pre_preg_I9 = 1 AND dad_post_preg_I9 = 0 THEN dadI9period2 = 2; * pre-preg only;
else If dadI9 = 0 AND dad_pre_preg_I9 = 0 AND dad_post_preg_I9 = 1 THEN dadI9period2 = 3; * post-preg only;
else If dadI9 = 1 AND dad_pre_preg_I9 = 1 AND dad_post_preg_I9 = 0 THEN dadI9period2 = 4; * pregnancy and pre-preg;
else If dadI9 = 1 AND dad_pre_preg_I9 = 0 AND dad_post_preg_I9 = 1 THEN dadI9period2 = 4; * pregnancy and post-preg;
else If dadI9 = 0 AND dad_pre_preg_I9 = 1 AND dad_post_preg_I9 = 1 THEN dadI9period2 = 4; * pre-preg and post-preg;
else If dadI9 = 1 AND dad_pre_preg_I9 = 1 AND dad_post_preg_I9 = 1 THEN dadI9period2 = 4; * all periods;
run;

proc freq data= data.Prebirth_all;
tables dadI9period2;
run;






* dadI10 ;

proc freq data= data.Prebirth_all  ;
tables dad_pre_preg_I10*dadI10*dad_post_preg_I10 / list missing;
run;

proc freq data= data.Prebirth_all (where=(id EQ 1) ) ;
tables dad_pre_preg_I10*dadI10*dad_post_preg_I10 / list missing;
run;

data data.Prebirth_all;
set data.Prebirth_all;
dadI10period2 = .;
If dadI10 = 0 AND dad_pre_preg_I10 = 0 AND dad_post_preg_I10 = 0 THEN dadI10period2 = 0; * never;
else If dadI10 = 1 AND dad_pre_preg_I10 = 0 AND dad_post_preg_I10 = 0 THEN dadI10period2 = 1; * pregnancy only;
else If dadI10 = 0 AND dad_pre_preg_I10 = 1 AND dad_post_preg_I10 = 0 THEN dadI10period2 = 2; * pre-preg only;
else If dadI10 = 0 AND dad_pre_preg_I10 = 0 AND dad_post_preg_I10 = 1 THEN dadI10period2 = 3; * post-preg only;
else If dadI10 = 1 AND dad_pre_preg_I10 = 1 AND dad_post_preg_I10 = 0 THEN dadI10period2 = 4; * pregnancy and pre-preg;
else If dadI10 = 1 AND dad_pre_preg_I10 = 0 AND dad_post_preg_I10 = 1 THEN dadI10period2 = 4; * pregnancy and post-preg;
else If dadI10 = 0 AND dad_pre_preg_I10 = 1 AND dad_post_preg_I10 = 1 THEN dadI10period2 = 4; * pre-preg and post-preg;
else If dadI10 = 1 AND dad_pre_preg_I10 = 1 AND dad_post_preg_I10 = 1 THEN dadI10period2 = 4; * all periods;
run;

proc freq data= data.Prebirth_all;
tables dadI10period2;
run;





* dadI11 ;

proc freq data= data.Prebirth_all  ;
tables dad_pre_preg_I11*dadI11*dad_post_preg_I11 / list missing;
run;

proc freq data= data.Prebirth_all (where=(id EQ 1) ) ;
tables dad_pre_preg_I11*dadI11*dad_post_preg_I11 / list missing;
run;

data data.Prebirth_all;
set data.Prebirth_all;
dadI11period2 = .;
If dadI11 = 0 AND dad_pre_preg_I11 = 0 AND dad_post_preg_I11 = 0 THEN dadI11period2 = 0; * never;
else If dadI11 = 1 AND dad_pre_preg_I11 = 0 AND dad_post_preg_I11 = 0 THEN dadI11period2 = 1; * pregnancy only;
else If dadI11 = 0 AND dad_pre_preg_I11 = 1 AND dad_post_preg_I11 = 0 THEN dadI11period2 = 2; * pre-preg only;
else If dadI11 = 0 AND dad_pre_preg_I11 = 0 AND dad_post_preg_I11 = 1 THEN dadI11period2 = 3; * post-preg only;
else If dadI11 = 1 AND dad_pre_preg_I11 = 1 AND dad_post_preg_I11 = 0 THEN dadI11period2 = 4; * pregnancy and pre-preg;
else If dadI11 = 1 AND dad_pre_preg_I11 = 0 AND dad_post_preg_I11 = 1 THEN dadI11period2 = 4; * pregnancy and post-preg;
else If dadI11 = 0 AND dad_pre_preg_I11 = 1 AND dad_post_preg_I11 = 1 THEN dadI11period2 = 4; * pre-preg and post-preg;
else If dadI11 = 1 AND dad_pre_preg_I11 = 1 AND dad_post_preg_I11 = 1 THEN dadI11period2 = 4; * all periods;
run;

proc freq data= data.Prebirth_all;
tables dadI11period2;
run;






* dadI12 ;

proc freq data= data.Prebirth_all  ;
tables dad_pre_preg_I12*dadI12*dad_post_preg_I12 / list missing;
run;

proc freq data= data.Prebirth_all (where=(id EQ 1) ) ;
tables dad_pre_preg_I12*dadI12*dad_post_preg_I12 / list missing;
run;

data data.Prebirth_all;
set data.Prebirth_all;
dadI12period2 = .;
If dadI12 = 0 AND dad_pre_preg_I12 = 0 AND dad_post_preg_I12 = 0 THEN dadI12period2 = 0; * never;
else If dadI12 = 1 AND dad_pre_preg_I12 = 0 AND dad_post_preg_I12 = 0 THEN dadI12period2 = 1; * pregnancy only;
else If dadI12 = 0 AND dad_pre_preg_I12 = 1 AND dad_post_preg_I12 = 0 THEN dadI12period2 = 2; * pre-preg only;
else If dadI12 = 0 AND dad_pre_preg_I12 = 0 AND dad_post_preg_I12 = 1 THEN dadI12period2 = 3; * post-preg only;
else If dadI12 = 1 AND dad_pre_preg_I12 = 1 AND dad_post_preg_I12 = 0 THEN dadI12period2 = 4; * pregnancy and pre-preg;
else If dadI12 = 1 AND dad_pre_preg_I12 = 0 AND dad_post_preg_I12 = 1 THEN dadI12period2 = 4; * pregnancy and post-preg;
else If dadI12 = 0 AND dad_pre_preg_I12 = 1 AND dad_post_preg_I12 = 1 THEN dadI12period2 = 4; * pre-preg and post-preg;
else If dadI12 = 1 AND dad_pre_preg_I12 = 1 AND dad_post_preg_I12 = 1 THEN dadI12period2 = 4; * all periods;
run;

proc freq data= data.Prebirth_all;
tables dadI12period2;
run;





* dadI13 ;

proc freq data= data.Prebirth_all  ;
tables dad_pre_preg_I13*dadI13*dad_post_preg_I13 / list missing;
run;

proc freq data= data.Prebirth_all (where=(id EQ 1) ) ;
tables dad_pre_preg_I13*dadI13*dad_post_preg_I13 / list missing;
run;

data data.Prebirth_all;
set data.Prebirth_all;
dadI13period2 = .;
If dadI13 = 0 AND dad_pre_preg_I13 = 0 AND dad_post_preg_I13 = 0 THEN dadI13period2 = 0; * never;
else If dadI13 = 1 AND dad_pre_preg_I13 = 0 AND dad_post_preg_I13 = 0 THEN dadI13period2 = 1; * pregnancy only;
else If dadI13 = 0 AND dad_pre_preg_I13 = 1 AND dad_post_preg_I13 = 0 THEN dadI13period2 = 2; * pre-preg only;
else If dadI13 = 0 AND dad_pre_preg_I13 = 0 AND dad_post_preg_I13 = 1 THEN dadI13period2 = 3; * post-preg only;
else If dadI13 = 1 AND dad_pre_preg_I13 = 1 AND dad_post_preg_I13 = 0 THEN dadI13period2 = 4; * pregnancy and pre-preg;
else If dadI13 = 1 AND dad_pre_preg_I13 = 0 AND dad_post_preg_I13 = 1 THEN dadI13period2 = 4; * pregnancy and post-preg;
else If dadI13 = 0 AND dad_pre_preg_I13 = 1 AND dad_post_preg_I13 = 1 THEN dadI13period2 = 4; * pre-preg and post-preg;
else If dadI13 = 1 AND dad_pre_preg_I13 = 1 AND dad_post_preg_I13 = 1 THEN dadI13period2 = 4; * all periods;
run;

proc freq data= data.Prebirth_all;
tables dadI13period2;
run;








* dadI14 ;

proc freq data= data.Prebirth_all  ;
tables dad_pre_preg_I14*dadI14*dad_post_preg_I14 / list missing;
run;

proc freq data= data.Prebirth_all (where=(id EQ 1) ) ;
tables dad_pre_preg_I14*dadI14*dad_post_preg_I14 / list missing;
run;

data data.Prebirth_all;
set data.Prebirth_all;
dadI14period2 = .;
If dadI14 = 0 AND dad_pre_preg_I14 = 0 AND dad_post_preg_I14 = 0 THEN dadI14period2 = 0; * never;
else If dadI14 = 1 AND dad_pre_preg_I14 = 0 AND dad_post_preg_I14 = 0 THEN dadI14period2 = 1; * pregnancy only;
else If dadI14 = 0 AND dad_pre_preg_I14 = 1 AND dad_post_preg_I14 = 0 THEN dadI14period2 = 2; * pre-preg only;
else If dadI14 = 0 AND dad_pre_preg_I14 = 0 AND dad_post_preg_I14 = 1 THEN dadI14period2 = 3; * post-preg only;
else If dadI14 = 1 AND dad_pre_preg_I14 = 1 AND dad_post_preg_I14 = 0 THEN dadI14period2 = 4; * pregnancy and pre-preg;
else If dadI14 = 1 AND dad_pre_preg_I14 = 0 AND dad_post_preg_I14 = 1 THEN dadI14period2 = 4; * pregnancy and post-preg;
else If dadI14 = 0 AND dad_pre_preg_I14 = 1 AND dad_post_preg_I14 = 1 THEN dadI14period2 = 4; * pre-preg and post-preg;
else If dadI14 = 1 AND dad_pre_preg_I14 = 1 AND dad_post_preg_I14 = 1 THEN dadI14period2 = 4; * all periods;
run;

proc freq data= data.Prebirth_all;
tables dadI14period2;
run;











********************************************************************************************************************************************************* ;
* 	Trimester-specific variables excluding those exposed outside pregnancy
********************************************************************************************************************************************************* ;



proc freq data= data.Prebirth_all;
tables D4trim_1-D4trim_3 ;
run;

data data.Prebirth_all;
set data.Prebirth_all;
D4trim_1x = D4trim_1;
If momD4period > 1 THEN D4trim_1x = .; 
run;

data data.Prebirth_all;
set data.Prebirth_all;
D4trim_2x = D4trim_2;
If momD4period > 1 THEN D4trim_2x = .; 
run;

data data.Prebirth_all;
set data.Prebirth_all;
D4trim_3x = D4trim_3;
If momD4period > 1 THEN D4trim_3x = .; 
run;


proc freq data= data.Prebirth_all;
tables D4trim_1x-D4trim_3x ;
run;


data data.Prebirth_all;
set data.Prebirth_all;
D4trim = D4trim_1x;
If D4trim_2x = 1 THEN D4trim = 2;
else if D4trim_3x = 1 THEN D4trim = 3;
run;

proc freq data= data.Prebirth_all;
tables D4trim ;
run;


proc freq data= data.Prebirth_all;
tables D4trim*D4trim_2x ;
run;





********************************************************************************************************************************************************* ;
* 	For sex stratified analyses
********************************************************************************************************************************************************* ;


data data.Prebirth_all;
set data.Prebirth_all;
momD4periodbysex = .;
     If momD4period2 = 0 AND sex = 2 THEN momD4periodbysex = 0; * never female;
else If momD4period2 = 1 AND sex = 2 THEN momD4periodbysex = 1; * pregnancy only;
else If momD4period2 = 2 AND sex = 2 THEN momD4periodbysex = 2; * pre-preg only;
else If momD4period2 = 3 AND sex = 2 THEN momD4periodbysex = 3; * post-preg only;
else If momD4period2 = 4 AND sex = 2 THEN momD4periodbysex = 4; * pregnancy and pre-preg;
else If momD4period2 = 0 AND sex = 1 THEN momD4periodbysex = 5; * never male;
else If momD4period2 = 1 AND sex = 1 THEN momD4periodbysex = 6; * pregnancy only;
else If momD4period2 = 2 AND sex = 1 THEN momD4periodbysex = 7; * pre-preg only;
else If momD4period2 = 3 AND sex = 1 THEN momD4periodbysex = 8; * post-preg only;
else If momD4period2 = 4 AND sex = 1 THEN momD4periodbysex = 9; * pregnancy and pre-preg;
run;



data data.Prebirth_all;
set data.Prebirth_all;
dadD4periodbysex = .;
     If dadD4period2 = 0 AND sex = 2 THEN dadD4periodbysex = 0; * never female;
else If dadD4period2 = 1 AND sex = 2 THEN dadD4periodbysex = 1; * pregnancy only;
else If dadD4period2 = 2 AND sex = 2 THEN dadD4periodbysex = 2; * pre-preg only;
else If dadD4period2 = 3 AND sex = 2 THEN dadD4periodbysex = 3; * post-preg only;
else If dadD4period2 = 4 AND sex = 2 THEN dadD4periodbysex = 4; * pregnancy and pre-preg;
else If dadD4period2 = 0 AND sex = 1 THEN dadD4periodbysex = 5; * never male;
else If dadD4period2 = 1 AND sex = 1 THEN dadD4periodbysex = 6; * pregnancy only;
else If dadD4period2 = 2 AND sex = 1 THEN dadD4periodbysex = 7; * pre-preg only;
else If dadD4period2 = 3 AND sex = 1 THEN dadD4periodbysex = 8; * post-preg only;
else If dadD4period2 = 4 AND sex = 1 THEN dadD4periodbysex = 9; * pregnancy and pre-preg;
run;

PROC FREQ data=data.Prebirth_all;
tables momD4periodbysex dadD4periodbysex;
run;
