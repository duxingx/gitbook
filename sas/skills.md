# SAS Skills

## unicode特殊字符

## `proc format` `picutre`的bug处理

当percent=9.96时，`put(percent,pcta.)`结果为0的问题

<pre class="language-sas" data-title="picture_fix_bug_demo.sas" data-overflow="wrap" data-line-numbers><code class="lang-sas"><strong>proc format;
</strong><strong>        picture pcta(round)
</strong>                0-&#x3C;10   ='9.9)' (prefix=' (  ')
                10-&#x3C;100='99.9)' (prefix=' ( ')
                100   ='999  )' (prefix=' (')
         ;
 run;
 data test;
         set tfl;
         if (9.95 &#x3C;= percent &#x3C; 10) or (99.95 &#x3C;= percent &#x3C; 100) then do;
                 percent = round(percent, 2);
         end;
 run;
</code></pre>


## LOCF案例代码
```sas
/* 
Deriving Last Observation Carried Forward(LOCF) Variables 
    the last observation carried forward so long as 
    the measures occur within a five day window before the pill is taken. 
 */
 
 
 /* INPUT SAMPLE CHOLESTEROL DATA AS SDTM LB DOMAIN.; */
data LB; 
    label USUBJID = 'Unique Subject Identifier' 
        LBDTC = 'Date/Time of Specimen Collection'  
        LBTESTCD = 'Lab Test or Examination Short Name'  
        LBSTRESN = 'Numeric Result/Finding in Standard Units'; 
    input USUBJID $ 1-3 LBDTC $ 5-14 LBTESTCD $ LBSTRESN; 
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

**** INPUT SAMPLE PILL DOSING DATA AS SDTM EX DOMAIN.; 
data EX; 
    label USUBJID = 'Unique Subject Identifier'  
        EXSTDTC = 'Start Date/Time of Treatment'; 
    input USUBJID $ 1-3 EXSTDTC $ 5-14; 
    datalines; 
101 2003-09-07 
102 2003-10-07 
103 2003-11-13 
; 
run; 


/* join cholesterol and dosing data into adlb analysis dataset and create windowing variables; */
proc sql noprint;
    create table ADLB as
        select LB.USUBJID, LBDTC, LBTESTCD as PARAMCD,
                LBSTRESN as AVAL, EXSTDTC, input(LBDTC, yymmdd10.) as ADT format=yymmdd10.,
                case when
                    -5 <= (input(LBDTC, yymmdd10.) - input(EXSTDTC, yymmdd10.)) <= -1 and LBSTRESN ne . then "YES"
                    else "NO"
                end as WITHIN5DAYS
        from LB, EX
        where LB.USUBJID = EX.USUBJID
        order by USUBJID, LBTESTCD, WITHIN5DAYS, ADT
    ;
quit;


/* define ABLFL BASELINE FLAG; */
data ADLB;
    set ADLB;
    by USUBJID PARAMCD WITHIN5DAYS ADT;
    /* flag last record within window as baseline record */
    if last.WITHIN5DAYS and WITHIN5DAYS="YES" then ABLFL = "Y";
    drop WITHIN5DAYS;
run;

proc sort data=ADLB;
    by USUBJID PARAMCD ADT;
run;

```
