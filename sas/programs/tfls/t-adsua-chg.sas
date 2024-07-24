/*-----------------------------------------------------------------------------
  PAREXEL INTERNATIONAL LTD

  Sponsor/Protocol No:   LG Chem Ltd / lgchm
  PAREXEL Study Code:    269461

  SAS Version:           9.4
  Operating System:      UNIX
-------------------------------------------------------------------------------

  Owner:                 $LastChangedBy: Bonnie Wang (pic0bxw5)$
  Last Modified:         $LastChangedDate: 2024-01-05 02:12:06$

  Program Location/Name: $HeadURL: No remote:dmc/prog/tables/t-adsua-chgsua.sas$
  SVN Revision No:       $Rev: 503 $

  Files Created:         Table 3

  Program Purpose:       Summary of Serum Uric Acid (sUA) (mg/dL) Level by Visit and Treatment Group (Safety Analysis Set)

-----------------------------------------------------------------------------*/



/* Clear the environment -----------------------------------------------------*/
proc datasets library=work kill nowarn nolist memtype=data; quit;
options validvarname=v7;
dm log 'CLEAR';
dm out 'CLEAR';
/* end -----------------------------------------------------------------------*/



/* macro variables, system options -------------------------------------------*/
%LET GMPXLERR = 0;
%LET PGMNAME = t-adsua-chgsua;
%LET TFLNAME = t_adsua_chgsua;
/* end -----------------------------------------------------------------------*/

proc format;
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
    ;
    value ITEMNC
        1 = "n"
        2 = "Mean"
        3 = "SD"
        4 = "Median"
        5 = "Min"
        6 = "Max"
    ;
run;
/* end -----------------------------------------------------------------------*/





/* main code -----------------------------------------------------------------*/
/* total group */
data adsl; set analysis.adsl; run;
data adsua; set analysis.adsua; run;
data adsl_tot;
    set adsl(where=(SAFFL="Y"));
run;
data adsua_tot;
    set adsua(where=(SAFFL="Y"));

    if  ANL11FL="Y"
        and LBSTAT ^= "NOT DONE"
        and PARAMCD in ("URIC");
run;

/*big N*/
proc sql noprint;
    select count(distinct USUBJID) into :N1 trimmed from adsl_tot where DMTR01AN=1;
    select count(distinct USUBJID) into :N2 trimmed from adsl_tot where DMTR01AN=2;
    select count(distinct USUBJID) into :N3 trimmed from adsl_tot where DMTR01AN=3;
    select count(distinct USUBJID) into :N4 trimmed from adsl_tot where DMTR01AN=4;
    select count(distinct USUBJID) into :N5 trimmed from adsl_tot where DMTR01AN=5;
    select count(distinct USUBJID) into :N6 trimmed from adsl_tot where DMTR01AN=6;
quit;

%LET GMPXLERR = 0;
%gmTableDesc(
    dataIn = adsua_tot,
    dataOut = tab_1,
    selectData = %str(DMVISITN in (5:16)),
    vars = aval chg,
    varsBy = DMVISITN PARAMN DMTR01AN,
    transpose = var+lastBy,
    selectStat = N MEAN STD MEDIAN MIN MAX,
    fmtYN = Y
);
%LET GMPXLERR = 0;
%gmTableDescFmt(
        varsByDec=DMVISITN PARAMN,
        varsByAllYN=Y,
        fmtMethod  =
            N
                \LABEL=n
                \PATTERN=<n>
                \DECN= N6
                \DECS= S0
            @MEAN
                \LABEL=Mean
                \PATTERN=<mean>
                \DECN= N6
                \DECS= S+1
                \MTEXT= $NA$
                \NRPATTERN= NA$$
            @STD
                \LABEL=SD
                \PATTERN=<std>
                \DECN= N6
                \DECS= S+1
                \MTEXT=     NA$
                \MAXDEC=3$
            @MEDIAN
                \LABEL=Median
                \DECN= N6
                \DECS= S+1
                \MAXDEC=3$
            @MIN
                \LABEL=Min
                \DECN= N6
                \DECS= S+0
                \NRPATTERN= NA$$
            @MAX
                \LABEL=Min-Max
                \DECN= N6
                \DECS= S+0
                \NRPATTERN= NA$$
);

