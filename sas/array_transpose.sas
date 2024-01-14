**** input sample systolic blood pressure values as sdtm vs 
**** domain. notice where visitnum=2 is missing for both usubjid.; 
data VS; 
    label usubjid = 'Unique Subject Identifier' 
vstestcd = 'Vitals Signs Test Short Name'  
visitnum = 'Visit Number' 
vsstresn = 'Numeric Result/Finding in Standard Units'; 
input usubjid $ 1-3 vstestcd $ 5-7 visitnum vsstresn; 
datalines; 
101 SBP 1 160 
101 SBP 3 140 
101 SBP 4 130 
101 SBP 5 120 
202 SBP 1 141 
202 SBP 3 161 
202 SBP 4 171 
202 SBP 5 181 
; 
run; 
**** transpose the normalized sbp values to a flat structure; 
proc sort  data=vs;  
    by usubjid; 
run; 
data sbpflat; 
    set vs; 
    by usubjid; 
    keep usubjid visit1-visit5;  
    retain visit1-visit5;  
    array sbps {5} visit1-visit5; 
    if first.usubjid then  do i = 1 to 5;  
        sbps{i} = .;  
    end; 
    sbps{visitnum} = vsstresn; 
    if last.usubjid; 
run; 