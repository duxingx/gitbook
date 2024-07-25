

/* Clear the environment -----------------------------------------------------*/
proc datasets library=work kill nowarn nolist memtype=data; quit;
options validvarname=v7;
dm log 'CLEAR';
dm out 'CLEAR';
/* end -----------------------------------------------------------------------*/



/* macro variables, system options, and so on---------------------------------*/
%LET GMPXLERR = 0;
%LET PGMNAME = t-adlb-abnlab;
%LET TFLNAME = t_adlb_abnlab;

%MACRO intoFmt(fmtname=, indat=, start="", end="", label="", type="", condi=1);
    /* this macro is used to generate formats from specified dataset */
    proc sql noprint;
        /* nodupkey */
        create table fmtdat1 as
            select distinct
                &start. as startvar, &end. as endvar, &label. as labelvar,
                "C" as typevar
            from &indat.
            where &condi.;
        /* calculate N */
        select count(*) into : num from fmtdat1;
    quit;

    data fmtdat2;
        do i = 1 to &num.;
            set fmtdat1;
            fmtname = &fmtname.;
            /* if args is missing: key args will replaced N */
            %IF &start.="" %THEN %DO; start = i %END;
                %ELSE %DO; start = startvar %END;;
            %IF &end.="" %THEN %DO; end = start %END;
                %ELSE %DO; end = endvar %END;;
            %IF &label.="" %THEN %DO; label = i %END;
                %ELSE %DO; label = labelvar %END;;
            %IF &type.="" %THEN %DO; type = "C" %END;
                %ELSE %DO; type = "&type." %END;;
            output;
        end;
    run;
    proc format library=work cntlin=work.fmtdat2; run;
%MEND;
/* end -----------------------------------------------------------------------*/




/*formats---------------------------------------------------------------------*/
proc format;
    picture PCTN
        0-9 = "009"
        10-99 = "099"
        100-999 = "999"
    ;
    picture PCTP (round)
        0-<10 = "9.9)"    (prefix=" (  ")
        10-<100 = "99.9)" (prefix=" ( ")
        100 = "999  )"    (prefix=" (")
    ;
    value ANRNC
        1="Normal"
        2="Abnormal"
        3="Abnormal Low"
        4="Abnormal High"
    ;
    value ANR2NC
        1="Negative"
        2="Positive"
        3="Abnormal Low"
        4="Abnormal High"
    ;
    value VISNC
        4 = "Baseline"
        5 = "Week 2"
        6 = "Week 4"
        7 = "Week 6"
        8 = "Week 8"
        9 = "Week 10"
        10 = "Week 12"
        11 = "Month 3"
        12 = "Month 4"
        13 = "Month 5"
        14 = "Month 6"
        15 = "Month 9"
        16 = "Month 12"
        17 = "Month 12.5"
    ;
run;

/* end -----------------------------------------------------------------------*/



/* main code -----------------------------------------------------------------*/
/* total group */
data adsl; set analysis.adsl; run;
data adlb; set analysis.adlb; run;
data adsl_tot;
    set adsl(where=(SAFFL="Y"));
    output;
    DMTR01AN = 6; output;
run;
data adlb_tot;
    set adlb(where=(SAFFL="Y"));

    if LBSTAT ^= "NOT DONE" and ^missing(ANRIND) and ANL11FL="Y";
    if (PARCAT1N = 1 and PARAMCD in ("NEUTLE", "LYMLE", "MONOLE","EOSLE","BASOLE",
                                    "NEUT", "LYM", "MONO","EOS","BASO",
                                    "RBC", "WBC", "HGB", "HCT", "PLAT", "MCV", "MCH"/* , "PLTCLUM" */))
        or (PARCAT1N = 2 and PARAMCD in ("INR", "APTT"))
        or (PARCAT1N = 3 and PARAMCD in ("SARSCOV2", "ALP", "CRP","HCG", "ALT", "ALB","GLUF",
                                        "PHOS", "AST", "BILI", "PROT", "CREAT", "CK",
                                        "GGT", "K", "SODIUM", "CA", "MG", "CL", "GLUC",
                                        "LDH", "ECKDEPI", "BICARB", 'CHOL', 'HDL',
                                        'LDL', 'TRIG', "UREAN", "HBA1C", "FGLUP", "INS"))
        or (PARCAT1N = 4 and PARAMCD in ("ASPECTU", "PH", "SPGRAV", "KETONES", "UPROT",
                                        "UGLUC", "NITRITE", "UROBIL", "OCCBLD","UALB","UCREAT","ALBCREAT"))
        or (PARCAT1N = 5 and PARAMCD in ("HBSAG", "HCVVLE", "HCAB", "HIV1VLE", "HIV1P24", "HIV1CONF", "HIV2CONF", "HIVCONF"))
        ;

    if ABLFL = "Y" then DMVISITN = 4;

    if upcase(ANRIND)="NORMAL" then ANRN = 1;
    else if upcase(ANRIND)="ABNORMAL" then ANRN = 2;
    else if upcase(ANRIND) = "LOW" then ANRN = 3;
    else if upcase(ANRIND) = "HIGH" then ANRN = 4;
    else ANRN = 99;

    output;
    DMTR01AN = 6; output;
