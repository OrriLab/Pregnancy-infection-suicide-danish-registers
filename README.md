# Pregnancy-infection-suicide-danish-registers
This is the repository for the SAS and R codes used for the following paper:
Orri M, Erlangsen A. 

It contains the following files:
- 1_analysis_variable_recoding.sas: recoding of initial variables
- 2_analysis_suicide_attempt_maternal_infections.sas: descriptive statistics and associations between maternal infections and suicide attempt (including by trimester and sex)
- 3_analysis_suicide_attempt_paternal_infections.sas: associations between paternal infections and suicide attempt (including by sex)
- 4_analysis_suicide_maternal_and_paternal_infections.sas: associations of maternal and paternal infections with suicide mortality


**Note on variable names:**

OUTCOMES:
fail_sa = suicide attempt
sui2 = suicide mortality

EXPOSUREs:
D4 = exposure to any paternal infection
I1 to I14 = exposure to specific paternal infection categories
prefix "mom" or "dad" indicates infections
suffix "period2" indicates that the exposures variables refer to exposures in the periods before, during, and after pregnancy (individuals exposed in multiple periods were excluded)
For example, the variable momD4period2 indicates whether the dad has been diagnosed with any infection: never, during pregnancy, pre-pregnancy, post-pregancny periods
suffix "trim" indicates trimesters of pregnancy in which the mother may have been diagnosed with infection

