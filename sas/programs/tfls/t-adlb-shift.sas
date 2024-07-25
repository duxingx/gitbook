/*-----------------------------------------------------------------------------
  PAREXEL INTERNATIONAL LTD

  Sponsor/Protocol No:   LG Chem Ltd / lgchm
  PAREXEL Study Code:    269459

  SAS Version:           9.4
  Operating System:      UNIX
-------------------------------------------------------------------------------

  Owner:                 $LastChangedBy: Bonnie Wang (pic0bxw5)$
  Last Modified:         $LastChangedDate: 2024-01-05 02:12:06$

  Program Location/Name: $HeadURL: No remote:dmc/prog/tables/t-adlb-shift.sas$
  SVN Revision No:       $Rev: 498 $

  Files Created:         t_adlb_shift.sas7bdat
                         t_adlb_shift.log

  Program Purpose:       Table 13 Summary of Abnormal Laboratory by Visit (Safety Analysis Set)

-----------------------------------------------------------------------------*/



/* Clear the environment -----------------------------------------------------*/
proc datasets library=work kill nowarn nolist memtype=data; quit;
options validvarname=v7;
options minoperator;
dm log 'CLEAR';
dm out 'CLEAR';
/* end -----------------------------------------------------------------------*/



/* macro variables, system options, and so on---------------------------------*/
%LET GMPXLERR = 0;
%LET PGMNAME = t-adlb-shift;
%LET TFLNAME = t_adlb_shift;

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
    value BNRNC
        1="Total N"
        2="Normal"
        3="Abnormal"
        4="Abnormal Low"
        5="Abnormal High"
        6="Missing"
        7="Total"
    ;
    value BNR2NC
        1="Total N"
        2="Negative"
        3="Positive"
        4="Abnormal Low"
        5="Abnormal High"
        6="Missing"
        7="Total"
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
    value TRTNC
        1="Treatment A"
        2="Treatment B"
        3="Treatment C"
        4="Treatment D"
        5="Treatment E"
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
data adlb_filter;
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
        or (PARCAT1N = 5 and PARAMCD in ("HBSAG", "HCVVLE", "HCAB", "HIV1VLE", "HIV1P24", "HIV1CONF", "HIV2CONF", "HIVCONF")) ;
    /* baseline records based on ABLFL, instead of DMVISITN */
    if ABLFL = "Y" then DMVISITN = 4;
run;

%intoFmt(fmtname="PARMCC", indat=adlb_filter, start=PARAMCD, label=PARAM, type=C)
%intoFmt(fmtname="PARMNC", indat=adlb_filter, start=PARAMN, label=PARAMCD, type=N)


/* UPDATE COMMENTS: Xingxing Du (2023-07-05 14:18:53)
    @Follow: SR review comments
    @Description: calculate missing by BIGN */
proc sql noprint;
    /* used in dummy do loop */
    select distinct DMVISITN into : VIS2 separated by ", " from adlb_filter where ^missing(DMVISITN) ;

    /* used in dummy do loop */
    select distinct PARAMN into : PARN separated by "," from adlb_filter where ^missing(DMVISITN) ;
quit;

proc sort data=adlb_filter out=subj_dup(keep=USUBJID DMTR01AN) nodupkey; by USUBJID; run;
data lb_dum;
    set subj_dup;
    do PARAMN = &PARN.;
        do DMVISITN = &VIS2.;
                PARAMCD = put(PARAMN, PARMNC.);
            output;
        end;
    end;
run;
proc sort data=lb_dum; by USUBJID DMTR01AN PARAMN PARAMCD DMVISITN; run;
proc sort data=adlb_filter; by USUBJID DMTR01AN PARAMN PARAMCD DMVISITN; run;
data lb_impmiss;
    merge lb_dum(in=a) adlb_filter(in=b);
    by USUBJID DMTR01AN PARAMN PARAMCD DMVISITN;
    if a;

    if missing(ANRIND) then ANRIND = "Missing";
    else ANRIND = ANRIND;

    drop BNRIND;
