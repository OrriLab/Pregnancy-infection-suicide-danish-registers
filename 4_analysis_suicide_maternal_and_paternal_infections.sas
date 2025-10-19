* ==============================================================================================================================


						DESCRIPTIVE STATISTICS


* ============================================================================================================================== ;


proc freq data= data.Prebirth_all (where = (id EQ 1));
tables sui2;
run;


proc sort data= data.Prebirth_all ; 
by sex; 
run;

proc means data=data.Prebirth_all    NOPRINT;
var pyrs sui2;
by sex;
OUTPUT out=RESULTS.suicide_by_sex (drop=_TYPE_ _FREQ_) SUM(pyrs sui2) = pyrs sui2 ;
run;

data results.suicide_by_sex;
set results.suicide_by_sex;
variable = 'sex';
run;


*SAVE AS Excel file;
proc export data=results.suicide_by_sex
dbms=xlsx
outfile='E:\workdata\708082\MO\Paper_1_infections\RESULTS_infections\extract_suicide_by_sex'
replace;
run;



* *************************************************************************************************** 
*    SUICIDE  by EXPOSURE - CRUDE ASSOCIATIONS
* *************************************************************************************************** ;


* momD4 ;
proc sort data= data.Prebirth_all ; 
by momD4period2; 
run;

proc means data=data.Prebirth_all    NOPRINT;
var pyrs sui2;
by momD4period2;
OUTPUT out=RESULTS.suicide_by_momD4 (drop=_TYPE_ _FREQ_) SUM(pyrs sui2) = pyrs sui2 ;
run;

data results.suicide_by_momD4;
set results.suicide_by_momD4;
variable = 'momD4';
run;



* dadD4 ;
proc sort data= data.Prebirth_all ; 
by dadD4period2; 
run;

proc means data=data.Prebirth_all    NOPRINT;
var pyrs sui2;
by dadD4period2;
OUTPUT out=RESULTS.suicide_by_dadD4 (drop=_TYPE_ _FREQ_) SUM(pyrs sui2) = pyrs sui2 ;
run;

data results.suicide_by_dadD4;
set results.suicide_by_dadD4;
variable = 'dadD4';
run;





* bind by row the different aggregate files ;
data data.extract;
set results.suicide_by_momD4
	results.suicide_by_dadD4;
run;

*SAVE AS Excel file;
proc export data=data.extract
dbms=xlsx
outfile='E:\workdata\708082\MO\DATA\RESULTS\extract_suicide_by_momD4_dadD4'
replace;
run;




* *************************************************************************************************** 
*    SUICIDE by EXPOSURE - CRUDE ASSOCIATIONS
* *************************************************************************************************** ;


data results.suicide_by_momD4;
set results.suicide_by_momD4;
logpyrs = log(pyrs);
run; 



* momD4;
proc genmod data=results.suicide_by_momD4 ;
class momD4period2 /  ref=FIRST;
model sui2= momD4period2 /dist=poisson offset=logpyrs type3;
ods output PARAMETErestimates = RESULTS.estimates;
run;

data RESULTS.estimates_sui_momD4_M1_crude;
set RESULTS.estimates (where=(Parameter='momD4period2'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;




proc export data=RESULTS.estimates_sui_momd4_m1_crude
dbms=xlsx
outfile='E:\workdata\708082\MO\Paper_1_infections\RESULTS_infections\estimates_sui_momD4_M1_crude'
replace;
run;






* *************************************************************************************************** 
*    SUICIDE by EXPOSURE - ADJUSTED ASSOCIATIONS
* *************************************************************************************************** ;


* Adjusted models - momD4;


proc sort data= data.Prebirth_all ;
by sui2 sex newagegp2 newperiod2 teen_dad dad_alone low_parental_income any_parent_psyk dad_psych_med dadD5;
run;

proc means data=data.Prebirth_all (where=(fail_sa NE 999))  NOPRINT;
var pyrs fail_sa ;
by sui2 sex newagegp2 newperiod2 teen_dad dad_alone low_parental_income any_parent_psyk dad_psych_med dadD5;
OUTPUT out=aggregate_data (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa ) = pyrs fail_sa ;
run;

data aggregate_data;
set aggregate_data;
logpyrs = log(pyrs);
run;

proc genmod data=aggregate_data ;
class myvar /  ref=FIRST;
model fail_sa= sui2 sex newagegp2 newperiod2 teen_dad dad_alone low_parental_income any_parent_psyk dad_psych_med dadD5 /dist=poisson offset=logpyrs type3;
ods output PARAMETErestimates = RESULTS.estimates;
run;

data RESULTS.estimates_sui_momD4_M2_adjusted;
set RESULTS.estimates (where=(Parameter='myvar'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;

proc export data=RESULTS.estimates_sui_momD4_M2_adjusted
dbms=xlsx
outfile='E:\workdata\708082\MO\Paper_1_infections\RESULTS_infections\\estimates_sui_momD4_M2_adjusted'
replace;
run;

















