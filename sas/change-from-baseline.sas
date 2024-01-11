
**** blood pressure values by subject, visit and test;
data vs;
    label usubjid='Unique Subject Identifier'
        vstestcd='Vitals Signs Test Short Name'
        vsstresn='Numeric Result/Finding in Standard Units';
    input usubjid $ visitnum vstestcd $ vsstresn;
    datalines;
101 0 DBP 160
101 0 SBP 90
101 1 DBP 140
101 1 SBP 87
101 2 DBP 130
101 2 SBP 85
101 3 DBP 120
101 3 SBP 80
202 0 DBP 141
202 0 SBP 75
202 1 DBP 161
202 1 SBP 80
202 2 DBP 171
202 2 SBP 85
202 3 DBP 181
202 3 SBP 90
;
run;

**** sort data by subject, test name, and visit;
proc sort data=vs;
    by usubjid vstestcd visitnum;
run;

**** calculate change from baseline values;

data advs;
    set vs;
    by usubjid vstestcd visitnum;

    **** copy sdtm content into bds variables;
    aval=vsstresn;
    paramcd=vstestcd;
    avisitn=visitnum;

    **** initialize baseline to missing;
    retain base;
    if first.vstestcd then
        base=.;

    **** determine baseline and calculate changes;
    if avisitn=0 then
        do;
            ablfl='Y';
            base=aval;
        end;
    else if avisitn > 0 then
        do;
            chg=aval - base;
            pchg=((aval - base) / base) * 100;
        end;
    label
        avisitn='Analysis Visit (N)'
        ablfl='Baseline Record Flag'
        paramcd='Parameter Code'
        aval='Analysis Value'
        base='Baseline Value'
        chg='Change from Baseline'
        pchg='Percent Change from Baseline';
run;

proc print data=advs;
    var usubjid avisitn paramcd ablfl aval base chg pchg;
run;