run;

data adlb_base;
    set adlb_filter;
    if ABLFL="Y";
    keep USUBJID DMTR01AN PARAMN PARAMCD BNRIND;
run;

proc sort data=lb_impmiss; by USUBJID DMTR01AN PARAMN PARAMCD; run;
proc sort data=adlb_base; by USUBJID DMTR01AN PARAMN PARAMCD; run;
data adlb_impul;
    merge lb_impmiss(in=a) adlb_base(in=b);
    by USUBJID DMTR01AN PARAMN PARAMCD;
    if a;

    if missing(BNRIND) then BNRIND = "Missing";
    else BNRIND = BNRIND;
run;
/* UPDATE END */


data adlb_tot;
    set adlb_impul;
    output;
    DMTR01AN = 6;
    output;
run;

data adlb_tot;
    length ANRIND $200;
    set adlb_tot;
    output;
    ANRIND = "TOTAL";
    output;
run;
data adlb_tot;
    length BNRIND $200;
    set adlb_tot;
    output;
    BNRIND = "TOTAL";
    output;
run;
data adlb_tot;
    length SHIFT2 $200;
    set adlb_tot;
    SHIFT2 = strip(BNRIND) || "-" || strip(ANRIND);
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


/* sub N */
proc sql noprint;
    create table nsub as
        select DMTR01AN, PARAMN, PARAMCD, DMVISITN, count(distinct USUBJID) as NSUB
        from adlb_tot
        group by DMTR01AN, PARAMN, PARAMCD, DMVISITN;
quit;

/* calculate count */
proc sql noprint;
    create table freq_lb as
        select DMTR01AN, PARAMCD, PARAMN, DMVISITN, SHIFT2, count(distinct USUBJID) as CNT_N
        from adlb_tot
        group by DMTR01AN, PARAMCD, PARAMN, DMVISITN, SHIFT2 ;
quit;
data freq_lb2;
    length BNRIND ANRIND $200.;
    set freq_lb;
    BNRIND = strip(scan(SHIFT2, 1, "-"));
    ANRIND = strip(scan(SHIFT2, 2, "-"));
run;
proc sort data= freq_lb2; by DMTR01AN PARAMCD PARAMN DMVISITN BNRIND; run;
proc transpose data=freq_lb2 out=freq_lb2_trans;
    by DMTR01AN PARAMCD PARAMN DMVISITN BNRIND;
    var CNT_N;
    id ANRIND;
run;
data freq;
    length BNRN NORMAL ABNORMAL LOW HIGH MISSING TOTAL 8.;
    retain BNRN NORMAL ABNORMAL LOW HIGH MISSING TOTAL .;
    set freq_lb2_trans;
    if strip(upcase(BNRIND)) = "TOTAL N" then BNRN = 1;
    else if strip(upcase(BNRIND))="NORMAL" then BNRN = 2;
    else if strip(upcase(BNRIND))="ABNORMAL" then BNRN = 3;
    else if strip(upcase(BNRIND)) = "LOW" then BNRN = 4;
    else if strip(upcase(BNRIND)) = "HIGH" then BNRN = 5;
    else if strip(upcase(BNRIND)) = "MISSING" then BNRN = 6;
    else if strip(upcase(BNRIND)) = "TOTAL" then BNRN = 7;
    else put "WARNING:[PXL] a unexpected BNRIND value. " BNRIND=;
run;
/* END -----------------------------------------------------------------------*/



/* DUMMY ---------------------------------------------------------------------*/

proc sql noprint;
    /* used in dummy do loop */
    select distinct DMVISITN into : VIS separated by " " from adlb_tot;

    /* used in dummy do loop */
    select distinct PARAMN into : PARN separated by "," from adlb_tot;

    /* used in output macro do loop */
    select distinct PARAMN into : PARN2 separated by " " from adlb_tot;

    /* For laboratory result reported as categorical variable */
    select distinct PARAMN into: POS_PAR separated by ' ' from adlb_tot
        where ^missing(LBSTNRC);
