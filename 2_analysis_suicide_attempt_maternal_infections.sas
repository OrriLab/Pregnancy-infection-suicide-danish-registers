* ==============================================================================================================================


						DESCRIPTIVE STATISTICS


* ============================================================================================================================== ;


proc freq data= data.Prebirth_all (where=(fail_sa NE 999) ) ;
tables fail_sa;
run;

proc freq data= data.prebirth_all_temp (where = (id EQ 1));
tables sex mom_alone low_parental_income newagegp2 newperiod2 teen_mom lbw prematurity any_parent_psyk;
run;


proc freq data= data.prebirth_all_temp (where = (id EQ 1));
tables sex;
run;

proc freq data= data.prebirth_all_temp(where=(id EQ 1) ) ;
tables momD4x momI1x momI4x-momI8x momI12x-momI14x;
run;

proc freq data= data.prebirth_all_temp(where=(id EQ 1) ) ;
tables mom_pre_preg_D4x mom_pre_preg_I1x mom_pre_preg_I4x-mom_pre_preg_I8x mom_pre_preg_I12x-mom_pre_preg_I14x;
run;

proc freq data= data.prebirth_all_temp(where=(id EQ 1) ) ;
tables mom_post_preg_D4x mom_post_preg_I1x mom_post_preg_I4x-mom_post_preg_I8x mom_post_preg_I12x-mom_post_preg_I14x;
run;

proc means data=data.ch MIN MEDIAN MAX P25 P75;
var age_end;
run;

proc freq data=data.prebirth_all_temp (where=(id EQ 1));
tables sex*fail_sa;
run;



* *************************************************************************************************** 
*    SUICIDE ATTEMPT by COVARIATES
* ***************************************************************************************************

*** Suicide attempt by SEX and by exposure ******************** ;

* set the byVaraible ; 
data data.Prebirth_all;
set data.Prebirth_all;
byVariable = sex;
run;

* sort data ;
proc sort data= data.Prebirth_all ;
by byVariable;
run;

