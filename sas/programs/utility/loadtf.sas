/*-----------------------------------------------------------------------------
  PAREXEL INTERNATIONAL LTD

  Sponsor/Protocol No:   LG Chem Ltd / lgchm
  PAREXEL Study Code:    269459

  SAS Version:           9.3 and above
  Operating System:      UNIX
-------------------------------------------------------------------------------

  Owner:                 $LastChangedBy: Bonnie Wang (pic0bxw5)$
  Last Modified:         $LastChangedDate: 2024-01-05 02:08:40$

  Program Location/Name: $HeadURL: No remote:macros/loadtf.sas$
  SVN Revision No:       $Rev: 725 $

  Files Created:         None

  Program Purpose:       Product title and footnote.
-----------------------------------------------------------------------------*/

%macro loadtf(tabout=,prg=);
options noquotelenmax;
%let _header_=%str(title1 j=l "LG Chem Ltd" j=r "&study. EURELIA 1"; title2 j=r "Page XXXX of YYYY";);
%let _footer_=%str(j=l "Database Extract Date: &_cutoff." j=r "&_delitype.");

%let _tabout=%sysfunc(upcase(&tabout));

%IF &_type. = tabulate %then %do;
%if %sysfunc(substr(&_tabout,1,1))=T %then %do;
    %let _path=&_pmm;
%end;
%end;

%else %do;

%if %sysfunc(substr(&_tabout,1,1))=T %then %do;
    %let _path=&_ptables;
%end;

%if %sysfunc(substr(&_tabout,1,1))=F %then %do;
    %let _path=&_pfigures;
%end;

%if %sysfunc(substr(&_tabout,1,1))=L %then %do;
    %let _path=&_plistings;
%end;

%end;

proc import datafile="&_doc.titlefootnote.xlsx" out=titf
    dbms=xlsx replace;
run;




data titf;
    length tab $200.;
    set titf;
/*    array dd _character_;*/
/*    do over dd;*/
/*        dd=compress(dd,,'kw');*/
/*    end;*/
    ord=_n_;
    retain tab;
    if tabout ne "" then tab=tabout;
run;

proc sort data=titf out=titf_ ;
    by tab type ord;
    where upcase(tab)=upcase("&tabout");
run;

data titf_;
    length foot content $20000.;
    set titf_;
    by tab type ord;
    retain foot;
    if type="T" then do;
        call symputx("tit1",catt("title3 j=c ",' "',tabno,'"'));
        call symputx("tit2",catt("title4 j=c ",' "',content,'"'));
        call symputx("tit3",catt("title5 j=c ",' "(',pop,')"'));
    end;
    else if type="F" then do;
        if first.type then grpx1=1;
        else grpx1+1;
        if grpx1=1 then do;
            content="~R/RTF'\ql\brdrt\brdrs\brdrwr "||strip(content);
            foot=catt("footnote j=l " ,' "',content,'"');
        end;
        else foot=catx(";",foot,catt("footnote",strip(put(grpx1,best.))," j=l "," '",content,"'"));
        if last.type then do;
            foot=catx(";",foot,catt("footnote",strip(put(grpx1+1,best.))),
                catt("footnote",strip(put(grpx1+2,best.))," j=l " ,' "&_path.&prg..sas/&sysdate9./&systime."'),
                catt("footnote",strip(put(grpx1+3,best.))," ",' &_footer_'));
            call symputx("_foot",foot);
        end;
    end;
run;

proc sql noprint;
    select count(*) into: fnum from titf_ where type="F";
quit;
%let fnum=&fnum;
%if &fnum=0 %then %do;
    %let _foot=%str(footnote1 j=l "~R/RTF'\ql\brdrt\brdrs\brdrwr &_path.&prg..sas/&sysdate9./&systime.";footnote2 j=l &_footer_);
%end;

&_header_;
&tit1;
&tit2;
&tit3;
&_foot;

%mend loadtf;