quit;

data dum_shell;
    length PARAMCD ITEM1 ITEM2 $200.;
    do PARAMN = &PARN.;
        do DMVISITN = 4 to 16;
            do BNRN = 1 to 7;
                do DMTR01AN=1 to 5;
                    PARAMCD = put(PARAMN, PARMNC.);
                    BAVAR = put(PARAMCD, $PARMCC.);
                    ITEM1 = put(DMVISITN, VISNC.);
                    /* For laboratory result reported as categorical variable (e.g., +/-, positive/negative), result will be categorized as Normal, Abnormal */
                    if PARAMN in (&POS_PAR.) and PARAMCD not in ("SARSCOV2") then do;
                        ITEM2 = put(BNRN, BNRNC.);
                        if ITEM2 not in ("Abnormal Low", "Abnormal High") then output;
                    end;
                    /* For SARS-CoV-2 Test (if applicable), results will be categorized as Positive, Negative */
                    else if PARAMCD in ("SARSCOV2") then do;
                        ITEM2 = put(BNRN, BNR2NC.);
                        if ITEM2 not in ("Abnormal Low", "Abnormal High") then output;
                    end;
                    /* For laboratory result reported as continuous variable, result will be categorized as Normal, Abnormal Low (< LLN), Abnormal High (>ULN).  */
                    else do;
                        ITEM2 = put(BNRN, BNRNC.);
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
        from dum_shell as a
        left join bign as b on a.DMTR01AN=b.DMTR01AN
        left join nsub as c on a.DMTR01AN=c.DMTR01AN and a.PARAMN=c.PARAMN and a.DMVISITN=c.DMVISITN
    ;
quit;

/* filter dummy data follow SAP */
data dum_shell2;
    set dum_shell1;
    /* Serology (at screening only) */
    if PARAMCD in ("HBSAG", "HCVVLE", "HCAB", "HIV1CONF", "HIV2CONF") and DMVISITN ^= 4 then delete;

    /* Lipid panels will be performed at Visits 4 (Week 0),
    Visit 14 (Month 6) and Visit 16 (Month 12). */
    if PARAMCD in ('CHOL', 'HDL', 'LDL', 'TRIG') and DMVISITN not in (4, 14,16) then delete;

    /* eGFR will be performed at Visit 1 (Screening), Visit 3 (Subject
    who requires washout period), Visits 4 (Week 0), Visit 14 (Month 6) and Visit 16 (Month 12). */
    if PARAMCD in ("ECKDEPI") and DMVISITN not in (1,3,4,14,16) then delete;

    /* A coagulation panel is required at baseline (Visit 4) only */
    if PARAMCD in ("INR", "APTT") and DMVISITN ^= 4 then delete;

    /* HbA1c will be performed at Visit 1 (Screening), Visit 4 (Week 0),
    Visit 11 (Month 3), Visit 14 (Month 6), Visit 15 (Month 9), and Visit 16 (Month 12) */
    if PARAMCD in ("HBA1C") and DMVISITN not in (1,4,11,14,15,16) then delete;

    /* Fasting Plasma Glucose and Fasting Plasma Insulin will be performed
    at Visit 4 (Week 0), Visit 11 (Month 3), Visit 14 (Month 6),
    Visit 15 (Month 9), and Visit 16 (Month 12) */
    if PARAMCD in ("FGLUP", "INS") and DMVISITN not in (4,11,14,15,16) then delete;
run;
/* end -----------------------------------------------------------------------*/




/* FINAL ---------------------------------------------------------------------*/
/* merge FREQ with DUMMY */
proc sort data=dum_shell2; by DMTR01AN PARAMCD PARAMN DMVISITN BNRN; run;
proc sort data=freq; by DMTR01AN PARAMCD PARAMN DMVISITN BNRN; run;
data tab_freq;
    merge dum_shell2(in=a) freq(in=b);
    by DMTR01AN PARAMCD PARAMN DMVISITN BNRN;
    if a;
run;