/* baseline */
%LET GMPXLERR = 0;
%gmTableDesc(
    dataIn = adsua_tot,
    dataOut = tab_2,
    selectData = %str(ABLFL="Y"),
    vars = aval chg,
    varsBy = PARAMN DMTR01AN,
    transpose = var+lastBy,
    selectStat = N MEAN STD MEDIAN MIN MAX,
    fmtYN = Y
);
%LET GMPXLERR = 0;
%gmTableDescFmt(
        varsByDec= PARAMN,
        varsByAllYN=Y,
        fmtMethod  =
            N
                \LABEL=n
                \PATTERN=<n>
                \DECN= N6
                \DECS= S0
            @MEAN
                \LABEL=Mean
                \PATTERN=<mean>
                \DECN= N6
                \DECS= S+1
                \MTEXT= $NA$
                \NRPATTERN= NA$$
            @STD
                \LABEL=SD
                \PATTERN=<std>
                \DECN= N6
                \DECS= S+1
                \MTEXT=$    NA$
                \MAXDEC=3$
            @MEDIAN
                \LABEL=Median
                \DECN= N6
                \DECS= S+1
                \MAXDEC=3$
            @MIN
                \LABEL=Min
                \DECN= N6
                \DECS= S+0
                \NRPATTERN= NA$$
            @MAX
                \LABEL=Min-Max
                \DECN= N6
                \DECS= S+0
                \NRPATTERN= NA$$
);
data tab_2_c;
    set tab_2_c;
    DMVISITN = 4;
run;
data tab1;
    set tab_1_c tab_2_c;
run;
data tab2(keep= PARAMN DMVISITN ITEMN COL:);
    length aval_1 chg_1 aval_2 chg_2 aval_3 chg_3 aval_4 chg_4 chg_5 $200.;
    retain aval_1 chg_1 aval_2 chg_2 aval_3 chg_3 aval_4 chg_4 chg_5 "";
    set tab1;
    rename
        gmTD_statOrder = ITEMN
        aval_1 = COL1
        chg_1 = COL2
        aval_2 = COL3
        chg_2 = COL4
        aval_3 = COL5
        chg_3 = COL6
        aval_4 = COL7
        chg_4 = COL8
        aval_5 = COL9
        chg_5 = COL10;;
run;
proc sql noprint;
    select distinct DMVISITN into : VIS separated by "," from adsua_tot where DMVISITN ^= .;
quit;
/* dummy */
data dum_shell;
    length ITEM1 $200.;
    do DMVISITN = &VIS.;
        do ITEMN = 0 to 6;
            if ITEMN = 0
                then ITEM1 = put(DMVISITN, VISNC.);
                else ITEM1 = "  " || put(ITEMN, ITEMNC.);
            output;
        end;
    end;
run;

/* merge dummy */
proc sort data=dum_shell; by DMVISITN ITEMN; run;
proc sort data=tab2; by DMVISITN ITEMN; run;
data tab_freq;
    merge dum_shell(in=a) tab2(in=b);
    by DMVISITN ITEMN;
    if a;
run;

data tab_gobs;
    set tab_freq;
    if ITEMN = 1;

    OBSCOL1 = input(strip(COL1), best.);
    OBSCOL2 = input(strip(COL2), best.);
    OBSCOL3 = input(strip(COL3), best.);
    OBSCOL4 = input(strip(COL4), best.);
    OBSCOL5 = input(strip(COL5), best.);
    OBSCOL6 = input(strip(COL6), best.);
    OBSCOL7 = input(strip(COL7), best.);
    OBSCOL8 = input(strip(COL8), best.);
    OBSCOL9 = input(strip(COL9), best.);
    OBSCOL10 = input(strip(COL10), best.);
    keep DMVISITN OBSCOL: ;
run;

