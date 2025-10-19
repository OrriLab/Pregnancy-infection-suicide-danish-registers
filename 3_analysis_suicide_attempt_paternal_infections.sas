


* *************************************************************************************************** 
*    SUICIDE ATTEMPT by EXPOSURE - DESCRIPTIVE
* *************************************************************************************************** ;


* dadD4 ;
proc sort data= data.Prebirth_all ; 
by dadD4period2; 
run;

proc means data=data.Prebirth_all (where=(fail_sa NE 999))   NOPRINT;
var pyrs fail_sa;
by dadD4period2;
OUTPUT out=RESULTS.attempt_by_dadD4 (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa ;
run;

data results.attempt_by_dadD4;
set results.attempt_by_dadD4;
variable = 'dadD4';
run;


* dadI1 ;
proc sort data= data.Prebirth_all ; 
by dadI1period2; 
run;

proc means data=data.Prebirth_all (where=(fail_sa NE 999))   NOPRINT;
var pyrs fail_sa;
by dadI1period2;
OUTPUT out=RESULTS.attempt_by_dadI1 (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa;
run;

data results.attempt_by_dadI1;
set results.attempt_by_dadI1;
variable = 'dadI1';
run;





* dadI4period2 ;
proc sort data= data.Prebirth_all ;
by dadI4period2;
run;

proc means data=data.Prebirth_all (where=(fail_sa NE 999))   NOPRINT;
var pyrs fail_sa;
by dadI4period2;
OUTPUT out=RESULTS.attempt_by_dadI4 (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa;
run;

data results.attempt_by_dadI4;
set results.attempt_by_dadI4;
variable = 'dadI4';
run;






* dadI5 ;
proc sort data= data.Prebirth_all ;
by dadI5period2;
run;

proc means data=data.Prebirth_all (where=(fail_sa NE 999))   NOPRINT;
var pyrs fail_sa;
by dadI5period2;
OUTPUT out=RESULTS.attempt_by_dadI5 (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa;
run;

data results.attempt_by_dadI5;
set results.attempt_by_dadI5;
variable = 'dadI5';
run;




* dadI6 ;
proc sort data= data.Prebirth_all ;
by dadI6period2;
run;

proc means data=data.Prebirth_all (where=(fail_sa NE 999))   NOPRINT;
var pyrs fail_sa;
by dadI6period2;
OUTPUT out=RESULTS.attempt_by_dadI6 (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa;
run;

data results.attempt_by_dadI6;
set results.attempt_by_dadI6;
variable = 'dadI6';
run;




* dadI7 ;
proc sort data= data.Prebirth_all ;
by dadI7period2;
run;

proc means data=data.Prebirth_all (where=(fail_sa NE 999))   NOPRINT;
var pyrs fail_sa;
by dadI7period2;
OUTPUT out=RESULTS.attempt_by_dadI7 (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa;
run;

data results.attempt_by_dadI7;
set results.attempt_by_dadI7;
variable = 'dadI7';
run;




* dadI8 ;
proc sort data= data.Prebirth_all ;
by dadI8period2;
run;

proc means data=data.Prebirth_all (where=(fail_sa NE 999))   NOPRINT;
var pyrs fail_sa;
by dadI8period2;
OUTPUT out=RESULTS.attempt_by_dadI8 (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa;
run;

data results.attempt_by_dadI8;
set results.attempt_by_dadI8;
variable = 'dadI8';
run;





* dadI12 ;
proc sort data= data.Prebirth_all ;
by dadI12period2;
run;

proc means data=data.Prebirth_all (where=(fail_sa NE 999))   NOPRINT;
var pyrs fail_sa;
by dadI12period2;
OUTPUT out=RESULTS.attempt_by_dadI12 (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa;
run;

data results.attempt_by_dadI12;
set results.attempt_by_dadI12;
variable = 'dadI12';
run;




* dadI13 ;
proc sort data= data.Prebirth_all ;
by dadI13period2;
run;

proc means data=data.Prebirth_all (where=(fail_sa NE 999))   NOPRINT;
var pyrs fail_sa;
by dadI13period2;
OUTPUT out=RESULTS.attempt_by_dadI13 (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa;
run;

data results.attempt_by_dadI13;
set results.attempt_by_dadI13;
variable = 'dadI13';
run;





* dadI14 ;
proc sort data= data.Prebirth_all ;
by dadI14period2;
run;

proc means data=data.Prebirth_all (where=(fail_sa NE 999))   NOPRINT;
var pyrs fail_sa;
by dadI14period2;
OUTPUT out=RESULTS.attempt_by_dadI14 (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa ;
run;

data results.attempt_by_dadI14;
set results.attempt_by_dadI14;
variable = 'dadI14';
run;





* bind by row the different aggregate files ;
data data.extract;
set results.attempt_by_dadD4
	results.attempt_by_dadI1
	results.attempt_by_dadI4
	results.attempt_by_dadI5
	results.attempt_by_dadI6
	results.attempt_by_dadI7
	results.attempt_by_dadI8
	results.attempt_by_dadI12
	results.attempt_by_dadI13
	results.attempt_by_dadI14;
run;

*SAVE AS Excel file;
proc export data=data.extract
dbms=xlsx
outfile='E:\workdata\708082\MO\Paper_1_infections\RESULTS_infections\extract_attempt_by_dadIx'
replace;
run;






* *************************************************************************************************** 
*    SUICIDE ATTEMPT by EXPOSURE - CRUDE ASSOCIATIONS
* *************************************************************************************************** ;


data results.attempt_by_dadD4;
set results.attempt_by_dadD4;
logpyrs = log(pyrs);
run;

data results.attempt_by_dadI1;
set results.attempt_by_dadI1;
logpyrs = log(pyrs);
run;

data results.attempt_by_dadI4;
set results.attempt_by_dadI4;
logpyrs = log(pyrs);
run;

data results.attempt_by_dadI5;
set results.attempt_by_dadI5;
logpyrs = log(pyrs);
run;

data results.attempt_by_dadI6;
set results.attempt_by_dadI6;
logpyrs = log(pyrs);
run;

data results.attempt_by_dadI7;
set results.attempt_by_dadI7;
logpyrs = log(pyrs);
run;

data results.attempt_by_dadI8;
set results.attempt_by_dadI8;
logpyrs = log(pyrs);
run;

data results.attempt_by_dadI12;
set results.attempt_by_dadI12;
logpyrs = log(pyrs);
run;

data results.attempt_by_dadI13;
set results.attempt_by_dadI13;
logpyrs = log(pyrs);
run;

data results.attempt_by_dadI14;
set results.attempt_by_dadI14;
logpyrs = log(pyrs);
run;





* dadD4;
proc genmod data=results.attempt_by_dadD4 ;
class dadD4period2 /  ref=FIRST;
model fail_sa= dadD4period2 /dist=poisson offset=logpyrs type3;
ods output PARAMETErestimates = RESULTS.estimates;
run;

data RESULTS.estimates_dadD4_M1_crude;
set RESULTS.estimates (where=(Parameter='dadD4period2'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;



* dadI1;
proc genmod data=results.attempt_by_dadI1 ;
class dadI1period2 /  ref=FIRST;
model fail_sa= dadI1period2 /dist=poisson offset=logpyrs type3;
ods output PARAMETErestimates = RESULTS.estimates;
run;

data RESULTS.estimates_dadI1_M1_crude;
set RESULTS.estimates (where=(Parameter='dadI1period2'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;


* dadI4;
proc genmod data=results.attempt_by_dadI4 ;
class dadI4period2 /  ref=FIRST;
model fail_sa= dadI4period2 /dist=poisson offset=logpyrs type3;
ods output PARAMETErestimates = RESULTS.estimates;
run;

data RESULTS.estimates_dadI4_M1_crude;
set RESULTS.estimates (where=(Parameter='dadI4period2'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;


* dadI5;
proc genmod data=results.attempt_by_dadI5 ;
class dadI5period2 /  ref=FIRST;
model fail_sa= dadI5period2 /dist=poisson offset=logpyrs type3;
ods output PARAMETErestimates = RESULTS.estimates;
run;

data RESULTS.estimates_dadI5_M1_crude;
set RESULTS.estimates (where=(Parameter='dadI5period2'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;


* dadI6;
proc genmod data=results.attempt_by_dadI6 ;
class dadI6period2 /  ref=FIRST;
model fail_sa= dadI6period2 /dist=poisson offset=logpyrs type3;
ods output PARAMETErestimates = RESULTS.estimates;
run;

data RESULTS.estimates_dadI6_M1_crude;
set RESULTS.estimates (where=(Parameter='dadI6period2'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;


* dadI7;
proc genmod data=results.attempt_by_dadI7 ;
class dadI7period2 /  ref=FIRST;
model fail_sa= dadI7period2 /dist=poisson offset=logpyrs type3;
ods output PARAMETErestimates = RESULTS.estimates;
run;

data RESULTS.estimates_dadI7_M1_crude;
set RESULTS.estimates (where=(Parameter='dadI7period2'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;


* dadI8;
proc genmod data=results.attempt_by_dadI8 ;
class dadI8period2 /  ref=FIRST;
model fail_sa= dadI8period2 /dist=poisson offset=logpyrs type3;
ods output PARAMETErestimates = RESULTS.estimates;
run;

data RESULTS.estimates_dadI8_M1_crude;
set RESULTS.estimates (where=(Parameter='dadI8period2'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;


* dadI12;
proc genmod data=results.attempt_by_dadI12 ;
class dadI12period2 /  ref=FIRST;
model fail_sa= dadI12period2 /dist=poisson offset=logpyrs type3;
ods output PARAMETErestimates = RESULTS.estimates;
run;

data RESULTS.estimates_dadI12_M1_crude;
set RESULTS.estimates (where=(Parameter='dadI12period2'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;


* dadI13;
proc genmod data=results.attempt_by_dadI13 ;
class dadI13period2 /  ref=FIRST;
model fail_sa= dadI13period2 /dist=poisson offset=logpyrs type3;
ods output PARAMETErestimates = RESULTS.estimates;
run;

data RESULTS.estimates_dadI13_M1_crude;
set RESULTS.estimates (where=(Parameter='dadI1period23'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;


* dadI14;
proc genmod data=results.attempt_by_dadI14 ;
class dadI14period2 /  ref=FIRST;
model fail_sa= dadI14period2 /dist=poisson offset=logpyrs type3;
ods output PARAMETErestimates = RESULTS.estimates;
run;

data RESULTS.estimates_dadI14_M1_crude;
set RESULTS.estimates (where=(Parameter='dadI14period2'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;







data data.extract;
length Parameter $20;
set results.estimates_dadD4_M1_crude
	results.estimates_dadI1_M1_crude
	results.estimates_dadI4_M1_crude
	results.estimates_dadI5_M1_crude
	results.estimates_dadI6_M1_crude
	results.estimates_dadI7_M1_crude
	results.estimates_dadI8_M1_crude
	results.estimates_dadI12_M1_crude
	results.estimates_dadI13_M1_crude
	results.estimates_dadI14_M1_crude;
run;


proc export data=data.extract
dbms=xlsx
outfile='E:\workdata\708082\MO\Paper_1_infections\RESULTS_infections\estimates_dadI_M1_crude'
replace;
run;










* *************************************************************************************************** 
*    SUICIDE ATTEMPT by EXPOSURE - ADJUSTED ASSOCIATIONS
* *************************************************************************************************** ;



* Adjusted models - dadD4;

data data.Prebirth_all;
set data.Prebirth_all;
myvar = dadD4period2;
run;

proc sort data= data.Prebirth_all ;
by myvar sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5;
run;

proc means data=data.Prebirth_all (where=(fail_sa NE 999))  NOPRINT;
var pyrs fail_sa ;
by myvar sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5;
OUTPUT out=aggregate_data (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa ) = pyrs fail_sa ;
run;

data aggregate_data;
set aggregate_data;
logpyrs = log(pyrs);
run;

proc genmod data=aggregate_data ;
class myvar /  ref=FIRST;
model fail_sa= myvar sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5 /dist=poisson offset=logpyrs type3;
ods output PARAMETErestimates = RESULTS.estimates;
run;

data RESULTS.estimates_dadD4_M2_adjusted;
set RESULTS.estimates (where=(Parameter='myvar'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;




* Adjusted models - dadI1;

data data.Prebirth_all;
set data.Prebirth_all;
myvar = dadI1period2;
run;

proc sort data= data.Prebirth_all ;
by myvar sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5;
run;

proc means data=data.Prebirth_all (where=(fail_sa NE 999))  NOPRINT;
var pyrs fail_sa ;
by myvar sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5;
OUTPUT out=aggregate_data (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa ) = pyrs fail_sa ;
run;

data aggregate_data;
set aggregate_data;
logpyrs = log(pyrs);
run;

proc genmod data=aggregate_data ;
class myvar /  ref=FIRST;
model fail_sa= myvar sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5 /dist=poisson offset=logpyrs type3;
ods output PARAMETErestimates = RESULTS.estimates;
run;

data RESULTS.estimates_dadI1_M2_adjusted;
set RESULTS.estimates (where=(Parameter='myvar'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;




* Adjusted models - dadI4;
data data.Prebirth_all;
set data.Prebirth_all;
myvar = dadI4period2;
run;

proc sort data= data.Prebirth_all ;
by myvar sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5;
run;

proc means data=data.Prebirth_all (where=(fail_sa NE 999))  NOPRINT;
var pyrs fail_sa ;
by myvar sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5;
OUTPUT out=aggregate_data (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa ) = pyrs fail_sa ;
run;

data aggregate_data;
set aggregate_data;
logpyrs = log(pyrs);
run;

proc genmod data=aggregate_data ;
class myvar /  ref=FIRST;
model fail_sa= myvar sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5 /dist=poisson offset=logpyrs type3;
ods output PARAMETErestimates = RESULTS.estimates;
run;

data RESULTS.estimates_dadI4_M2_adjusted;
set RESULTS.estimates (where=(Parameter='myvar'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;



* Adjusted models - dadI5;
data data.Prebirth_all;
set data.Prebirth_all;
myvar = dadI5period2;
run;

proc sort data= data.Prebirth_all ;
by myvar sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5;
run;

proc means data=data.Prebirth_all (where=(fail_sa NE 999))  NOPRINT;
var pyrs fail_sa ;
by myvar sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5;
OUTPUT out=aggregate_data (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa ) = pyrs fail_sa ;
run;

data aggregate_data;
set aggregate_data;
logpyrs = log(pyrs);
run;

proc genmod data=aggregate_data ;
class myvar /  ref=FIRST;
model fail_sa= myvar sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5 /dist=poisson offset=logpyrs type3;
ods output PARAMETErestimates = RESULTS.estimates;
run;

data RESULTS.estimates_dadI5_M2_adjusted;
set RESULTS.estimates (where=(Parameter='myvar'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;


* Adjusted models - dadI6;
data data.Prebirth_all;
set data.Prebirth_all;
myvar = dadI6period2;
run;

proc sort data= data.Prebirth_all ;
by myvar sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5;
run;

proc means data=data.Prebirth_all (where=(fail_sa NE 999))  NOPRINT;
var pyrs fail_sa ;
by myvar sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5;
OUTPUT out=aggregate_data (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa ) = pyrs fail_sa ;
run;

data aggregate_data;
set aggregate_data;
logpyrs = log(pyrs);
run;

proc genmod data=aggregate_data ;
class myvar /  ref=FIRST;
model fail_sa= myvar sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5 /dist=poisson offset=logpyrs type3;
ods output PARAMETErestimates = RESULTS.estimates;
run;

data RESULTS.estimates_dadI6_M2_adjusted;
set RESULTS.estimates (where=(Parameter='myvar'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;


* Adjusted models - dadI7;
data data.Prebirth_all;
set data.Prebirth_all;
myvar = dadI7period2;
run;

proc sort data= data.Prebirth_all ;
by myvar sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5;
run;

proc means data=data.Prebirth_all (where=(fail_sa NE 999))  NOPRINT;
var pyrs fail_sa ;
by myvar sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5;
OUTPUT out=aggregate_data (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa ) = pyrs fail_sa ;
run;

data aggregate_data;
set aggregate_data;
logpyrs = log(pyrs);
run;

proc genmod data=aggregate_data ;
class myvar /  ref=FIRST;
model fail_sa= myvar sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5 /dist=poisson offset=logpyrs type3;
ods output PARAMETErestimates = RESULTS.estimates;
run;

data RESULTS.estimates_dadI7_M2_adjusted;
set RESULTS.estimates (where=(Parameter='myvar'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;


* Adjusted models - dadI8;
data data.Prebirth_all;
set data.Prebirth_all;
myvar = dadI8period2;
run;

proc sort data= data.Prebirth_all ;
by myvar sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5;
run;

proc means data=data.Prebirth_all (where=(fail_sa NE 999))  NOPRINT;
var pyrs fail_sa ;
by myvar sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5;
OUTPUT out=aggregate_data (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa ) = pyrs fail_sa ;
run;

data aggregate_data;
set aggregate_data;
logpyrs = log(pyrs);
run;

proc genmod data=aggregate_data ;
class myvar /  ref=FIRST;
model fail_sa= myvar sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5 /dist=poisson offset=logpyrs type3;
ods output PARAMETErestimates = RESULTS.estimates;
run;

data RESULTS.estimates_dadI8_M2_adjusted;
set RESULTS.estimates (where=(Parameter='myvar'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;



* Adjusted models - dadD12;
data data.Prebirth_all;
set data.Prebirth_all;
myvar = dadI12period2;
run;

proc sort data= data.Prebirth_all ;
by myvar sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5;
run;

proc means data=data.Prebirth_all (where=(fail_sa NE 999))  NOPRINT;
var pyrs fail_sa ;
by myvar sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5;
OUTPUT out=aggregate_data (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa ) = pyrs fail_sa ;
run;

data aggregate_data;
set aggregate_data;
logpyrs = log(pyrs);
run;

proc genmod data=aggregate_data ;
class myvar /  ref=FIRST;
model fail_sa= myvar sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5 /dist=poisson offset=logpyrs type3;
ods output PARAMETErestimates = RESULTS.estimates;
run;

data RESULTS.estimates_dadI12_M2_adjusted;
set RESULTS.estimates (where=(Parameter='myvar'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;



* Adjusted models - dadI13;
data data.Prebirth_all;
set data.Prebirth_all;
myvar = dadI13period2;
run;

proc sort data= data.Prebirth_all ;
by myvar sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5;
run;

proc means data=data.Prebirth_all (where=(fail_sa NE 999))  NOPRINT;
var pyrs fail_sa ;
by myvar sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5;
OUTPUT out=aggregate_data (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa ) = pyrs fail_sa ;
run;

data aggregate_data;
set aggregate_data;
logpyrs = log(pyrs);
run;

proc genmod data=aggregate_data ;
class myvar /  ref=FIRST;
model fail_sa= myvar sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5 /dist=poisson offset=logpyrs type3;
ods output PARAMETErestimates = RESULTS.estimates;
run;

data RESULTS.estimates_dadI13_M2_adjusted;
set RESULTS.estimates (where=(Parameter='myvar'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;



* Adjusted models - dadI14;
data data.Prebirth_all;
set data.Prebirth_all;
myvar = dadI14period2;
run;

proc sort data= data.Prebirth_all ;
by myvar sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5;
run;

proc means data=data.Prebirth_all (where=(fail_sa NE 999))  NOPRINT;
var pyrs fail_sa ;
by myvar sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5;
OUTPUT out=aggregate_data (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa ) = pyrs fail_sa ;
run;

data aggregate_data;
set aggregate_data;
logpyrs = log(pyrs);
run;

proc genmod data=aggregate_data ;
class myvar /  ref=FIRST;
model fail_sa= myvar sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5 /dist=poisson offset=logpyrs type3;
ods output PARAMETErestimates = RESULTS.estimates;
run;

data RESULTS.estimates_dadI14_M2_adjusted;
set RESULTS.estimates (where=(Parameter='myvar'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;





data data.extract;
set results.estimates_dadD4_M2_adjusted
	results.estimates_dadI1_M2_adjusted
	results.estimates_dadI4_M2_adjusted
	results.estimates_dadI5_M2_adjusted
	results.estimates_dadI6_M2_adjusted
	results.estimates_dadI7_M2_adjusted
	results.estimates_dadI8_M2_adjusted
	results.estimates_dadI12_M2_adjusted
	results.estimates_dadI13_M2_adjusted
	results.estimates_dadI14_M2_adjusted;
run;


proc export data=data.extract
dbms=xlsx
outfile='E:\workdata\708082\MO\Paper_1_infections\RESULTS_infections\estimates_dadI_M2_adjusted'
replace;
run;







* requested by Reviewer: sex age period mom_age_birth dad_age_birth low_parental_income any_parent_psyk mom_psych_med momD5;

data data.Prebirth_all;
set data.Prebirth_all;
myvar = dadD4period2;
run;

proc sort data= data.Prebirth_all ;
by myvar sex age period mom_age_birth dad_age_birth low_parental_income any_parent_psyk mom_psych_med momD5;
run;

proc means data=data.Prebirth_all (where=(fail_sa NE 999))  NOPRINT;
var pyrs fail_sa ;
by myvar sex age period mom_age_birth dad_age_birth low_parental_income any_parent_psyk mom_psych_med momD5;
OUTPUT out=aggregate_data (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa ) = pyrs fail_sa ;
run;

data aggregate_data;
set aggregate_data;
logpyrs = log(pyrs);
run;

proc genmod data=aggregate_data ;
class myvar /  ref=FIRST;
model fail_sa= myvar sex age period mom_age_birth dad_age_birth low_parental_income any_parent_psyk mom_psych_med momD5 /dist=poisson offset=logpyrs type3;
ods output PARAMETErestimates = RESULTS.estimates;
run;

data RESULTS.estimates_dadD4_M2_adj_reviewer;
set RESULTS.estimates (where=(Parameter='myvar'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;


proc export data=RESULTS.estimates_dadD4_M2_adj_reviewer
dbms=xlsx
outfile='E:\workdata\708082\MO\Paper_1_infections\RESULTS_infections\estimates_dadD4_M2_adjusted_reviewer_req'
replace;
run;







*************************************************************************************************


	Sex-stratified analysis analysis


*************************************************************************************************;




* rates;

proc sort data= data.Prebirth_all ; 
by dadD4periodbysex; 
run;

proc means data=data.Prebirth_all (where=(fail_sa NE 999))   NOPRINT;
var pyrs fail_sa;
by dadD4periodbysex;
OUTPUT out=RESULTS.attempt_by_dadD4sex (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa ;
run;


* ==> n are too low ;