/* UPDATE COMMENTS: Xingxing Du (2023-07-05 16:25:44)
    @Follow: SR review comments
    @Description: calculate missing by BIGN. just keep the adlb visit by usubjid, paramcd */
proc sort data=adlb_filter out=adlb_dup(keep=DMTR01AN PARAMCD DMVISITN) nodupkey; by DMTR01AN PARAMCD DMVISITN;
proc sort data=tab_freq; by DMTR01AN PARAMCD DMVISITN; run;
proc sort data=adlb_dup; by DMTR01AN PARAMCD DMVISITN; run;
data tab_all0;
    merge tab_freq(in=a) adlb_dup(in=b);
    by DMTR01AN PARAMCD DMVISITN;
    if a then do;
        if b then FLAG= "Y";
        output;
    end;
    else delete;
run;



/* filter value: for no records week */
data tab_all1;
    set tab_all0;
    if missing(nsub) then delete;

    if DMVISITN = 4 then delete;

    if FLAG ^= "Y" then delete;
run;


data final;
    length BYVAR COL1-COL6 $200.;
    set tab_all1;
    /* Parameter: XXXXXXXXXX (unit) Treatment Group: Treatment A */
    BYVAR = "Parameter: " || strip(put(PARAMCD, $PARMCC.)) || "~nTreatment Group: " || strip(put(DMTR01AN, TRTNC.));
    if PARAMN = 37 then do;
        BYVAR = "Parameter: eGFR CKD-EPI (mL/min/1.73m~{super 2})" || "~nTreatment Group: " || strip(put(DMTR01AN, TRTNC.));;
    end;

    /* COL */
    if not missing(NORMAL) then
        COL1 = put(NORMAL, PCTN.) || put(NORMAL / BIGN * 100, PCTP.);
    if not missing(ABNORMAL) then
        COL2 = put(ABNORMAL, PCTN.) || put(ABNORMAL / BIGN * 100, PCTP.);
    if not missing(LOW) then
        COL3 = put(LOW, PCTN.) || put(LOW / BIGN * 100, PCTP.);
    if not missing(HIGH) then
        COL4 = put(HIGH, PCTN.) || put(HIGH / BIGN * 100, PCTP.);
    if not missing(MISSING) then
        COL5 = put(MISSING, PCTN.) || put(MISSING / BIGN * 100, PCTP.);
    if not missing(TOTAL) then
        COL6 = put(TOTAL, PCTN.) || put(TOTAL / BIGN * 100, PCTP.);

    /* ITEM: Total (N=XX)*/
    if BNRN=1 then do;
        ITEM2="Total (N=" ||strip(put(BIGN, best.)) || ")";
        call missing(of COL1-COL6);
    end;
    else do;
        if missing(COL1) then COL1 = '  0';
        if missing(COL2) then COL2 = '  0';
        if missing(COL3) then COL3 = '  0';
        if missing(COL4) then COL4 = '  0';
        if missing(COL5) then COL5 = '  0';
        if missing(COL6) then COL6 = '  0';
    end;
    if PARAMN not in (&POS_PAR.) then call missing(COL2);
    else if PARAMN in (&POS_PAR) then call missing(COL3, COL4);
    GRPX1 = PARAMN;
    GRPX2 = DMTR01AN;
    GRPX3 = DMVISITN;
    GRPX4 = BNRN;

    /* according to the order of Positive, Negative */
    /* UPDATE COMMENTS: Xingxing Du (2023-06-26 11:39:38)
        @Follow: QC
        @Description: Because the PARAMN is variable, now use PARAMCD or PARAM */
    if PARAMCD in ("SARSCOV2") and BNRN = 2 then GRPX4 = 3;
    else if PARAMCD in ("SARSCOV2") and BNRN = 3 then GRPX4 = 2;

    label
        ITEM1 = "Timepoint"
        ITEM2 = "Baseline~Abnormality"
        COL1 = "Normal~n (%)"
        COL2 = "Abnormal~n (%)"
        COL3 = "Abnormal Low~n (%)"
        COL4 = "Abnormal High~n (%)"
        COL5 = "Missing~n (%)"
        COL6 = "Total~n (%)"
    ;
    keep BYVAR GRPX: ITEM: COL: ;
    proc sort; by GRPX1 GRPX2 GRPX3 GRPX4;