proc sort data=tab_gobs; by DMVISITN; run;
proc sort data=tab_freq; by DMVISITN; run;
data tab_all_1;
    merge tab_freq(in=a) tab_gobs(in=b);
    by DMVISITN;
    if a;
run;


/* filter value */
data tab_all;
    set tab_all_1;

    if ITEMN = 1 then do;
        /*  If no subjects have data, then only n=0 will be presented. */
        if OBSCOL1  = 0 or OBSCOL1  = .  then COL1 = "     0";
        if OBSCOL2  = 0 or OBSCOL2  = .  then COL2 = "     0";
        if OBSCOL3  = 0 or OBSCOL3  = .  then COL3 = "     0";
        if OBSCOL4  = 0 or OBSCOL4  = .  then COL4 = "     0";
        if OBSCOL5  = 0 or OBSCOL5  = .  then COL5 = "     0";
        if OBSCOL6  = 0 or OBSCOL6  = .  then COL6 = "     0";
        if OBSCOL7  = 0 or OBSCOL7  = .  then COL7 = "     0";
        if OBSCOL8  = 0 or OBSCOL8  = .  then COL8 = "     0";
        if OBSCOL9  = 0 or OBSCOL9  = .  then COL9 = "     0";
        if OBSCOL10  = 0 or OBSCOL10  = .  then COL10 = "     0";
    end;
    if 4 >= ITEMN > 1 then do;
        /* If n < 3 then the n, minimum, and maximum only will be presented. */
        if 0 < OBSCOL1 < 3 then COL1 = "    NA";
        if 0 < OBSCOL2 < 3 then COL2 = "    NA";
        if 0 < OBSCOL3 < 3 then COL3 = "    NA";
        if 0 < OBSCOL4 < 3 then COL4 = "    NA";
        if 0 < OBSCOL5 < 3 then COL5 = "    NA";
        if 0 < OBSCOL6 < 3 then COL6 = "    NA";
        if 0 < OBSCOL7 < 3 then COL7 = "    NA";
        if 0 < OBSCOL8 < 3 then COL8 = "    NA";
        if 0 < OBSCOL9 < 3 then COL9 = "    NA";
        if 0 < OBSCOL10 < 3 then COL10 = "    NA";

        /* If n = 3 then n, mean, median, minimum and maximum will be presented only */
        if OBSCOL1 = 3 and ITEMN = 3 then COL1 = "    NA";
        if OBSCOL2 = 3 and ITEMN = 3 then COL2 = "    NA";
        if OBSCOL3 = 3 and ITEMN = 3 then COL3 = "    NA";
        if OBSCOL4 = 3 and ITEMN = 3 then COL4 = "    NA";
        if OBSCOL5 = 3 and ITEMN = 3 then COL5 = "    NA";
        if OBSCOL6 = 3 and ITEMN = 3 then COL6 = "    NA";
        if OBSCOL7 = 3 and ITEMN = 3 then COL7 = "    NA";
        if OBSCOL8 = 3 and ITEMN = 3 then COL8 = "    NA";
        if OBSCOL9 = 3 and ITEMN = 3 then COL9 = "    NA";
        if OBSCOL10 = 3 and ITEMN = 3 then COL10 = "    NA";

    end;
    if ITEMN = 5 or ITEMN = 6 then do;
        if OBSCOL1  = 0 or OBSCOL1  = .  then COL1 = "";
        if OBSCOL2  = 0 or OBSCOL2  = .  then COL2 = "";
        if OBSCOL3  = 0 or OBSCOL3  = .  then COL3 = "";
        if OBSCOL4  = 0 or OBSCOL4  = .  then COL4 = "";
        if OBSCOL5  = 0 or OBSCOL5  = .  then COL5 = "";
        if OBSCOL6  = 0 or OBSCOL6  = .  then COL6 = "";
        if OBSCOL7  = 0 or OBSCOL7  = .  then COL7 = "";
        if OBSCOL8  = 0 or OBSCOL8  = .  then COL8 = "";
        if OBSCOL9  = 0 or OBSCOL9  = .  then COL9 = "";
        if OBSCOL10  = 0 or OBSCOL10  = .  then COL10 = "";
    end;
    /* for baseline, chg */
    if DMVISITN = 4 then do;
        COL2 = "";
        COL4 = "";
        COL6 = "";
        COL8 = "";
        COL10 = "";
    end;

