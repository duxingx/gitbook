**** input sample hemoglobin data as sdtm lb domain.; 

data lb; 
    label usubjid = 'Unique Subject Identifier' 
lbdtc = 'Date/Time of Specimen Collection'  
lbtestcd = 'Lab Test or Examination Short Name'  
lbstresn = 'Numeric Result/Finding in Standard Units'; 
input usubjid $ 1-3 lbtestcd $ 5-7 lbdtc $ 9-18 lbstresn; 
datalines; 
101 HGB 2013-06-15 1.0  
101 HGB 2013-06-16 1.1  
101 HGB 2013-07-15 1.2  
101 HGB 2013-07-21 1.3  
101 HGB 2013-08-14 1.4  
101 HGB 2013-08-16 1.5  
101 HGB 2014-06-01 1.6  
101 HGB 2014-06-25 1.7  
101 HGB 2015-06-10 1.8  
101 HGB 2015-06-15 1.9 
; 
run; 
**** input sample dosing data as sdtm ex domain.; 
data ex; 
    label usubjid = 'Unique Subject Identifier'  
    exstdtc = 'Start Date/Time of Treatment'; 
    input usubjid $ 1-3 exstdtc $ 5-14; 
datalines; 
101 2013-06-17 
; 
run; 
**** sort lab data for merge with dosing; 
proc sort  data=lb; 
    by usubjid; 
run; 
**** sort dosing data for merge with labs.; 
proc sort  data=ex;  
    by usubjid; 
run; 


**** formats for defining awvisit and awrange; 
proc format;  
    value avisit 
        -1 = 'Baseline' 
        30 = 'Month 1' 
        60 = 'Month 2' 
        365 = 'Year 1' 
        730 = 'Year 2'
    ;  
    value awrange 
        -1 = 'Up to ADY -1 '  
        30 = '25 <= ADY <= 35 '  
        60 = '55 <= ADY <= 65 '  
        365 = '350 <= ADY <= 380'  
        730 = '715 <= ADY <= 745'
    ; 
run; 


**** merge lab data with dosing date. calculate study day and 
**** define visit windows based on study day.; 
data adlb;  
    merge lb(in = inlab)  ex(keep = usubjid exstdtc);  
    by usubjid; 
    **** keep record if in lab and result is not missing.;  
    if inlab and lbstresn ne .; 
    adt = input(lbdtc,yymmdd10.);  
    format adt yymmdd10.; 
    paramcd = lbtestcd;  
    aval = lbstresn; 
    **** calculate study day.;  
    if adt < input(exstdtc,yymmdd10.) then  ady = adt - input(exstdtc,yymmdd10.);  
    else if adt >= input(exstdtc,yymmdd10.) then  ady = adt - input(exstdtc,yymmdd10.) + 1; 
    **** set visit windows and target day as the middle of the  window.;  if . < ady < 0 then 
    awtarget = -1;  else if 25 <= ady <= 35 then 
    awtarget = 30;  else if 55 <= ady <= 65 then  awtarget = 60;  
    else if 350 <= ady <= 380 then  awtarget = 365;  
    else if 715 <= ady <= 745 then  awtarget = 730; 
    awrange = left(put(awtarget,awrange.));  
    avisit = left(put(awtarget,avisit.)); 
    **** calculate observation distance from target and 
    **** absolute value of that difference.;  
    awtdiff = abs(ady - awtarget); 
run;


**** sort data by decreasing absolute difference and actual 
**** difference within a visit window.; 
proc sort  data=adlb;  
    by usubjid lbtestcd awtarget awtdiff ady; 
run; 
**** select the record closest to the target as the record of 
**** choice ties on both sides of the target go to the earlier 
**** of the two observations.; 
data adlb;  
    set adlb;  
    by usubjid lbtestcd awtarget awtdiff ady; 
    if first.awtarget and awtarget ne . then  anl01fl = 'Y'; 
    if avisit = 'DAY 0' and anl01fl = 'Y' then  ablfl = 'Y'; 
    keep usubjid paramcd adt exstdtc ady avisit awtarget ady  awtdiff awrange anl01fl; 
    label 
        ablfl = 'Baseline Record Flag' 
        paramcd = 'Parameter Code' 
        adt = 'Analysis Date' 
        aval = 'Analysis Value'  
        awtarget = 'Analysis Window Target' 
        awrange = 'Analysis Window Valid Relative Range'  
        avisit = 'Analysis Visit' 
        ady = 'Analysis Relative Day'  
        awtdiff = 'Analysis Window Diff from Target'  
        anl01fl = 'Analysis Record Flag 01';
run; 

proc sort 
    data=adlb; 
    by usubjid paramcd ady; 
run; 