run;


/*big N*/
proc sql noprint;
    create table bign as
        select DMTR01AN, count(distinct USUBJID) as BIGN
        from adlb_tot
        group by DMTR01AN;
quit;
proc sql noprint;
    select count(distinct USUBJID) into :N1 trimmed from adsl_tot where DMTR01AN=1;
    select count(distinct USUBJID) into :N2 trimmed from adsl_tot where DMTR01AN=2;
    select count(distinct USUBJID) into :N3 trimmed from adsl_tot where DMTR01AN=3;
    select count(distinct USUBJID) into :N4 trimmed from adsl_tot where DMTR01AN=4;
    select count(distinct USUBJID) into :N5 trimmed from adsl_tot where DMTR01AN=5;
    select count(distinct USUBJID) into :N6 trimmed from adsl_tot where DMTR01AN=6;

quit;

/* subN: */
proc sql noprint;
    create table nsub as
        select PARAMCD, PARAMN, DMTR01AN, DMVISITN, count(distinct USUBJID) as NSUB
        from adlb_tot
        group by PARAMCD, PARAMN, DMTR01AN, DMVISITN;
quit;


/* Category */
proc sql noprint;
    create table freq_lb as
        select  DMTR01AN, PARAMCD, PARAMN, DMVISITN, ANRN, count(distinct USUBJID) as CNT_N
        from adlb_tot
        group by  DMTR01AN, PARAMCD, PARAMN, DMVISITN, ANRN
    ;
quit;

proc sort data=nsub; by PARAMCD PARAMN DMTR01AN DMVISITN; run;
proc sort data=freq_lb; by PARAMCD PARAMN DMTR01AN DMVISITN; run;
data freq;
    merge freq_lb(in=a) nsub(in=b);
    by PARAMCD PARAMN DMTR01AN DMVISITN;
    if a;
    VAL = put(CNT_N, PCTN.) || "/" || put(NSUB, PCTN.) || put(CNT_N / NSUB * 100, PCTP.);
run;
/* END -----------------------------------------------------------------------*/



/* dummy ---------------------------------------------------------------------*/

%intoFmt(fmtname="PARMCC", indat=adlb_tot, start=PARAMCD, label=PARAM, type=C)
%intoFmt(fmtname="PARMNC", indat=adlb_tot, start=PARAMN, label=PARAMCD, type=N)

proc sql noprint;
    /* used in dummy do loop */
    select distinct DMVISITN into : VIS separated by "," from adlb_tot;

    /* used in dummy do loop */
    select distinct PARAMN into : PARN separated by "," from adlb_tot;

    /* For laboratory result reported as categorical variable */
    select distinct PARAMN into: POS_PAR separated by ' ' from adlb_tot
        where ^missing(LBSTNRC);
quit;

data dum_shell0;
    length PARAMCD ITEM1 ITEM2 $200.;
    do PARAMN = &PARN.;
        do DMVISITN = 4 to 16;
            do ANRN = 1 to 4;
                do DMTR01AN=1 to 6;
                    PARAMCD = put(PARAMN, PARMNC.);
                    BAVAR = put(PARAMCD, $PARMCC.);
                    ITEM1 = put(DMVISITN, VISNC.);
                    /* For laboratory result reported as categorical variable (e.g., +/-, positive/negative), result will be categorized as Normal, Abnormal */
                    if PARAMN in (&POS_PAR.) and PARAMCD not in ("SARSCOV2") then do;
                        ITEM2 = put(ANRN, ANRNC.);
                        if ITEM2 not in ("Abnormal Low", "Abnormal High") then output;
                    end;
                    /* For SARS-CoV-2 Test (if applicable), results will be categorized as Positive, Negative */
                    else if PARAMCD in ("SARSCOV2") then do;
                        ITEM2 = put(ANRN, ANR2NC.);
                        if ITEM2 not in ("Abnormal Low", "Abnormal High") then output;
                    end;
                    /* For laboratory result reported as continuous variable, result will be categorized as Normal, Abnormal Low (< LLN), Abnormal High (>ULN).  */
                    else do;
                        ITEM2 = put(ANRN, ANRNC.);
                        if ITEM2 not in ("Abnormal") then output;
                    end;
                end;
            end;
        end;
    end;
