
%macro setup;
    %*----------------------------------------------------------------------------*;
    %*---  DEF_OS.  project - Project/study name. client  - Client name        ---*;
    %*---  tims    - Tims code.  For unblinded studies the %def_os code needs  ---*;
    %*---  to be copied (from /opt/pxlcommon/stats/macros/macro_library) here  ---*;
    %*---  AND updated TO reference the unblinded area                         ---*;
    %*----------------------------------------------------------------------------*;
    %def_os (project=lgchm269459, client=lgchm, tims=269459);

    %*----------------------------------------------------------------------------*;
    %*---  Ensure the project SAS version is SAS 9.4                           ---*;
    %*----------------------------------------------------------------------------*;
    %gmCheckSasVersion(checksasversion=9.4)

    %*----------------------------------------------------------------------------*;
    %*---  Check SVN status of programs run in batch mode and setup.sas        ---*;
    %*----------------------------------------------------------------------------*;
    * Check SVN status of the program which was run in batch mode;
    %gmSvnStatus()
    * Check SVN status of setup.sas;
    %gmSvnStatus(fileIn=$HeadURL: No remote:global/setup.sas $);


    %*----------------------------------------------------------------------------*;
    %*--- needed global variables for Clinbase trials                          ---*;
    %*----------------------------------------------------------------------------*;
    %global _studyno _studyname;
    %LET _studyno      = &_tims.; %* this is set above in call to def_os, e.g. 123456;
    %LET _studyname    = &_tims.; %* study number or number with extension e.g. 123456.BAL, &_tims..BAL;


    %*----------------------------------------------------------------------------*;
    %*--- Setup global variables                                               ---*;
    %*----------------------------------------------------------------------------*;
    %os_fvars(mvar=_global,  projpath=global);
    %os_fvars(mvar=_formats, projpath=formats);
    %os_fvars(mvar=_macros,  projpath=macros);

    %*----------------------------------------------------------------------------*;
    %*--- Setup global variables and libraries for transfer                    ---*;
    %*----------------------------------------------------------------------------*;
    %IF &_type. = tabulate %then %do;

        %os_fvars(mvar=_metadata,  projpath=&_type.:data:metadata)

        %os_fvars(mvar=_raw,       projpath=&_type.:data:raw)
        %os_fvars(mvar=_rawrand,   projpath=&_type.:data:rawrand)
        %os_fvars(mvar=_dumrand,   projpath=&_type.:data:rawrand:dummy)
        %os_fvars(mvar=_edt,       projpath=&_type.:data:edt)

        %*--- Create on folder per TPV/source ---*;
        %*os_fvars(mvar=_rawecg,   projpath=&_type.:data:rawecg);
        %*os_fvars(mvar=_rawlb,    projpath=&_type.:data:rawlb);

        %os_fvars(mvar=_transfer,  projpath=&_type.:data:transfer)
        %os_fvars(mvar=_qtrans,  projpath=&_type.:data:qtrans)
        %os_fvars(mvar=_txpt,  projpath=&_type.:data:transfer:xpt)
        %os_fvars(mvar=_ptransfer, projpath=&_type.:prog:transfer)
        %os_fvars(mvar=_qtransfer, projpath=&_type.:qcprog:transfer)

        %os_fvars(mvar=_scratch,   projpath=&_type.:data:scratch)
        %os_fvars(mvar=_qscratch,  projpath=&_type.:data:qscratch)

        %os_fvars(mvar=_pdefine,   projpath=&_type.:prog:define)
        %os_fvars(mvar=_odefine,   projpath=&_type.:outputs:define)

        %os_fvars(mvar=_doc,   projpath=&_type.:doc)

        %os_fvars(mvar=_rawmm,  projpath=&_type.:data:rawmm)
        %os_fvars(mvar=_mm,  projpath=&_type.:data:mm)
        %os_fvars(mvar=_qcmm,  projpath=&_type.:data:qcmm)
        %os_fvars(mvar=_pmm, projpath=&_type.:prog:mm)
        %os_fvars(mvar=_qmm, projpath=&_type.:qcprog:mm)
        %os_fvars(mvar=_omm,   projpath=&_type.:outputs:mm)

        %os_fvars(mvar=_rawdsur,  projpath=&_type.:data:rawdsur)
        %os_fvars(mvar=_dsur,  projpath=&_type.:data:dsur)
        %os_fvars(mvar=_qcdsur,  projpath=&_type.:data:qcdsur)
        %os_fvars(mvar=_pdsur, projpath=&_type.:prog:dsur)
        %os_fvars(mvar=_qdsur, projpath=&_type.:qcprog:dsur)
        %os_fvars(mvar=_odsur,   projpath=&_type.:outputs:dsur)
        %*--- For data folders created above ---*;

        LIBNAME metadata "&_metadata" COMPRESS=yes;
        LIBNAME raw      "&_raw"      COMPRESS=yes ACCESS=READONLY;
        LIBNAME rawrand  "&_rawrand"  COMPRESS=yes ACCESS=READONLY;
        LIBNAME dumrand  "&_dumrand"  COMPRESS=yes ACCESS=READONLY;
        LIBNAME edt      "&_edt"      COMPRESS=yes ACCESS=READONLY;
        %*--- For data folders created above ---*;
        %* LIBNAME rawecg  "&_rawecg"  COMPRESS=yes ACCESS=READONLY;
        %* LIBNAME rawlb  "&_rawlb"   COMPRESS=yes ACCESS=READONLY;
        LIBNAME transfer "&_transfer" COMPRESS=yes;
        LIBNAME qtrans "&_qtrans" COMPRESS=yes;
        LIBNAME txpt "&_txpt" COMPRESS=yes;
        LIBNAME scratch  "&_scratch"  COMPRESS=yes;
        LIBNAME qscratch "&_qscratch" COMPRESS=yes;

        LIBNAME rawmm "&_rawmm" COMPRESS=yes ACCESS=READONLY;
        LIBNAME mm "&_mm" COMPRESS=yes;
        LIBNAME qcmm "&_qcmm" COMPRESS=yes;

        LIBNAME rawdsur "&_rawdsur" COMPRESS=yes ACCESS=READONLY;
        LIBNAME dsur "&_dsur" COMPRESS=yes;
        LIBNAME qcdsur "&_qcdsur" COMPRESS=yes;


    %end;

    %*----------------------------------------------------------------------------*;
    %*--- Setup global variables and libraries for dmc/interim/primary         ---*;
    %*----------------------------------------------------------------------------*;
    %IF &_type. = dmc     or
          &_type. = interim or
          &_type. = primary %THEN %do;

        %os_fvars(mvar=_metadata,  projpath=&_type.:data:metadata)

        %os_fvars(mvar=_raw,       projpath=&_type.:data:raw)

        %os_fvars(mvar=_pdefine,   projpath=&_type.:prog:define)
        %os_fvars(mvar=_odefine,   projpath=&_type.:outputs:define)

        %os_fvars(mvar=_panalysis, projpath=&_type.:prog:analysis)
        %os_fvars(mvar=_qanalysis, projpath=&_type.:qcprog:analysis)
        %os_fvars(mvar=_analysis,  projpath=&_type.:data:analysis)
        %os_fvars(mvar=_qanal,     projpath=&_type.:data:qanal)
        %os_fvars(mvar=_axpt,     projpath=&_type.:data:analysis:xpt)

        %os_fvars(mvar=_ptables,   projpath=&_type.:prog:tables)
        %os_fvars(mvar=_qtables,   projpath=&_type.:qcprog:tables)
        %os_fvars(mvar=_tables,    projpath=&_type.:data:tables)
        %os_fvars(mvar=_qtab,    projpath=&_type.:data:qtab)
        %os_fvars(mvar=_otables,   projpath=&_type.:outputs:tables)

        %os_fvars(mvar=_plistings, projpath=&_type.:prog:listings)
        %os_fvars(mvar=_qlistings, projpath=&_type.:qcprog:listings)
        %os_fvars(mvar=_listings,  projpath=&_type.:data:listings)
        %os_fvars(mvar=_qlis,  projpath=&_type.:data:qlis)
        %os_fvars(mvar=_olistings, projpath=&_type.:outputs:listings)

        %os_fvars(mvar=_pfigures,  projpath=&_type.:prog:figures)
        %os_fvars(mvar=_qfigures,  projpath=&_type.:qcprog:figures)
        %os_fvars(mvar=_figures,   projpath=&_type.:data:figures)
        %os_fvars(mvar=_qfig,   projpath=&_type.:data:qfig)
        %os_fvars(mvar=_ofigures,  projpath=&_type.:outputs:figures)

        %os_fvars(mvar=_pappendix, projpath=&_type.:prog:appendix)
        %os_fvars(mvar=_qappendix, projpath=&_type.:qcprog:appendix)
        %os_fvars(mvar=_appendix,  projpath=&_type.:data:appendix)
        %os_fvars(mvar=_oappendix, projpath=&_type.:outputs:appendix)

        %os_fvars(mvar=_pprofiles, projpath=&_type.:prog:profiles)
        %os_fvars(mvar=_qprofiles, projpath=&_type.:qcprog:profiles)
        %os_fvars(mvar=_profiles,  projpath=&_type.:data:profiles)
        %os_fvars(mvar=_oprofiles, projpath=&_type.:outputs:profiles)

        %os_fvars(mvar=_qbiostats, projpath=&_type.:qcprog:biostats)
        %os_fvars(mvar=_qbio, projpath=&_type.:data:qbio)

        %os_fvars(mvar=_doc,   projpath=&_type.:doc)
        %os_fvars(mvar=_outputs,   projpath=&_type.:outputs)

        LIBNAME metadata    "&_metadata" COMPRESS=yes;
        LIBNAME raw         "&_raw"      COMPRESS=yes ACCESS=READONLY;
        LIBNAME analysis    "&_analysis" COMPRESS=yes;
        LIBNAME qanal       "&_qanal"    COMPRESS=yes;
        LIBNAME axpt       "&_axpt"    COMPRESS=yes;
        LIBNAME tables      "&_tables"   COMPRESS=yes;
        LIBNAME qtab      "&_qtab"   COMPRESS=yes;
        LIBNAME listings    "&_listings" COMPRESS=yes;
        LIBNAME qlis      "&_qlis"   COMPRESS=yes;
        LIBNAME figures     "&_figures"  COMPRESS=yes;
        LIBNAME qfig      "&_qfig"   COMPRESS=yes;
        LIBNAME appendix    "&_appendix" COMPRESS=yes;
        LIBNAME profiles    "&_profiles" COMPRESS=yes;
        LIBNAME qbio      "&_qbio"   COMPRESS=yes;

    %end;


    %*----------------------------------------------------------------------------*;
    %*--- Setup global variables and libraries for listings                    ---*;
    %*----------------------------------------------------------------------------*;
    %IF &_type. = listings %THEN %do;

        %os_fvars(mvar=_metadata,  projpath=&_type.:data:metadata)

        %os_fvars(mvar=_raw,      projpath=&_type.:data:raw)

        %os_fvars(mvar=_poffline, projpath=&_type.:prog:offline)
        %os_fvars(mvar=_qoffline, projpath=&_type.:qcprog:offline)
        %os_fvars(mvar=_offline , projpath=&_type.:data:offline)
        %os_fvars(mvar=_offcomm , projpath=&_type.:data:offcomm)
        %os_fvars(mvar=_ooffline, projpath=&_type.:outputs:offline)

        %os_fvars(mvar=_ppd,    projpath=&_type.:prog:pd)
        %os_fvars(mvar=_qpd,    projpath=&_type.:qcprog:pd)
        %os_fvars(mvar=_pd ,    projpath=&_type.:data:pd)
        %os_fvars(mvar=_pdcomm, projpath=&_type.:data:pdcomm)
        %os_fvars(mvar=_opd,    projpath=&_type.:outputs:pd)

        %os_fvars(mvar=_pmedical, projpath=&_type.:prog:medical)
        %os_fvars(mvar=_qmedical, projpath=&_type.:qcprog:medical)
        %os_fvars(mvar=_medical , projpath=&_type.:data:medical)
        %os_fvars(mvar=_medcomm , projpath=&_type.:data:medcomm)
        %os_fvars(mvar=_omedical, projpath=&_type.:outputs:medical)

    %os_fvars(mvar=_putr,  projpath=&_type.:prog:utr)
        %os_fvars(mvar=_utr ,  projpath=&_type.:data:utr)
        %os_fvars(mvar=_utrcomm, projpath=&_type.:data:utrcomm)
        %os_fvars(mvar=_outr, projpath=&_type.:outputs:utr)

    %os_fvars(mvar=_padhoc,  projpath=&_type.:prog:adhoc)
        %os_fvars(mvar=_adhoc ,  projpath=&_type.:data:adhoc)
        %os_fvars(mvar=_adhoccom,projpath=&_type.:data:adhoccom)
        %os_fvars(mvar=_oadhoc, projpath=&_type.:outputs:adhoc)



        LIBNAME metadata "&_metadata" COMPRESS=yes;
        LIBNAME raw      "&_raw"      COMPRESS=yes ACCESS=READONLY;
        LIBNAME offline  "&_offline"  COMPRESS=yes;
        LIBNAME pd       "&_pd"       COMPRESS=yes;
        LIBNAME medical  "&_medical"  COMPRESS=yes;
        LIBNAME utr      "&_utr"      COMPRESS=yes;
        LIBNAME adhoc    "&_adhoc"    COMPRESS=yes;
        LIBNAME offcomm  "&_offcomm"  COMPRESS=yes;
        LIBNAME pdcomm   "&_pdcomm"   COMPRESS=yes;
        LIBNAME medcomm  "&_medcomm"  COMPRESS=yes;
        LIBNAME utrcomm  "&_utrcomm"  COMPRESS=yes;
        LIBNAME adhoccom "&_adhoccom" COMPRESS=yes;

    %end;


    %*----------------------------------------------------------------------------*;
    %*--- Setup global variables and libraries for clinbase                    ---*;
    %*----------------------------------------------------------------------------*;
    %IF &_type. = clinbase %THEN %do;

        %os_fvars(mvar=_data,       projpath=&_type.:data)

        %os_fvars(mvar=_audit,       projpath=&_type.:data:audit)
        %os_fvars(mvar=_clinbasedvs, projpath=&_type.:data:clinbasedvs)
        %os_fvars(mvar=_metadata,    projpath=&_type.:data:metadata)
        %os_fvars(mvar=_raw,         projpath=&_type.:data:raw)
        %os_fvars(mvar=_rawcb,       projpath=&_type.:data:rawcb)

        %os_fvars(mvar=_query,       projpath=&_type.:outputs:query)
        %os_fvars(mvar=_listing,     projpath=&_type.:outputs:listing)

        %os_fvars(mvar=_prgcbdvs,    projpath=&_type.:prog:clinbasedvs)
        %os_fvars(mvar=_count,       projpath=&_type.:prog:count)
        %os_fvars(mvar=_import,      projpath=&_type.:prog:import)
        %os_fvars(mvar=_macro,       projpath=&_type.:prog:macro)

        LIBNAME metadata     "&_metadata"    COMPRESS=yes;
        LIBNAME build        "&_metadata"    COMPRESS=yes;
        LIBNAME raw          "&_raw"         COMPRESS=yes ACCESS=READONLY;
        LIBNAME s&_studyno.c "&_raw"         COMPRESS=yes ACCESS=READONLY;
        LIBNAME s&_studyno.d "&_clinbasedvs" COMPRESS=yes;

        /* create studymeta for clinbase */
        PROC SQL;
            CREATE TABLE metadata.studymeta  (LABEL="Global StudyMeta table %SYSFUNC(DATE(),ddmmyy10.)")
                ( sort       num       format=best8.
                                       informat=best8.
                                       label='sort' not null,
                  value      char(200) format=$200.
                                       informat=$200.
                                       label='Folder Variable Name' primary key,
                  label      char(200) format=$200.
                                       informat=$200.
                                       label='label' );

            INSERT INTO metadata.studymeta

                  VALUES(   0, "STUDYNO",                       "&_studyno.")
                  VALUES(   1, "STUDYNAME",                     "&_studyname.")
                  VALUES(   3, "SPONSOR",                       "&_client.")
                  VALUES(  10, "NVC_NONSAS_CLINBASE_FOLDER",    "&_rawcb.")
                  VALUES(  20, "NVC_SAS_CLINBASE_FOLDER",       "&_raw.")
                  VALUES(  30, "NVC_VIEWS_CLINBASEDVS_FOLDER",  "&_clinbasedvs.")
                  VALUES(  40, "NVC_SAS_CLINBASE_LINK",         "s&_studyno.c")
                  VALUES(  50, "NVC_VIEWS_CLINBASEDVS_LINK",    "s&_studyno.d")  /* << needed for mkcreatedvsquery */
                  VALUES(  55, "VC_LOG_LINK",                   "s&_studyno.g")
                  VALUES(  60, "VC_SCRIPT_MACRO_FOLDER",        "&_macro.")
                  VALUES(  70, "NVC_QUERY_FOLDER",              "&_query.")
                  VALUES(  80, "REF_DATA_FOLDER",               "&_data.")
                  VALUES(  90, "VC_LOG_FOLDER",                 "&_audit.")
                  VALUES( 100, "NVC_VIEWS_AUDIT_FOLDER",        "&_audit.")

            ;

        QUIT;


    %end;


    %*----------------------------------------------------------------------------*;
    %*--- CREATE METADATA GLOBAL DATASET                    ---*;
    %*----------------------------------------------------------------------------*;
    %INCLUDE "&_global./mdglobal.sas";

    %*----------------------------------------------------------------------------*;
    %*--- Set SAS options                    ---*;
    %*----------------------------------------------------------------------------*;
    %GLOBAL _ps _ls;
    %LET _ps=47;
    %LET _ls=133;
    OPTIONS ORIENTATION=LANDSCAPE PAPERSIZE=LETTER LS=&_ls. ps=&_ps.                      /* Pagesize                */
            NODATE NONUMBER NOBYLINE LABEL                                                /* Titles                  */
            CENTER FORMCHAR='*_---*+*---+=*-/\<>*' MISSING=""                             /* Layout                  */
            FMTSEARCH=(work analysis) MRECALL MAUTOSOURCE                                 /* Environmental settings  */
            SASAUTOS=("&_macros." %SYSFUNC(COMPRESS(%SYSFUNC(GETOPTION(sasautos)),() )))  /* Environmental settings  */
            MERGENOBY=ERROR YEARCUTOFF=1920 MSGLEVEL=I                                    /* Error Handling          */
            NOMPRINT NOSYMBOLGEN NOMLOGIC SOURCE2                                         /* Debug Information       */
            /* Suggested options which should be manually enabled by the primary if needed */
            /* NOQUOTELENMAX */ /* Disables WARNING if text in quotes is more than 262 characters long. Enable this option when using gmIntext macros */
            ;

    %IF &_type. = clinbase %THEN %do;
        OPTIONS MAUTOSOURCE MRECALL;
        OPTIONS NOMPRINT NOMLOGIC NOSYMBOLGEN NOSOURCE2 NOQUOTELENMAX;
        OPTIONS MERGENOBY= ERROR;
        OPTIONS NODATE NONUMBER NOCENTER;

        OPTIONS SASAUTOS=(
                    "&_macro."
                    "/opt/pxlcommon/gdo/macros/partnership_macros/ep"
                    %SYSFUNC(COMPRESS(%SYSFUNC(GETOPTION(sasautos)),() ))
                    );

    %end;
    %*----------------------------------------------------------------------------*;
    %*--- Set ODS options                                                      ---*;
    %*----------------------------------------------------------------------------*;

    /* If the primary decides to use a permanent store for ODS styles, the work.odscat(UPDATE) in the ODS PATH statement below
       should be updated to LIB.odscat(UPDATE), where LIB is the permanent library. For example figures.odscat(UPDATE).
       In this case simulteneous update of that store should be avoided.
    */
    ODS PATH work.odscat (UPDATE) sasuser.templat(READ) sashelp.tmplmst(READ);
    ODS ESCAPECHAR="~";


    %*----------------------------------------------------------------------------*;
    %*--- Lines for Layout                                                     ---*;
    %*----------------------------------------------------------------------------*;
    %GLOBAL _blank _line;
    DATA _NULL_;
      CALL SYMPUT("_blank", REPEAT(" ", %EVAL(&_ls.-1)));
      CALL SYMPUT("_line",  REPEAT("_", %EVAL(&_ls.-1)));
    RUN;


    %*----------------------------------------------------------------------------*;
    %*--- Place any other project-specific instructions here                   ---*;
    %*----------------------------------------------------------------------------*;
    %*INCLUDE "&_global./&_type./formats.sas";
    %INCLUDE "&_global./rtf.sas";
    %*INCLUDE "&_global./pdf.sas";
    %*OPTIONS SASAUTOS=("<path to partnershipmacros>" %SYSFUNC(COMPRESS(%SYSFUNC(GETOPTION(sasautos)),() )));


    %global _dtms _ads _rand _lab _pk _pd _dv
    study _unbyn _dmcseed
    _cutoff _delitype _dcutoff _delitype2 _dperid
    ;
    %let _dtms=269459 Data Transfer Mapping Specification v4.1 20231221.xlsx; /* 269459 Data Transfer Mapping Specification V3.1 20230809*/
    %let _ads=269459 Analysis Dataset Specifications v4.1 20231207.xlsx; /* 269459 Analysis Dataset Specifications v3.1 20230809*/

    %let _rand=%str(lg09_rand_blinded_20240115_dumtx);/* lg09_rand_blinded_20231017_dumtx */
    %let _lab=%str(lg_gdcl009_llslabb_16_20240115);/* lg_gdcl009_llslabb_12_20231023 */
    %let _pk=%str(LGC_LG-GDCL009_269459_ PPD PK test_06mar2023.xlsx);
    %let _pd=%str(LGC_LG-GDCL009_269459_ PPD PD test_06mar2023.xlsx);
    %let _dv=%str(Final DV Data Set.xlsx);

    %let study=LG-GDCL009;

    %let _unbyn=N;
    %if &_unbyn.=N %then %put WARNING:[PXL] Dummy treatment information is being used.;

    %let _dmcseed=20240115;/* 20231017 */
    %if &_type. = dmc %then %do;
        %let _cutoff=15JAN2024;
/*        %let _delitype=DSMB DryRun;*/
        %if &_unbyn.=N %then %let _delitype=DSMB Blind;
        %if &_unbyn.=Y %then %let _delitype=DSMB Unblinded;
    %end;

    %if &_type. = primary %then %do;
        %let _cutoff=;
        %let _delitype=;
    %end;

    %if &_type. = tabulate %then %do;
        %let _cutoff=08Jan2024;
        %let _delitype=Medical Data Review;

/* for DSUR delivery */
        %let _dcutoff=%str(08May2023);
        %let _delitype2=%str(Blinded Draft);
        %let _dperid=%str(09 May 2022 to 08 May 2023);
    %end;


    %INCLUDE "&_macros./rg_adam.sas";

%MEND setup;

%setup;
