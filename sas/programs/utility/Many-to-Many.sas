**** input sample sdtm ae domain.;
data ae;
    label usubjid = 'Unique Subject Identifier'
    aestdtc = 'Start Date/Time of Adverse Event'
    aeendtc = 'End Date/Time of Adverse Event'
    aeterm = 'Reported Term for the Adverse Event';
    input usubjid $ 1-3 aestdtc $ 5-14 aeendtc $ 16-25 aeterm $15.;
datalines;
101 2004-01-01 2004-01-02 Headache
101 2004-01-15 2004-02-03 Back Pain
102 2003-11-03 2003-12-10 Rash
102 2004-01-03 2004-01-10 Abdominal Pain
102 2004-04-04 2004-04-04 Constipation
;

run;
**** input sample sdtm cm domain.;
data cm;
    label usubjid = 'Unique Subject Identifier'
    cmstdtc = 'Start Date/Time of Medication'
    cmendtc = 'End Date/Time of Medication'
    cmtrt = 'Reported Name of Drug, Med, or Therapy';
    input usubjid $ 1-3 cmstdtc $ 5-14 cmendtc $ 16-25 cmtrt $21.;
datalines;
101 2004-01-01 2004-01-01 Acetaminophen
101 2003-10-20 2004-03-20 Tylenol w/ Codeine
101 2003-12-12 2003-12-12 Sudaphed
102 2003-12-07 2003-12-18 Hydrocortizone Cream
102 2004-01-06 2004-01-08 Simethicone
102 2004-01-09 2004-03-10 Esomeprazole
;
run;


**** merge concomitant medications with adverse events;
proc sql;
    create table ae_meds as
    select a.usubjid, a.aestdtc, a.aeendtc, a.aeterm,  c.cmstdtc, c.cmendtc, c.cmtrt
    from ae as a
    left join cm as c  on (a.usubjid = c.usubjid)
        and ((a.aestdtc <= c.cmstdtc <= a.aeendtc)
        or  (a.aestdtc <= c.cmendtc <= a.aeendtc)
        or  ((c.cmstdtc < a.aestdtc)
        and (a.aeendtc < c.cmendtc)));
quit;