run;

/* label */
data final_table;
    set tab_all;
    GRPX1 = DMVISITN;
    GRPX2 = ITEMN;
    label
        ITEM1 = "Timepoint~  Statistics"
        COL1 = "Value"
        COL2 = "Change"
        COL3 = "Value"
        COL4 = "Change"
        COL5 = "Value"
        COL6 = "Change"
        COL7 = "Value"
        COL8 = "Change"
        COL9 = "Value"
        COL10 = "Change"
    ;
    keep GRPX: ITEM1 COL: ;
    proc sort; by GRPX1 GRPX2;
run;
/* end -----------------------------------------------------------------------*/


/* create the lines of cross header */
%LET line1=%sysfunc(repeat(_,22));
%LET line2=%sysfunc(repeat(_,22));
%LET line3=%sysfunc(repeat(_,22));
%LET line4=%sysfunc(repeat(_,22));
%LET line5=%sysfunc(repeat(_,22));

/* output --------------------------------------------------------------------*/
%LET GMPXLERR=0;
%gmpagebreak(
    dataIn=final_table,
    dataOut=tables.&TFLNAME,
    vars=
        GRPX1 \TYPE=order \LOGICALPAGEBREAK=Y
        @GRPX2 \TYPE=order
        ,
    linesPerPage=14
    );

%LET GMPXLERR = 0;
%gmTrimVarLen(dataIn=tables.&TFLNAME);

ods listing close;
ods rtf file="&_otables.&TFLNAME..rtf" style=global.rtf operator="~{\dntblnsbdb}";
ods escapechar="~";
%loadtf(tabout=&TFLNAME, prg=&PGMNAME.);

proc report data=tables.&TFLNAME nowd split="~" headline headskip missing spacing=1
            style(header) = [just=c protectspecialchars=off asis=on]
            style(column) = [just=l protectspecialchars=off asis=on]
            style(lines)  = [protectspecialchars=off asis=on]
            style(report) = [protectspecialchars=off asis=on outputwidth=100%];

    column GRPXPAG GRPX1 GRPX2 ITEM1
            ("Treatment A~(N=&N1.) ~&line1." COL1 COL2)
            ("Treatment B~(N=&N2.) ~&line2." COL3 COL4)
            ("Treatment C~(N=&N3.) ~&line3." COL5 COL6)
            ("Treatment D~(N=&N4.) ~&line4." COL7 COL8)
            ("Treatment E~(N=&N5.) ~&line5." COL9 COL10);
    define GRPXPAG / order noprint;
    define GRPX1 / order noprint;
    define GRPX2 / order noprint;
    define ITEM1 / order flow style(column)=[cellwidth=11%] style(header)=[just=l];
    define COL1 / display flow style(column)=[cellwidth=8.75%];
    define COL2 / display flow style(column)=[cellwidth=8.75%];
    define COL3 / display flow style(column)=[cellwidth=8.75%];
    define COL4 / display flow style(column)=[cellwidth=8.75%];
    define COL5 / display flow style(column)=[cellwidth=8.75%];
    define COL6 / display flow style(column)=[cellwidth=8.75%];
    define COL7 / display flow style(column)=[cellwidth=8.75%];
    define COL8 / display flow style(column)=[cellwidth=8.75%];
    define COL9 / display flow style(column)=[cellwidth=9%];
    define COL10 / display flow style(column)=[cellwidth=9%];

    break after GRPXPAG / page;
    compute before GRPX1;
        line @1 " ";
    endcomp;
run;
ods rtf close;
ods listing;

%LET GMPXLERR=0;
%pageno(file="&_otables.&TFLNAME..rtf");
/* end -----------------------------------------------------------------------*/

/* proc compare data=tables.&TFLNAME. compare=qtab.&TFLNAME. out=comparedata outbase outcomp outdiff;
    var COL: ITEM:;
run; */