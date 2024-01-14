/* deriving last observation carried forward(locf) variables 
    the last observation carried forward so long as 
    the measures occur within a five day window before the pill is taken.  */
 
 
 /* input sample cholesterol data as sdtm lb domain.; */
data lb; 
    label usubjid = 'Unique Subject Identifier' 
        lbdtc = 'Date/Time of Specimen Collection'  
        lbtestcd = 'Lab Test or Examination Short Name'  
        lbstresn = 'Numeric Result/Finding in Standard Units'; 
    input usubjid $ 1-3 lbdtc $ 5-14 lbtestcd $ lbstresn; 
    datalines; 
101 2003-09-05 HDL 48 
101 2003-09-05 LDL 188 
101 2003-09-05 TRIG 108 
101 2003-09-06 HDL 49 
101 2003-09-06 LDL 185 
101 2003-09-06 TRIG . 
102 2003-10-01 HDL 54 
102 2003-10-01 LDL 200 
102 2003-10-01 TRIG 350 
102 2003-10-02 HDL 52 
102 2003-10-02 LDL . 
102 2003-10-02 TRIG 360 
103 2003-11-10 HDL . 
103 2003-11-10 LDL 240 
103 2003-11-10 TRIG 900 
103 2003-11-11 HDL 30 
103 2003-11-11 LDL . 
103 2003-11-11 TRIG 880 
103 2003-11-12 HDL 32 
103 2003-11-12 LDL . 
103 2003-11-12 TRIG . 
103 2003-11-13 HDL 35 
103 2003-11-13 LDL 289 
103 2003-11-13 TRIG 930 
; 
run; 

**** input sample pill dosing data as sdtm ex domain.; 
data ex; 
    label usubjid = 'Unique Subject Identifier'  
        exstdtc = 'Start Date/Time of Treatment'; 
    input usubjid $ 1-3 exstdtc $ 5-14; 
    datalines; 
101 2003-09-07 
102 2003-10-07 
103 2003-11-13 
; 
run; 


/* join cholesterol and dosing data into adlb analysis dataset and create windowing variables; */
proc sql noprint;
    create table adlb as
        select lb.usubjid, lbdtc, lbtestcd as paramcd,
                lbstresn as aval, exstdtc, input(lbdtc, yymmdd10.) as adt format=yymmdd10.,
                case when
                    -5 <= (input(lbdtc, yymmdd10.) - input(exstdtc, yymmdd10.)) <= -1 and lbstresn ne . then "YES"
                    else "NO"
                end as within5days
        from lb, ex
        where lb.usubjid = ex.usubjid
        order by usubjid, lbtestcd, within5days, adt
    ;
quit;


/* define ablfl baseline flag; */
data adlb;
    set adlb;
    by usubjid paramcd within5days adt;
    /* flag last record within window as baseline record */
    if last.within5days and within5days="YES" then ablfl = "Y";
    drop within5days;
run;

proc sort data=adlb;
    by usubjid paramcd adt;
run;