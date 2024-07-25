/*-----------------------------------------------------------------------------
  PAREXEL INTERNATIONAL LTD

  Sponsor/Protocol No:   LG Chem Ltd / lgchm
  PAREXEL Study Code:    269459

  SAS Version:           9.4
  Operating System:      UNIX
-------------------------------------------------------------------------------

  Owner:                 $LastChangedBy: Bonnie Wang (pic0bxw5)$
  Last Modified:         $LastChangedDate: 2024-01-05 02:09:46$

  Program Location/Name: $HeadURL: No remote:dmc/prog/figures/f-adsua-mean.sas$
  SVN Revision No:       $Rev: 785 $

  Files Created:         Figure1

  Program Purpose:       Figure 1 Mean of Serum Uric Acid (sUA) Level (mg/dL) by Visit and Treatment Group
-----------------------------------------------------------------------------*/

/* Clear the environment -----------------------------------------------------*/
proc datasets library=work kill nowarn nolist memtype=data; quit;
options validvarname=v7;
dm log 'CLEAR';
dm out 'CLEAR';

/* macro variables, system options -------------------------------------------*/
%LET GMPXLERR = 0;
%LET PGMNAME = f-adsua-mean;
%LET TFLNAME = f_adsua_mean;

proc format;
  invalue amonth
    '4'=0
    '5'=0.5
    '6'=1
    '7'=2
    '8'=3
    '9'=4
    '10'=5
    '11'=6
  ;

  value Mon
    0="Basline(V4)"
    0.5="Month 0.5(V5)"
    1="Month 1(V6)"
    2="Month 2(V7)"
    3="Month 3(V8)"
    4="Month 4(V9)"
    5="Month 5(V10)"
    6="Month 6(V11)"

;
run;

data sua;
  set analysis.adsua (where=(SAFFL="Y" and ANL11FL="Y" and PARAMCD="URIC" ));
  GRPX1=DMTR01AN;
  if ablfl="Y" then DMVISITN=4;
/* keep USUBJID PARAMCD aval DMVISITN DMVISIT DMTR01AN  DMTR01A GRPX1 ; */
run;

proc summary data=sua nway;
    var aval;
    class DMTR01AN DMTR01A DMVISITN;
    output out=desc MEAN=AMEAN STD=ASTD;
run;

data final;
  set desc;
  attrib  _ALL_ label="";
   drop _TYPE_ _FREQ_;
  x=input(strip(put(DMVISITN,best.)),amonth.);
  if 4<=DMVISITN<=11;
  grpxvisit=DMVISITN;
 keep DMTR01AN DMTR01A X AMEAN GRPX:;
run;

%gmTrimVarLen(dataIn=final);

data figures.&TFLNAME.;
  set final;
run;


proc template;
  define statgraph myplot /* /store = WORK.TEMPLAT */;
  begingraph / designheight=5in designwidth=7in backgroundcolor=white border=false;
*****color*********;
   discreteattrmap name="symbols" / ignorecase=true trimleading=true;
   value "Treatment A" /LINEATTRS=(color=grey PATTERN=1)  MARKERATTRS=(color=grey symbol=circle);
   value "Treatment B" /LINEATTRS=(color=green PATTERN=1)  MARKERATTRS=(color=green symbol=square);
   value "Treatment C"  /LINEATTRS=(color=blue PATTERN=1)  MARKERATTRS=(color=blue symbol=triangle);
   value "Treatment D"  /LINEATTRS=(color=orange PATTERN=1)  MARKERATTRS=(color=orange symbol=x);

   enddiscreteattrmap;
   discreteattrvar attrvar=groupmarkers var=DMTR01A attrmap="symbols";
  *****color end *********;

        layout overlay / border=false walldisplay=none
        xaxisopts=(offsetmin=0.02 offsetmax=0.02
                    label ="Time (Month)"
                    labelattrs    =(family="Courier New" size=9.5pt weight=Normal style=italic )
                    display       =(ticks line tickvalues label)
                    linearopts    =(tickvaluelist=(0 0.5 1 2 3 4 5 6 )  tickvalueformat=Mon. TICKVALUEFITPOLICY=rotate viewmax=7)
        )
     yaxisopts=(label         ="sUA Level (mg/dL)"
                       labelattrs    =(family="Courier New" size=9.5pt weight=Normal)
                       display       =(ticks line tickvalues label)
                       linearopts    =(tickvaluesequence=(start=0 end=10 increment=2) viewmin=0 viewmax=10)
                      );

     seriesplot  x=x y=AMEAN / group=groupmarkers  name='grouping'
                           DISPLAY=all
                           CLUSTERWIDTH =0.1
                           GROUPDISPLAY =CLUSTER
                           MARKERATTRS=(size=6pt weight=bold)
                           lineattrs=( thickness=1)
                         ;
    /* add reference line for sUA <6 per DSMB comments 20230612 */
    referenceline y=6 / lineattrs=(color=GRAY00  pattern = 2)
          curvelabelattrs=(size=12pt) curvelabellocation=inside curvelabelposition=max;
    discretelegend 'grouping' / location=outside halign=center valign=bottom  border=true borderattrs=(thickness=0.01)
                            VALUEATTRS=(family='Courier New' weight=bold);
        endlayout;
  endgraph;
  end;
run;

%loadtf(tabout=&TFLNAME., prg=&PGMNAME.);

ods listing close;
ods rtf file="&_ofigures.&TFLNAME..rtf" style=global.rtf nogtitle nogfootnote operator="~{\dntblnsbdb}";
ods escapechar="~";

ods graphics / reset noborder imagefmt=jpg width=7in height=4.5in antialiasmax=1500 noscale;

proc sgrender data=figures.&TFLNAME. template=myplot;
run;

ods rtf close;
ods listing;

%LET GMPXLERR=0;
%pageno(file="&_ofigures.&TFLNAME..rtf");