run;
proc sql noprint;
    create table dum_shell1 as
        select a.*, b.BIGN, c.NSUB
        from dum_shell0 as a
        left join bign as b on a.DMTR01AN=b.DMTR01AN
        left join nsub as c on a.DMTR01AN=c.DMTR01AN and a.PARAMN=c.PARAMN and a.DMVISITN=c.DMVISITN
    ;
quit;

/* filter dummy data follow SAP */
data dum_shell2;
    set dum_shell1;
    /* Serology (at screening only) */
    if PARAMCD in ("HBSAG", "HCVVLE", "HCAB", "HIV1CONF", "HIV2CONF") and DMVISITN ^= 4 then delete;
    /* Lipid panels will be performed at Visits 4 (Week 0), Visit 14 (Month 6) and Visit 16 (Month 12). */
    if PARAMCD in ('CHOL', 'HDL', 'LDL', 'TRIG') and DMVISITN not in (4, 14,16) then delete;
    /* eGFR will be performed at Visit 1 (Screening), Visit 3 (Subject who requires washout period), Visits 4 (Week 0), Visit 14 (Month 6) and Visit 16 (Month 12). */
    if PARAMCD in ("ECKDEPI") and DMVISITN not in (1,3,4,14,16) then delete;
    /* A coagulation panel is required at baseline (Visit 4) only */
    if PARAMCD in ("INR", "APTT") and DMVISITN ^= 4 then delete;
    /* HbA1c will be performed at Visit 1 (Screening), Visit 4 (Week 0), Visit 11 (Month 3), Visit 14 (Month 6), Visit 15 (Month 9), and Visit 16 (Month 12) */
    if PARAMCD in ("HBA1C") and DMVISITN not in (1,4,11,14,15,16) then delete;
    /* Fasting Plasma Glucose and Fasting Plasma Insulin will be performed at Visit 4 (Week 0), Visit 11 (Month 3), Visit 14 (Month 6), Visit 15 (Month 9), and Visit 16 (Month 12) */
    if PARAMCD in ("FGLUP", "INS") and DMVISITN not in (4,11,14,15,16) then delete;

    /* filter value: for no records week */
    if missing(NSUB) then delete;
run;
/* end -----------------------------------------------------------------------*/



/* FINAL ---------------------------------------------------------------------*/
/* merge dummy */
proc sort data=dum_shell2; by DMTR01AN PARAMCD PARAMN DMVISITN ANRN NSUB; run;
proc sort data=freq; by DMTR01AN PARAMCD PARAMN DMVISITN ANRN NSUB; run;
data tab_freq;
    merge dum_shell2(in=a) freq(in=b);
    by DMTR01AN PARAMCD PARAMN DMVISITN ANRN NSUB;
    if a;
run;


/* column value by treatment */
proc sort data= tab_freq; by PARAMN PARAMCD DMVISITN ITEM1 ANRN ITEM2; run;
proc transpose data=tab_freq out=col_freq_trans(drop=_NAME_) prefix=COL;
    by PARAMN PARAMCD DMVISITN ITEM1 ANRN ITEM2;
    var VAL;
    id DMTR01AN;
run;
/* nsub value by treatment */
proc sort data= tab_freq; by PARAMN PARAMCD DMVISITN ITEM1 ANRN ITEM2; run;
proc transpose data=tab_freq out=subn_freq_trans(drop=_NAME_) prefix=NSUB;
    by PARAMN PARAMCD DMVISITN ITEM1 ANRN ITEM2;
    var NSUB;
    id DMTR01AN;
run;
/* merge column value with nsub */
proc sort data=col_freq_trans; by PARAMN PARAMCD DMVISITN ITEM1 ANRN ITEM2; run;
proc sort data=subn_freq_trans; by PARAMN PARAMCD DMVISITN ITEM1 ANRN ITEM2; run;
data tab_all1;
    merge col_freq_trans(in=a) subn_freq_trans(in=b);
    by PARAMN PARAMCD DMVISITN ITEM1 ANRN ITEM2;
    if a and b;
run;