run;
/* end -----------------------------------------------------------------------*/




/* output --------------------------------------------------------------------*/
%LET GMPXLERR=0;
%gmpagebreak(
    dataIn=final,
    dataOut=tables.&TFLNAME,
    vars=
        GRPX1 \TYPE=order
        @GRPX2 \TYPE=order
        @BYVAR \TYPE=order \BYPAGE=Y
        @GRPX3 \TYPE=order \LOGICALPAGEBREAK=Y
        @GRPX4 \TYPE=order
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
/* the macro handle the situation: multiple header */
%MACRO repeat();
    %let line1=%sysfunc(repeat(_,66));
    %let line2=%sysfunc(repeat(_,60));
    %local i NEXT_PAR;
    %let i = 1;
    %do %while (%scan(&PARN2., &i) ne );
        %let NEXT_PAR = %scan(&PARN2, &i);
        %do TRTN =1 %to 5;
            /* For laboratory result reported as categorical variable (e.g., +/-, positive/negative) */
            %if &NEXT_PAR. in (&POS_PAR.) and &NEXT_PAR. ^= 73 %then %do;
                proc report data=tables.&TFLNAME(where=(GRPX2=&TRTN. and GRPX1=&NEXT_PAR.))
                        nowd split="~" headline headskip missing spacing=1
                        style(header) = [just=c protectspecialchars=off asis=on]
                        style(column) = [just=l protectspecialchars=off asis=on]
                        style(lines)  = [protectspecialchars=off asis=on]
                        style(report) = [protectspecialchars=off asis=on outputwidth=100%];
                    column GRPXPAG GRPX1 GRPX2 BYVAR GRPX3 ITEM1 GRPX4 ITEM2
                        ("Post-Baseline~&line2." COL1 COL2 COL5) COL6;
                        by GRPXPAG GRPX1 BYVAR;
                    define GRPXPAG / order noprint;
                    define GRPX1 / order noprint;
                    define GRPX2 / order noprint;
                    define BYVAR / order noprint;
                    define GRPX3 / order noprint;
                    define GRPX4 / order noprint;
                    define ITEM1 / order flow style(column)=[cellwidth=14%] style(header)=[just=l];
                    define ITEM2 / display flow style(column)=[cellwidth=17%] style(header)=[just=l];
                    define COL1 / display flow style(column)=[cellwidth=17% pretext="    "] "Normal~n (%)";
                    define COL2 / display flow style(column)=[cellwidth=17% pretext="    "] "Abnormal~n (%)";
                    define COL5 / display flow style(column)=[cellwidth=17% pretext="    "] "Missing~n (%)";
                    define COL6 / display flow style(column)=[cellwidth=17% pretext="    "] "Total~n (%)";

                    break after GRPXPAG / page;
                    compute before GRPX3;
                        line @1 " ";
                    endcomp;
                run;
            %end;
            /* For SARS-CoV-2 Test (if applicable), results will be categorized as Positive, Negative. */
            %else %if &NEXT_PAR.= 73 %then %do;
                proc report data=tables.&TFLNAME(where=(GRPX2=&TRTN. and GRPX1=&NEXT_PAR.))
                        nowd split="~" headline headskip missing spacing=1
                        style(header) = [just=c protectspecialchars=off asis=on]
                        style(column) = [just=l protectspecialchars=off asis=on]
                        style(lines)  = [protectspecialchars=off asis=on]
                        style(report) = [protectspecialchars=off asis=on outputwidth=100%];
                    column GRPXPAG GRPX1 GRPX2 BYVAR GRPX3 ITEM1 GRPX4 ITEM2
                        ("Post-Baseline~&line2." COL2 COL1 COL5) COL6;
                        by GRPXPAG GRPX1 BYVAR;
                    define GRPXPAG / order noprint;
                    define GRPX1 / order noprint;
                    define GRPX2 / order noprint;
                    define BYVAR / order noprint;
                    define GRPX3 / order noprint;
                    define GRPX4 / order noprint;

                    define ITEM1 / order flow style(column)=[cellwidth=14%] style(header)=[just=l];
                    define ITEM2 / display flow style(column)=[cellwidth=17%] style(header)=[just=l];
                    define COL1 / display flow style(column)=[cellwidth=17% pretext="    "] "Negative~n (%)";
                    define COL2 / display flow style(column)=[cellwidth=17% pretext="    "] "Positive~n (%)";
                    define COL5 / display flow style(column)=[cellwidth=17% pretext="    "] "Missing~n (%)";
                    define COL6 / display flow style(column)=[cellwidth=17% pretext="    "] "Total~n (%)";

                    break after GRPXPAG / page;
                    compute before GRPX3;
                        line @1 " ";
                    endcomp;
                run;
            %end;
            /* For laboratory result reported as continuous variable */
            %else %do;
                proc report data=tables.&TFLNAME(where=(GRPX2=&TRTN. and GRPX1=&NEXT_PAR.))
                        nowd split="~" headline headskip missing spacing=1
                        style(header) = [just=c protectspecialchars=off asis=on]
                        style(column) = [just=l protectspecialchars=off asis=on]
                        style(lines)  = [protectspecialchars=off asis=on]
                        style(report) = [protectspecialchars=off asis=on outputwidth=100%];
                    column GRPXPAG GRPX1 GRPX2 BYVAR GRPX3 ITEM1 GRPX4 ITEM2
                        ("Post-Baseline~&line1." COL1 COL3 COL4 COL5) COL6;
                        by GRPXPAG GRPX1 BYVAR;
                    define GRPXPAG / order noprint;
                    define GRPX1 / order noprint;
                    define GRPX2 / order noprint;
                    define BYVAR / order noprint;
                    define GRPX3 / order noprint;
                    define GRPX4 / order noprint;

                    define ITEM1 / order flow style(column)=[cellwidth=14%] style(header)=[just=l];
                    define ITEM2 / display flow style(column)=[cellwidth=15%] style(header)=[just=l];
                    define COL1 / display flow style(column)=[cellwidth=14% pretext="  "] "Normal~n (%)";
                    define COL3 / display flow style(column)=[cellwidth=14% pretext="  "] "Abnormal Low~n (%)";
                    define COL4 / display flow style(column)=[cellwidth=14% pretext="  "] "Abnormal High~n (%)";
                    define COL5 / display flow style(column)=[cellwidth=14% pretext="  "] "Missing~n (%)";
                    define COL6 / display flow style(column)=[cellwidth=14% pretext="  "] "Total~n (%)";

                    break after GRPXPAG / page;
                    compute before GRPX3;
                        line @1 " ";
                    endcomp;
                run;
            %end;
        %end;
        %let i = %eval(&i. + 1);
    %end;
%MEND;
%repeat();

ods rtf close;
ods listing;

%LET GMPXLERR=0;
%pageno(file="&_otables.&TFLNAME..rtf");
/* end -----------------------------------------------------------------------*/




/*

%LET GMPXLERR=0;
%gmCompare(   pathOut         = &_qtables.
            , dataMain        = tables.&TFLNAME.
            , CompareData     = comparedata
            , libraryQC       = qtab
            , selectDataType  = OUTALL
            , checkVarOrder   = 1
);

data main;
    set tables.&TFLNAME;
    keep BYVAR ITEM: COL:;
run;

data compare;
    set qtab.&TFLNAME;
    keep BYVAR ITEM: COL:;
run;

proc sort data=main; by BYVAR ITEM1 ITEM2; run;
proc sort data=compare; by BYVAR ITEM1 ITEM2; run;
proc compare data=main compare=compare out=proccomparedata outbase outcomp outdiff outnoequal noprint;
    id BYVAR ITEM1 ITEM2;
run;
 */