* aggregate by sex - all sample;
proc means data=data.Prebirth_all (where=(fail_sa NE 999) )  NOPRINT;
var pyrs fail_sa;
by byVariable;
OUTPUT out=RESULTS.attempt_by_sex (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa;
run;

data results.attempt_by_sex;
set results.attempt_by_sex;
exposureStatus = 'all';
variable = 'sex';
run;

* aggregate by sex - exposed;
proc means data=data.Prebirth_all (where=(fail_sa NE 999 AND momD4x = 1) )  NOPRINT;
var pyrs fail_sa;
by byVariable;
OUTPUT out=RESULTS.attempt_by_sex_ex (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa;
run;

data results.attempt_by_sex_ex;
set results.attempt_by_sex_ex;
exposureStatus = 'yes';
variable = 'sex';
run;

* aggregate by sex - nonexposed;
proc means data=data.Prebirth_all (where=(fail_sa NE 999 AND momD4x = 0) )  NOPRINT;
var pyrs fail_sa;
by byVariable;
OUTPUT out=RESULTS.attempt_by_sex_nex (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa;
run;

data results.attempt_by_sex_nex;
set results.attempt_by_sex_nex;
exposureStatus = 'no';
variable = 'sex';
run;



*** Suicide attempt by AGE and by exposure ******************** ;

* set the byVaraible ; 
data data.Prebirth_all;
set data.Prebirth_all;
byVariable = newagegp2;
run;

* sort data ;
proc sort data= data.Prebirth_all ;
by byVariable;
run;

* aggregate - all sample;
proc means data=data.Prebirth_all (where=(fail_sa NE 999) )  NOPRINT;
var pyrs fail_sa;
by byVariable;
OUTPUT out=RESULTS.attempt_by_age (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa;
run;

data results.attempt_by_age;
set results.attempt_by_age;
exposureStatus = 'all';
variable = 'age';
run;

* aggregate - exposed;
proc means data=data.Prebirth_all (where=(fail_sa NE 999 AND momD4x = 1) )  NOPRINT;
var pyrs fail_sa;
by byVariable;
OUTPUT out=RESULTS.attempt_by_age_ex (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa;
run;

data results.attempt_by_age_ex;
set results.attempt_by_age_ex;
exposureStatus = 'yes';
variable = 'age';
run;

* aggregate - nonexposed;
proc means data=data.Prebirth_all (where=(fail_sa NE 999 AND momD4x = 0) )  NOPRINT;
var pyrs fail_sa;
by byVariable;
OUTPUT out=RESULTS.attempt_by_age_nex (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa ;
run;

data results.attempt_by_age_nex;
set results.attempt_by_age_nex;
exposureStatus = 'no';
variable = 'age';
run;




*** Suicide attempt by PERIOD and by exposure ******************** ;

* set the byVaraible ; 
data data.Prebirth_all;
set data.Prebirth_all;
byVariable = newperiod2;
run;

* sort data ;
proc sort data= data.Prebirth_all ;
by byVariable;
run;

* aggregate - all sample;
proc means data=data.Prebirth_all (where=(fail_sa NE 999) )  NOPRINT;
var pyrs fail_sa;
by byVariable;
OUTPUT out=RESULTS.attempt_by_period (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa ;
run;

data results.attempt_by_period;
set results.attempt_by_period;
exposureStatus = 'all';
variable = 'period';
run;

* aggregate - exposed;
proc means data=data.Prebirth_all (where=(fail_sa NE 999 AND momD4x = 1) )  NOPRINT;
var pyrs fail_sa;
by byVariable;
OUTPUT out=RESULTS.attempt_by_period_ex (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa;
run;

data results.attempt_by_period_ex;
set results.attempt_by_period_ex;
exposureStatus = 'yes';
variable = 'period';
run;

* aggregate - nonexposed;
proc means data=data.Prebirth_all (where=(fail_sa NE 999 AND momD4x = 0) )  NOPRINT;
var pyrs fail_sa;
by byVariable;
OUTPUT out=RESULTS.attempt_by_period_nex (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa;
run;

data results.attempt_by_period_nex;
set results.attempt_by_period_nex;
exposureStatus = 'no';
variable = 'period';
run;





*** Suicide attempt by BIRTH WEIGHT and by exposure ******************** ;

* set the byVaraible ; 
data data.Prebirth_all;
set data.Prebirth_all;
byVariable = lbw;
run;

* sort data ;
proc sort data= data.Prebirth_all ;
by byVariable;
run;

* aggregate - all sample ;
proc means data=data.Prebirth_all (where=(fail_sa NE 999) )  NOPRINT;
var pyrs fail_sa;
by byVariable;
OUTPUT out=RESULTS.attempt_by_lbw (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa ;
run;

data results.attempt_by_lbw;
set results.attempt_by_lbw;
exposureStatus = 'all';
variable = 'lbw';
run;

* aggregate - exposed ;
proc means data=data.Prebirth_all (where=(fail_sa NE 999 AND momD4x = 1) )  NOPRINT;
var pyrs fail_sa;
by byVariable;
OUTPUT out=RESULTS.attempt_by_lbw_ex (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa ;
run;

data results.attempt_by_lbw_ex;
set results.attempt_by_lbw_ex;
exposureStatus = 'yes';
variable = 'lbw';
run;

* aggregate - nonexposed ;
proc means data=data.Prebirth_all (where=(fail_sa NE 999 AND momD4x = 0) )  NOPRINT;
var pyrs fail_sa;
by byVariable;
OUTPUT out=RESULTS.attempt_by_lbw_nex (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa;
run;

data results.attempt_by_lbw_nex;
set results.attempt_by_lbw_nex;
exposureStatus = 'no';
variable = 'lbw';
run;




*** Suicide attempt by PREMATURITY and by exposure ******************** ;

* set the byVaraible ; 
data data.Prebirth_all;
set data.Prebirth_all;
byVariable = prematurity;
run;

* sort data ;
proc sort data= data.Prebirth_all ;
by byVariable;
run;

* aggregate - all sample ;
proc means data=data.Prebirth_all (where=(fail_sa NE 999) )  NOPRINT;
var pyrs fail_sa;
by byVariable;
OUTPUT out=RESULTS.attempt_by_pre (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa ;
run;

data results.attempt_by_pre;
set results.attempt_by_pre;
exposureStatus = 'all';
variable = 'pre';
run;

* aggregate - exposed ;
proc means data=data.Prebirth_all (where=(fail_sa NE 999 AND momD4x = 1) )  NOPRINT;
var pyrs fail_sa;
by byVariable;
OUTPUT out=RESULTS.attempt_by_pre_ex (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa ;
run;

data results.attempt_by_pre_ex;
set results.attempt_by_pre_ex;
exposureStatus = 'yes';
variable = 'pre';
run;

* aggregate - nonexposed ;
proc means data=data.Prebirth_all (where=(fail_sa NE 999 AND momD4x = 0) )  NOPRINT;
var pyrs fail_sa;
by byVariable;
OUTPUT out=RESULTS.attempt_by_pre_nex (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa;
run;

data results.attempt_by_pre_nex;
set results.attempt_by_pre_nex;
exposureStatus = 'no';
variable = 'pre';
run;





*** Suicide attempt by TEEN MOM and by exposure ******************** ;

* set the byVaraible ; 
data data.Prebirth_all;
set data.Prebirth_all;
byVariable = teen_mom;
run;

* sort data ;
proc sort data= data.Prebirth_all ;
by byVariable;
run;

* aggregate - all sample ;
proc means data=data.Prebirth_all (where=(fail_sa NE 999) )  NOPRINT;
var pyrs fail_sa;
by byVariable;
OUTPUT out=RESULTS.attempt_by_tee (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa ;
run;

data results.attempt_by_tee;
set results.attempt_by_tee;
exposureStatus = 'all';
variable = 'tee';
run;

* aggregate - exposed ;
proc means data=data.Prebirth_all (where=(fail_sa NE 999 AND momD4x = 1) )  NOPRINT;
var pyrs fail_sa;
by byVariable;
OUTPUT out=RESULTS.attempt_by_tee_ex (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa ;
run;

data results.attempt_by_tee_ex;
set results.attempt_by_tee_ex;
exposureStatus = 'yes';
variable = 'tee';
run;

* aggregate - nonexposed ;
proc means data=data.Prebirth_all (where=(fail_sa NE 999 AND momD4x = 0) )  NOPRINT;
var pyrs fail_sa;
by byVariable;
OUTPUT out=RESULTS.attempt_by_tee_nex (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa ;
run;

data results.attempt_by_tee_nex;
set results.attempt_by_tee_nex;
exposureStatus = 'no';
variable = 'tee';
run;






*** Suicide attempt by MOM ALONE and by exposure ******************** ;

* set the byVaraible ; 
data data.Prebirth_all;
set data.Prebirth_all;
byVariable = mom_alone;
run;

* sort data ;
proc sort data= data.Prebirth_all ;
by byVariable;
run;

* aggregate - all sample;
proc means data=data.Prebirth_all (where=(fail_sa NE 999) )  NOPRINT;
var pyrs fail_sa;
by byVariable;
OUTPUT out=RESULTS.attempt_by_mal (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa;
run;

data results.attempt_by_mal;
set results.attempt_by_mal;
exposureStatus = 'all';
variable = 'mal';
run;

* aggregate - exposed;
proc means data=data.Prebirth_all (where=(fail_sa NE 999 AND momD4x = 1) )  NOPRINT;
var pyrs fail_sa;
by byVariable;
OUTPUT out=RESULTS.attempt_by_mal_ex (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa;
run;

data results.attempt_by_mal_ex;
set results.attempt_by_mal_ex;
exposureStatus = 'yes';
variable = 'mal';
run;

* aggregate - nonexposed;
proc means data=data.Prebirth_all (where=(fail_sa NE 999 AND momD4x = 0) )  NOPRINT;
var pyrs fail_sa;
by byVariable;
OUTPUT out=RESULTS.attempt_by_mal_nex (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa;
run;

data results.attempt_by_mal_nex;
set results.attempt_by_mal_nex;
exposureStatus = 'no';
variable = 'mal';
run;






*** Suicide attempt by PARENTAL INCOME and by exposure ******************** ;

* set the byVaraible ; 
data data.Prebirth_all;
set data.Prebirth_all;
byVariable = low_parental_income;
run;

* sort data ;
proc sort data= data.Prebirth_all ;
by byVariable;
run;

* aggregate - all sample;
proc means data=data.Prebirth_all (where=(fail_sa NE 999) )  NOPRINT;
var pyrs fail_sa;
by byVariable;
OUTPUT out=RESULTS.attempt_by_inc (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa ;
run;

data results.attempt_by_inc;
set results.attempt_by_inc;
exposureStatus = 'all';
variable = 'inc';
run;

* aggregate - exposed;
proc means data=data.Prebirth_all (where=(fail_sa NE 999 AND momD4x = 1) )  NOPRINT;
var pyrs fail_sa;
by byVariable;
OUTPUT out=RESULTS.attempt_by_inc_ex (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa;
run;

data results.attempt_by_inc_ex;
set results.attempt_by_inc_ex;
exposureStatus = 'yes';
variable = 'inc';
run;

* aggregate - nonexposed;
proc means data=data.Prebirth_all (where=(fail_sa NE 999 AND momD4x = 0) )  NOPRINT;
var pyrs fail_sa;
by byVariable;
OUTPUT out=RESULTS.attempt_by_inc_nex (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa ;
run;

data results.attempt_by_inc_nex;
set results.attempt_by_inc_nex;
exposureStatus = 'no';
variable = 'inc';
run;





*** Suicide attempt by ANY PARENTS WITH MENTAL DISORDER and by exposure ******************** ;

* set the byVaraible ; 
data data.Prebirth_all;
set data.Prebirth_all;
byVariable = any_parent_psyk;
run;

* sort data ;
proc sort data= data.Prebirth_all ;
by byVariable;
run;

* aggregate - all sample;
proc means data=data.Prebirth_all (where=(fail_sa NE 999) )  NOPRINT;
var pyrs fail_sa;
by byVariable;
OUTPUT out=RESULTS.attempt_by_pps (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa ;
run;

data results.attempt_by_pps;
set results.attempt_by_pps;
exposureStatus = 'all';
variable = 'pps';
run;

* aggregate - exposed;
proc means data=data.Prebirth_all (where=(fail_sa NE 999 AND momD4x = 1) )  NOPRINT;
var pyrs fail_sa;
by byVariable;
OUTPUT out=RESULTS.attempt_by_pps_ex (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa ;
run;

data results.attempt_by_pps_ex;
set results.attempt_by_pps_ex;
exposureStatus = 'yes';
variable = 'pps';
run;

* aggregate - nonexposed;
proc means data=data.Prebirth_all (where=(fail_sa NE 999 AND momD4x = 0) )  NOPRINT;
var pyrs fail_sa;
by byVariable;
OUTPUT out=RESULTS.attempt_by_pps_nex (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa ;
run;

data results.attempt_by_pps_nex;
set results.attempt_by_pps_nex;
exposureStatus = 'no';
variable = 'pps';
run;





*** Suicide attempt by ANY MATERNAL PSYCH MEDICATION and by exposure ******************** ;

* set the byVaraible ; 
data data.Prebirth_all;
set data.Prebirth_all;
byVariable = mom_psych_med;
run;

* sort data ;
proc sort data= data.Prebirth_all ;
by byVariable;
run;

* aggregate - all sample;
proc means data=data.Prebirth_all (where=(fail_sa NE 999) )  NOPRINT;
var pyrs fail_sa;
by byVariable;
OUTPUT out=RESULTS.attempt_by_med (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa ;
run;

data results.attempt_by_med;
set results.attempt_by_med;
exposureStatus = 'all';
variable = 'med';
run;

* aggregate - exposed;
proc means data=data.Prebirth_all (where=(fail_sa NE 999 AND momD4x = 1) )  NOPRINT;
var pyrs fail_sa;
by byVariable;
OUTPUT out=RESULTS.attempt_by_med_ex (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa ;
run;

data results.attempt_by_med_ex;
set results.attempt_by_med_ex;
exposureStatus = 'yes';
variable = 'med';
run;

* aggregate - nonexposed;
proc means data=data.Prebirth_all (where=(fail_sa NE 999 AND momD4x = 0) )  NOPRINT;
var pyrs fail_sa;
by byVariable;
OUTPUT out=RESULTS.attempt_by_med_nex (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa ;
run;

data results.attempt_by_med_nex;
set results.attempt_by_med_nex;
exposureStatus = 'no';
variable = 'med';
run;







*** Suicide attempt by MATERNAL AUTOIMMUNE and by exposure ******************** ;

* set the byVaraible ; 
data data.Prebirth_all;
set data.Prebirth_all;
byVariable = momD5;
run;

* sort data ;
proc sort data= data.Prebirth_all ;
by byVariable;
run;

* aggregate - all sample;
proc means data=data.Prebirth_all (where=(fail_sa NE 999) )  NOPRINT;
var pyrs fail_sa;
by byVariable;
OUTPUT out=RESULTS.attempt_by_aut (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa ;
run;

data results.attempt_by_aut;
set results.attempt_by_aut;
exposureStatus = 'all';
variable = 'aut';
run;

* aggregate - exposed;
proc means data=data.Prebirth_all (where=(fail_sa NE 999 AND momD4x = 1) )  NOPRINT;
var pyrs fail_sa;
by byVariable;
OUTPUT out=RESULTS.attempt_by_aut_ex (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa ;
run;

data results.attempt_by_aut_ex;
set results.attempt_by_aut_ex;
exposureStatus = 'yes';
variable = 'aut';
run;

* aggregate - nonexposed;
proc means data=data.Prebirth_all (where=(fail_sa NE 999 AND momD4x = 0) )  NOPRINT;
var pyrs fail_sa;
by byVariable;
OUTPUT out=RESULTS.attempt_by_aut_nex (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa ;
run;

data results.attempt_by_aut_nex;
set results.attempt_by_aut_nex;
exposureStatus = 'no';
variable = 'aut';
run;





* ************************************************************ ;
* Export all results 
* ************************************************************ ;

* bind by row the different aggregate files ;
data data.extract;
set results.attempt_by_sex
    results.attempt_by_sex_ex
	results.attempt_by_sex_nex

	results.attempt_by_mal
	results.attempt_by_mal_ex
	results.attempt_by_mal_nex
	
	results.attempt_by_inc
	results.attempt_by_inc_ex
	results.attempt_by_inc_nex

	results.attempt_by_age
	results.attempt_by_age_ex
	results.attempt_by_age_nex

	results.attempt_by_period
	results.attempt_by_period_ex
	results.attempt_by_period_nex
	
	results.attempt_by_tee
	results.attempt_by_tee_ex
	results.attempt_by_tee_nex

	results.attempt_by_lbw
	results.attempt_by_lbw_ex
	results.attempt_by_lbw_nex
	
	results.attempt_by_pre
	results.attempt_by_pre_ex
	results.attempt_by_pre_nex

	results.attempt_by_pps
	results.attempt_by_pps_ex
	results.attempt_by_pps_nex

	results.attempt_by_med
	results.attempt_by_med_ex
	results.attempt_by_med_nex
	
	results.attempt_by_aut
	results.attempt_by_aut_ex
	results.attempt_by_aut_nex
;
run;


*SAVE AS Excel file;
proc export data=data.extract
dbms=xlsx
outfile='E:\workdata\708082\MO\Paper_1_infections\RESULTS_infections\extract_attempt'
replace;
run;







* *************************************************************************************************** 
*    SUICIDE ATTEMPT by EXPOSURE - DESCRIPTIVE
* *************************************************************************************************** ;


* momD4 ;
proc sort data= data.Prebirth_all ; 
by momD4period2; 
run;

proc means data=data.Prebirth_all (where=(fail_sa NE 999))   NOPRINT;
var pyrs fail_sa;
by momD4period2;
OUTPUT out=RESULTS.attempt_by_momD4 (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa ;
run;

data results.attempt_by_momD4;
set results.attempt_by_momD4;
variable = 'momD4';
run;


* momI1 ;
proc sort data= data.Prebirth_all ; 
by momI1period2; 
run;

proc means data=data.Prebirth_all (where=(fail_sa NE 999))   NOPRINT;
var pyrs fail_sa;
by momI1period2;
OUTPUT out=RESULTS.attempt_by_momI1 (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa;
run;

data results.attempt_by_momI1;
set results.attempt_by_momI1;
variable = 'momI1';
run;





* momI4period2 ;
proc sort data= data.Prebirth_all ;
by momI4period2;
run;

proc means data=data.Prebirth_all (where=(fail_sa NE 999))   NOPRINT;
var pyrs fail_sa;
by momI4period2;
OUTPUT out=RESULTS.attempt_by_momI4 (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa;
run;

data results.attempt_by_momI4;
set results.attempt_by_momI4;
variable = 'momI4';
run;






* momI5 ;
proc sort data= data.Prebirth_all ;
by momI5period2;
run;

proc means data=data.Prebirth_all (where=(fail_sa NE 999))   NOPRINT;
var pyrs fail_sa;
by momI5period2;
OUTPUT out=RESULTS.attempt_by_momI5 (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa;
run;

data results.attempt_by_momI5;
set results.attempt_by_momI5;
variable = 'momI5';
run;




* momI6 ;
proc sort data= data.Prebirth_all ;
by momI6period2;
run;

proc means data=data.Prebirth_all (where=(fail_sa NE 999))   NOPRINT;
var pyrs fail_sa;
by momI6period2;
OUTPUT out=RESULTS.attempt_by_momI6 (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa;
run;

data results.attempt_by_momI6;
set results.attempt_by_momI6;
variable = 'momI6';
run;




* momI7 ;
proc sort data= data.Prebirth_all ;
by momI7period2;
run;

proc means data=data.Prebirth_all (where=(fail_sa NE 999))   NOPRINT;
var pyrs fail_sa;
by momI7period2;
OUTPUT out=RESULTS.attempt_by_momI7 (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa;
run;

data results.attempt_by_momI7;
set results.attempt_by_momI7;
variable = 'momI7';
run;




* momI8 ;
proc sort data= data.Prebirth_all ;
by momI8period2;
run;

proc means data=data.Prebirth_all (where=(fail_sa NE 999))   NOPRINT;
var pyrs fail_sa;
by momI8period2;
OUTPUT out=RESULTS.attempt_by_momI8 (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa;
run;

data results.attempt_by_momI8;
set results.attempt_by_momI8;
variable = 'momI8';
run;





* momI12 ;
proc sort data= data.Prebirth_all ;
by momI12period2;
run;

proc means data=data.Prebirth_all (where=(fail_sa NE 999))   NOPRINT;
var pyrs fail_sa;
by momI12period2;
OUTPUT out=RESULTS.attempt_by_momI12 (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa;
run;

data results.attempt_by_momI12;
set results.attempt_by_momI12;
variable = 'momI12';
run;




* momI13 ;
proc sort data= data.Prebirth_all ;
by momI13period2;
run;

proc means data=data.Prebirth_all (where=(fail_sa NE 999))   NOPRINT;
var pyrs fail_sa;
by momI13period2;
OUTPUT out=RESULTS.attempt_by_momI13 (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa;
run;

data results.attempt_by_momI13;
set results.attempt_by_momI13;
variable = 'momI13';
run;





* momI14 ;
proc sort data= data.Prebirth_all ;
by momI14period2;
run;

proc means data=data.Prebirth_all (where=(fail_sa NE 999))   NOPRINT;
var pyrs fail_sa;
by momI14period2;
OUTPUT out=RESULTS.attempt_by_momI14 (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa ;
run;

data results.attempt_by_momI14;
set results.attempt_by_momI14;
variable = 'momI14';
run;





* bind by row the different aggregate files ;
data data.extract;
set results.attempt_by_momD4
	results.attempt_by_momI1
	results.attempt_by_momI4
	results.attempt_by_momI5
	results.attempt_by_momI6
	results.attempt_by_momI7
	results.attempt_by_momI8
	results.attempt_by_momI12
	results.attempt_by_momI13
	results.attempt_by_momI14;
run;

*SAVE AS Excel file;
proc export data=data.extract
dbms=xlsx
outfile='E:\workdata\708082\MO\Paper_1_infections\RESULTS_infections\extract_attempt_by_momIx'
replace;
run;






* *************************************************************************************************** 
*    SUICIDE ATTEMPT by EXPOSURE - CRUDE ASSOCIATIONS
* *************************************************************************************************** ;


data results.attempt_by_momD4;
set results.attempt_by_momD4;
logpyrs = log(pyrs);
run;

data results.attempt_by_momI1;
set results.attempt_by_momI1;
logpyrs = log(pyrs);
run;

data results.attempt_by_momI4;
set results.attempt_by_momI4;
logpyrs = log(pyrs);
run;

data results.attempt_by_momI5;
set results.attempt_by_momI5;
logpyrs = log(pyrs);
run;

data results.attempt_by_momI6;
set results.attempt_by_momI6;
logpyrs = log(pyrs);
run;

data results.attempt_by_momI7;
set results.attempt_by_momI7;
logpyrs = log(pyrs);
run;

data results.attempt_by_momI8;
set results.attempt_by_momI8;
logpyrs = log(pyrs);
run;

data results.attempt_by_momI12;
set results.attempt_by_momI12;
logpyrs = log(pyrs);
run;

data results.attempt_by_momI13;
set results.attempt_by_momI13;
logpyrs = log(pyrs);
run;

data results.attempt_by_momI14;
set results.attempt_by_momI14;
logpyrs = log(pyrs);
run;





* momD4;
proc genmod data=results.attempt_by_momD4 ;
class momD4period2 /  ref=FIRST;
model fail_sa= momD4period2 /dist=poisson offset=logpyrs type3;
ods output PARAMETErestimates = RESULTS.estimates;
run;

data RESULTS.estimates_momD4_M1_crude;
set RESULTS.estimates (where=(Parameter='momD4period2'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;



* momI1;
proc genmod data=results.attempt_by_momI1 ;
class momI1period2 /  ref=FIRST;
model fail_sa= momI1period2 /dist=poisson offset=logpyrs type3;
ods output PARAMETErestimates = RESULTS.estimates;
run;

data RESULTS.estimates_momI1_M1_crude;
set RESULTS.estimates (where=(Parameter='momI1period2'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;


* momI4;
proc genmod data=results.attempt_by_momI4 ;
class momI4period2 /  ref=FIRST;
model fail_sa= momI4period2 /dist=poisson offset=logpyrs type3;
ods output PARAMETErestimates = RESULTS.estimates;
run;

data RESULTS.estimates_momI4_M1_crude;
set RESULTS.estimates (where=(Parameter='momI4period2'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;


* momI5;
proc genmod data=results.attempt_by_momI5 ;
class momI5period2 /  ref=FIRST;
model fail_sa= momI5period2 /dist=poisson offset=logpyrs type3;
ods output PARAMETErestimates = RESULTS.estimates;
run;

data RESULTS.estimates_momI5_M1_crude;
set RESULTS.estimates (where=(Parameter='momI5period2'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;


* momI6;
proc genmod data=results.attempt_by_momI6 ;
class momI6period2 /  ref=FIRST;
model fail_sa= momI6period2 /dist=poisson offset=logpyrs type3;
ods output PARAMETErestimates = RESULTS.estimates;
run;

data RESULTS.estimates_momI6_M1_crude;
set RESULTS.estimates (where=(Parameter='momI6period2'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;


* momI7;
proc genmod data=results.attempt_by_momI7 ;
class momI7period2 /  ref=FIRST;
model fail_sa= momI7period2 /dist=poisson offset=logpyrs type3;
ods output PARAMETErestimates = RESULTS.estimates;
run;

data RESULTS.estimates_momI7_M1_crude;
set RESULTS.estimates (where=(Parameter='momI7period2'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;


* momI8;
proc genmod data=results.attempt_by_momI8 ;
class momI8period2 /  ref=FIRST;
model fail_sa= momI8period2 /dist=poisson offset=logpyrs type3;
ods output PARAMETErestimates = RESULTS.estimates;
run;

data RESULTS.estimates_momI8_M1_crude;
set RESULTS.estimates (where=(Parameter='momI8period2'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;


* momI12;
proc genmod data=results.attempt_by_momI12 ;
class momI12period2 /  ref=FIRST;
model fail_sa= momI12period2 /dist=poisson offset=logpyrs type3;
ods output PARAMETErestimates = RESULTS.estimates;
run;

data RESULTS.estimates_momI12_M1_crude;
set RESULTS.estimates (where=(Parameter='momI12period2'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;


* momI13;
proc genmod data=results.attempt_by_momI13 ;
class momI13period2 /  ref=FIRST;
model fail_sa= momI13period2 /dist=poisson offset=logpyrs type3;
ods output PARAMETErestimates = RESULTS.estimates;
run;

data RESULTS.estimates_momI13_M1_crude;
set RESULTS.estimates (where=(Parameter='momI13period2'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;


* momI14;
proc genmod data=results.attempt_by_momI14 ;
class momI14period2 /  ref=FIRST;
model fail_sa= momI14period2 /dist=poisson offset=logpyrs type3;
ods output PARAMETErestimates = RESULTS.estimates;
run;

data RESULTS.estimates_momI14_M1_crude;
set RESULTS.estimates (where=(Parameter='momI14period2'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;








data data.extract;
length Parameter $20;
set results.estimates_momD4_M1_crude
	results.estimates_momI1_M1_crude
	results.estimates_momI4_M1_crude
	results.estimates_momI5_M1_crude
	results.estimates_momI6_M1_crude
	results.estimates_momI7_M1_crude
	results.estimates_momI8_M1_crude
	results.estimates_momI12_M1_crude
	results.estimates_momI13_M1_crude
	results.estimates_momI14_M1_crude;
run;


proc export data=data.extract
dbms=xlsx
outfile='E:\workdata\708082\MO\Paper_1_infections\RESULTS_infections\estimates_momI_M1_crude'
replace;
run;






















* *************************************************************************************************** 
*    SUICIDE ATTEMPT by EXPOSURE - ADJUSTED ASSOCIATIONS
* *************************************************************************************************** ;

* requested by Reviewer: sex age period mom_age_birth dad_age_birth low_parental_income any_parent_psyk mom_psych_med momD5;

data data.Prebirth_all;
set data.Prebirth_all;
myvar = momD4period2;
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

data RESULTS.estimates_momD4_M2_adjusted;
set RESULTS.estimates (where=(Parameter='myvar'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;




* Adjusted models - momD4;

data data.Prebirth_all;
set data.Prebirth_all;
myvar = momD4period2;
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

data RESULTS.estimates_momD4_M2_adjusted;
set RESULTS.estimates (where=(Parameter='myvar'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;




* Adjusted models - momI1;

data data.Prebirth_all;
set data.Prebirth_all;
myvar = momI1period2;
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

data RESULTS.estimates_momI1_M2_adjusted;
set RESULTS.estimates (where=(Parameter='myvar'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;




* Adjusted models - momI4;
data data.Prebirth_all;
set data.Prebirth_all;
myvar = momI4period2;
run;

proc sort data= data.Prebirth_all ;
by myvar sex sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5;
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

data RESULTS.estimates_momI4_M2_adjusted;
set RESULTS.estimates (where=(Parameter='myvar'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;



* Adjusted models - momI5;
data data.Prebirth_all;
set data.Prebirth_all;
myvar = momI5period2;
run;

proc sort data= data.Prebirth_all ;
by myvar sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5;
run;

proc means data=data.Prebirth_all (where=(fail_sa NE 999))  NOPRINT;
var pyrs fail_sa ;
by myvar sex sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5;
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

data RESULTS.estimates_momI5_M2_adjusted;
set RESULTS.estimates (where=(Parameter='myvar'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;


* Adjusted models - momI6;
data data.Prebirth_all;
set data.Prebirth_all;
myvar = momI6period2;
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

data RESULTS.estimates_momI6_M2_adjusted;
set RESULTS.estimates (where=(Parameter='myvar'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;


* Adjusted models - momI7;
data data.Prebirth_all;
set data.Prebirth_all;
myvar = momI7period2;
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

data RESULTS.estimates_momI7_M2_adjusted;
set RESULTS.estimates (where=(Parameter='myvar'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;


* Adjusted models - momI8;
data data.Prebirth_all;
set data.Prebirth_all;
myvar = momI8period2;
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

data RESULTS.estimates_momI8_M2_adjusted;
set RESULTS.estimates (where=(Parameter='myvar'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;



* Adjusted models - momD12;
data data.Prebirth_all;
set data.Prebirth_all;
myvar = momI12period2;
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

data RESULTS.estimates_momI12_M2_adjusted;
set RESULTS.estimates (where=(Parameter='myvar'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;



* Adjusted models - momI13;
data data.Prebirth_all;
set data.Prebirth_all;
myvar = momI13period2;
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

data RESULTS.estimates_momI13_M2_adjusted;
set RESULTS.estimates (where=(Parameter='myvar'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;



* Adjusted models - momI14;
data data.Prebirth_all;
set data.Prebirth_all;
myvar = momI14period2;
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

data RESULTS.estimates_momI14_M2_adjusted;
set RESULTS.estimates (where=(Parameter='myvar'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;





data data.extract;
set results.estimates_momD4_M2_adjusted
	results.estimates_momI1_M2_adjusted
	results.estimates_momI4_M2_adjusted
	results.estimates_momI5_M2_adjusted
	results.estimates_momI6_M2_adjusted
	results.estimates_momI7_M2_adjusted
	results.estimates_momI8_M2_adjusted
	results.estimates_momI12_M2_adjusted
	results.estimates_momI13_M2_adjusted
	results.estimates_momI14_M2_adjusted;
run;


proc export data=data.extract
dbms=xlsx
outfile='E:\workdata\708082\MO\Paper_1_infections\RESULTS_infections\estimates_momI_M2_adjusted'
replace;
run;




*************************************************************************************************


	Trimesters analysis


*************************************************************************************************;

* rates;

proc sort data= data.Prebirth_all ; 
by D4trim; 
run;

proc means data=data.Prebirth_all (where=(fail_sa NE 999))   NOPRINT;
var pyrs fail_sa;
by D4trim;
OUTPUT out=RESULTS.attempt_by_D4trim (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa ;
run;

data results.attempt_by_D4trim;
set results.attempt_by_D4trim;
variable = 'D4trim';
run;

proc export data= results.attempt_by_D4trim
dbms=xlsx
outfile='E:\workdata\708082\MO\Paper_1_infections\RESULTS_infections\extract_attempt_trimesters'
replace;
run;


* crude model;

data results.attempt_by_D4trim;
set results.attempt_by_D4trim;
logpyrs = log(pyrs);
run;

proc genmod data=results.attempt_by_D4trim; ;
class D4trim /  ref=FIRST;
model fail_sa= D4trim /dist=poisson offset=logpyrs type3;
ods output PARAMETErestimates = RESULTS.estimates;
run;

data RESULTS.estimates_D4trim_M1_crude;
set RESULTS.estimates (where=(Parameter='D4trim'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;

proc export data=RESULTS.estimates_D4trim_M1_crude
dbms=xlsx
outfile='E:\workdata\708082\MO\Paper_1_infections\RESULTS_infections\estimates_momD4trimesters_M1_crude'
replace;
run;




* adjusted model; 

proc sort data= data.Prebirth_all ;
by D4trim sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5;
run;

proc means data=data.Prebirth_all (where=(fail_sa NE 999))  NOPRINT;
var pyrs fail_sa ;
by D4trim sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5;
OUTPUT out=aggregate_data (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa ) = pyrs fail_sa ;
run;

data aggregate_data;
set aggregate_data;
logpyrs = log(pyrs);
run;

proc genmod data=aggregate_data ;
class D4trim /  ref=FIRST;
model fail_sa= D4trim sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5 /dist=poisson offset=logpyrs type3;
ods output PARAMETErestimates = RESULTS.estimates;
run;

data RESULTS.estimates_D4trim_M2_adjusted;
set RESULTS.estimates (where=(Parameter='D4trim'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;

proc export data=RESULTS.estimates_D4trim_M2_adjusted
dbms=xlsx
outfile='E:\workdata\708082\MO\Paper_1_infections\RESULTS_infections\estimates_momD4trimesters_M2_adjusted'
replace;
run;


* with category 2 as reference; 
proc genmod data=aggregate_data ;
class D4trim (ref="2");
model fail_sa= D4trim sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5 /dist=poisson offset=logpyrs type3;
ods output PARAMETErestimates = RESULTS.estimates;
run;





*************************************************************************************************


	Suicide mortality analysis


*************************************************************************************************;


* rates;
proc sort data= data.Prebirth_all ; 
by momD4period2; 
run;

proc means data=data.Prebirth_all (where=(fail_sa NE 999))   NOPRINT;
var pyrs sui2;
by sui2;
OUTPUT out=RESULTS.suicide_by_momD4 (drop=_TYPE_ _FREQ_) SUM(pyrs sui2) = pyrs sui2 ;
run;

data results.suicide_by_momD4;
set results.suicide_by_momD4;
variable = 'momD4period2';
run;

proc export data=RESULTS.suicide_by_momD4
dbms=xlsx
outfile='E:\workdata\708082\MO\Paper_1_infections\RESULTS_infections\suicide_by_momD4'
replace;
run;



* crude model;

data results.suicide_by_momD4;
set results.suicide_by_momD4;
logpyrs = log(pyrs);
run;

proc genmod data=results.suicide_by_momD4 ;
class sui2 momD4period2 /  ref=FIRST;
model sui2= momD4period2 /dist=poisson offset=logpyrs type3;
ods output PARAMETErestimates = RESULTS.estimates;
run;

data RESULTS.estimates_suicide_momD4_M1_crude;
set RESULTS.estimates (where=(Parameter='momD4period2'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;

proc export data=RESULTS.estimates_suicide_momD4_M1_crude
dbms=xlsx
outfile='E:\workdata\708082\MO\Paper_1_infections\RESULTS_infections\estimates_suicide_momD4_M1_crude'
replace;
run;




* adjusted model;

proc sort data= data.Prebirth_all ;
by momD4period2 sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5;
run;

proc means data=data.Prebirth_all (where=(fail_sa NE 999))  NOPRINT;
var pyrs sui2 ;
by momD4period2 sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5;
OUTPUT out=aggregate_data (drop=_TYPE_ _FREQ_) SUM(pyrs sui2 ) = pyrs sui2 ;
run;

data aggregate_data;
set aggregate_data;
logpyrs = log(pyrs);
run;

proc genmod data=aggregate_data ;
class momD4period2 /  ref=FIRST;
model sui2= momD4period2 sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5 /dist=poisson offset=logpyrs type3;
ods output PARAMETErestimates = RESULTS.estimates;
run;

data RESULTS.estimates_suicide_momD4_M2_adj;
set RESULTS.estimates (where=(Parameter='momD4period2'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;

proc export data=RESULTS.estimates_suicide_momD4_M2_adj
dbms=xlsx
outfile='E:\workdata\708082\MO\Paper_1_infections\RESULTS_infections\estimates_suicide_momD4_M2_adj'
replace;
run;






*************************************************************************************************


	Model with adjustment requested by reviewer


*************************************************************************************************;


data data.Prebirth_all;
set data.Prebirth_all;
myvar = momD4period2;
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

data RESULTS.estimates_momD4_M2_adj_reviewer;
set RESULTS.estimates (where=(Parameter='myvar'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;


proc export data=RESULTS.estimates_momD4_M2_adj_reviewer
dbms=xlsx
outfile='E:\workdata\708082\MO\Paper_1_infections\RESULTS_infections\estimates_momD4_M2_adjusted_reviewer_req'
replace;
run;







*************************************************************************************************


	Sex-stratified analysis analysis


*************************************************************************************************;





* rates;

proc sort data= data.Prebirth_all ; 
by momD4periodbysex; 
run;

proc means data=data.Prebirth_all (where=(fail_sa NE 999))   NOPRINT;
var pyrs fail_sa;
by momD4periodbysex;
OUTPUT out=RESULTS.attempt_by_momD4sex (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa ;
run;

data results.attempt_by_momD4sex;
set results.attempt_by_momD4sex;
variable = 'momD4periodbysex';
run;

proc export data= results.attempt_by_momD4sex
dbms=xlsx
outfile='E:\workdata\708082\MO\Paper_1_infections\RESULTS_infections\extract_attempt_mom_sex'
replace;
run;


* crude model;

data results.attempt_by_momD4sex;
set results.attempt_by_momD4sex;
logpyrs = log(pyrs);
run;

proc genmod data=results.attempt_by_momD4sex; ;
class momD4periodbysex /  ref=FIRST;
model fail_sa= momD4periodbysex /dist=poisson offset=logpyrs type3;
ods output PARAMETErestimates = RESULTS.estimates;
run;

data RESULTS.estimates_momD4sex_M1_crude;
set RESULTS.estimates (where=(Parameter='momD4periodbysex'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;

proc export data=RESULTS.estimates_momD4sex_M1_crude
dbms=xlsx
outfile='E:\workdata\708082\MO\Paper_1_infections\RESULTS_infections\estimates_momD4sex_M1_crude'
replace;
run;




* adjusted model; 

proc sort data= data.Prebirth_all ;
by momD4periodbysex sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5;
run;

proc means data=data.Prebirth_all (where=(fail_sa NE 999))  NOPRINT;
var pyrs fail_sa ;
by momD4periodbysex sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5;
OUTPUT out=aggregate_data (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa ) = pyrs fail_sa ;
run;

data aggregate_data;
set aggregate_data;
logpyrs = log(pyrs);
run;

proc genmod data=aggregate_data ;
class momD4periodbysex /  ref=FIRST;
model fail_sa= momD4periodbysex sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5 /dist=poisson offset=logpyrs type3;
ods output PARAMETErestimates = RESULTS.estimates;
run;

data RESULTS.estimates_momD4sex_M2_adjusted;
set RESULTS.estimates (where=(Parameter='momD4periodbysex'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;

proc export data=RESULTS.estimates_momD4sex_M2_adjusted
dbms=xlsx
outfile='E:\workdata\708082\MO\Paper_1_infections\RESULTS_infections\estimates_momD4sex_M2_adjusted'
replace;
run;











* rates;

proc sort data= data.Prebirth_all ; 
by dadD4periodbysex; 
run;

proc means data=data.Prebirth_all (where=(fail_sa NE 999))   NOPRINT;
var pyrs fail_sa;
by dadD4periodbysex;
OUTPUT out=RESULTS.attempt_by_dadD4sex (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa) = pyrs fail_sa ;
run;

data results.attempt_by_dadD4sex;
set results.attempt_by_dadD4sex;
variable = 'dadD4periodbysex';
run;

proc export data= results.attempt_by_dadD4sex
dbms=xlsx
outfile='E:\workdata\708082\MO\Paper_1_infections\RESULTS_infections\extract_attempt_dad_sex'
replace;
run;


* crude model;

data results.attempt_by_dadD4sex;
set results.attempt_by_dadD4sex;
logpyrs = log(pyrs);
run;

proc genmod data=results.attempt_by_dadD4sex; ;
class dadD4periodbysex /  ref=FIRST;
model fail_sa= dadD4periodbysex /dist=poisson offset=logpyrs type3;
ods output PARAMETErestimates = RESULTS.estimates;
run;

data RESULTS.estimates_dadD4sex_M1_crude;
set RESULTS.estimates (where=(Parameter='dadD4periodbysex'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;

proc export data=RESULTS.estimates_dadD4sex_M1_crude
dbms=xlsx
outfile='E:\workdata\708082\MO\Paper_1_infections\RESULTS_infections\estimates_dadD4sex_M1_crude'
replace;
run;




* adjusted model; 

proc sort data= data.Prebirth_all ;
by dadD4periodbysex sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5;
run;

proc means data=data.Prebirth_all (where=(fail_sa NE 999))  NOPRINT;
var pyrs fail_sa ;
by dadD4periodbysex sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5;
OUTPUT out=aggregate_data (drop=_TYPE_ _FREQ_) SUM(pyrs fail_sa ) = pyrs fail_sa ;
run;

data aggregate_data;
set aggregate_data;
logpyrs = log(pyrs);
run;

proc genmod data=aggregate_data ;
class dadD4periodbysex /  ref=FIRST;
model fail_sa= dadD4periodbysex sex newagegp2 newperiod2 teen_mom mom_alone low_parental_income any_parent_psyk mom_psych_med momD5 /dist=poisson offset=logpyrs type3;
ods output PARAMETErestimates = RESULTS.estimates;
run;

data RESULTS.estimates_dadD4sex_M2_adjusted;
set RESULTS.estimates (where=(Parameter='dadD4periodbysex'));
effect=EXP(Estimate);
low95=EXP(LowerWaldCL);
high95=EXP(UpperWaldCL);
run;

proc export data=RESULTS.estimates_dadD4sex_M2_adjusted
dbms=xlsx
outfile='E:\workdata\708082\MO\Paper_1_infections\RESULTS_infections\estimates_dadD4sex_M2_adjusted'
replace;
run;