data tab_all2;
    length NSUB1 NSUB2 NSUB3 NSUB4 NSUB5 NSUB6 8.;
    retain NSUB1 NSUB2 NSUB3 NSUB4 NSUB5 NSUB6 .;
    set tab_all1;

    /* Parameter: XXXXXXXXXX (unit) */
    BYVAR = "Parameter: " ||put(PARAMCD, $PARMCC.);
    if PARAMN = 37 then do;
        byvar = "Parameter: eGFR CKD-EPI (mL/min/1.73m~{super 2})";
    end;

    /* COL */
    if missing(COL1) then COL1 = '  0' || "/" || put(NSUB1, PCTN.);
    if missing(COL2) then COL2 = '  0' || "/" || put(NSUB2, PCTN.);
    if missing(COL3) then COL3 = '  0' || "/" || put(NSUB3, PCTN.);
    if missing(COL4) then COL4 = '  0' || "/" || put(NSUB4, PCTN.);
    if missing(COL5) then COL5 = '  0' || "/" || put(NSUB5, PCTN.);
    if missing(COL6) then COL6 = '  0' || "/" || put(NSUB6, PCTN.);

    if missing(NSUB1) then COL1 = '  0/  0';
    if missing(NSUB2) then COL2 = '  0/  0';
    if missing(NSUB3) then COL3 = '  0/  0';
    if missing(NSUB4) then COL4 = '  0/  0';
    if missing(NSUB5) then COL5 = '  0/  0';
    if missing(NSUB6) then COL6 = '  0/  0';
run;

/* label */
data final_table;
    set tab_all2;
    GRPX1 = PARAMN;
    GRPX2 = DMVISITN;
    GRPX3 = ANRN;
    /* according to the order of Positive, Negative */
    /* UPDATE COMMENTS: Xingxing Du (2023-06-26 11:39:38)
        @Follow: QC
        @Description: Because the PARAMN is variable, now use PARAMCD or PARAM */
    if strip(upcase(scan(BYVAR,2,":"))) = "SARS-COV-2 TEST" and ANRN = 1 then GRPX3 = 2;
    else if strip(upcase(scan(BYVAR,2,":"))) = "SARS-COV-2 TEST" and ANRN = 2 then GRPX3 = 1;
    label
        ITEM1 = "Timepoint"
        ITEM2 = "Result"
        COL1 = "Treatment A~(N=&N1.)~n/n' (%)"
        COL2 = "Treatment B~(N=&N2.)~n/n' (%)"
        COL3 = "Treatment C~(N=&N3.)~n/n' (%)"
        COL4 = "Treatment D~(N=&N4.)~n/n' (%)"
        COL5 = "Treatment E~(N=&N5.)~n/n' (%)"
        COL6 = "Total~(N=&N6.)~n/n' (%)"
    ;
    keep BYVAR GRPX: ITEM: COL: ;
    proc sort; by GRPX1 GRPX2 GRPX3;
run;
/* end -----------------------------------------------------------------------*/




/* output --------------------------------------------------------------------*/
%LET GMPXLERR=0;
%gmpagebreak(
    dataIn=final_table,
    dataOut=tables.&TFLNAME,
    vars=
        GRPX1 \TYPE=order \BYPAGE=Y
        @BYVAR \TYPE=order
        @GRPX2 \TYPE=order \LOGICALPAGEBREAK=Y
        @GRPX3 \TYPE=order
        ,
    linesPerPage=15
    );

%LET GMPXLERR = 0;
%gmTrimVarLen(dataIn=tables.&TFLNAME);

ods listing close;
ods rtf file="&_otables.&TFLNAME..rtf" style=global.rtf operator="~{\dntblnsbdb}";
ods escapechar="~";
%loadtf(tabout=&TFLNAME, prg=&PGMNAME.);

title6 j=l "#byval3";
proc report data=tables.&TFLNAME nowd split="~" headline headskip missing spacing=1
            style(header) = [just=c protectspecialchars=off asis=on]
            style(column) = [just=l protectspecialchars=off asis=on]
            style(lines)  = [protectspecialchars=off asis=on]
            style(report) = [protectspecialchars=off asis=on outputwidth=100%];

    column GRPXPAG GRPX1 BYVAR GRPX2 ITEM1 GRPX3 ITEM2 COL1-COL6;
        by GRPXPAG GRPX1 BYVAR;
    define GRPXPAG / order noprint;
    define GRPX1 / order noprint;
    define BYVAR / order noprint;
    define GRPX2 / order noprint;
    define GRPX3 / order noprint;
    define ITEM1 / order flow style(column)=[cellwidth=11%] style(header)=[just=l];
    define ITEM2 / display flow style(column)=[cellwidth=11%] style(header)=[just=l];
    define COL1 / display flow style(column)=[cellwidth=12.5%];
    define COL2 / display flow style(column)=[cellwidth=12.5%];
    define COL3 / display flow style(column)=[cellwidth=12.5%];
    define COL4 / display flow style(column)=[cellwidth=12.5%];
    define COL5 / display flow style(column)=[cellwidth=12.5%];
    define COL6 / display flow style(column)=[cellwidth=12.5%];

    break after GRPXPAG / page;
    compute before GRPX2;
        line @1 " ";
    endcomp;
run;
ods rtf close;
ods listing;

%LET GMPXLERR=0;
%pageno(file="&_otables.&TFLNAME..rtf");
/* end -----------------------------------------------------------------------*/

