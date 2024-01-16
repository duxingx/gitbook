**** input treatment code data as adam adsl data.;
data adsl;
	length usubjid $ 3;
	label usubjid = "Unique Subject Identifier"
		trtpn   = "Planned Treatment (N)";
	input usubjid $ trtpn @@;
	datalines;
101 1  102 0  103 0  104 1  105 0  106 0  107 1  108 1  109 1  110 1
;
run;

**** input sample laboratory data as sdtm lb data;
data lb;
	label usubjid     = "Unique Subject Identifier"
		visitnum    = "Visit Number"
		lbcat       = "Category for Lab Test"
		lbtest      = "Laboratory Test"
		lbstresu    = "Standard Units"
		lbstresn    = "Numeric Result/Finding in Standard Units"
		lbstnrlo    = "Reference Range Lower Limit-Std Units"
		lbstnrhi    = "Reference Range Upper Limit-Std Units"
		lbnrind     = "Reference Range Indicator";
	input usubjid $ 1-3 visitnum 6 lbcat $ 9-18 lbtest $ 20-29
		lbstresu $ 32-35 lbstresn 38-41 lbstnrlo 45-48
		lbstnrhi 52-55 lbnrind $ 59;
	datalines;
101  0  HEMATOLOGY HEMATOCRIT  %     31     35     49     L
101  1  HEMATOLOGY HEMATOCRIT  %     39     35     49     N
101  2  HEMATOLOGY HEMATOCRIT  %     44     35     49     N
101  0  HEMATOLOGY HEMOGLOBIN  g/dL  11.5   11.7   15.9   L
101  1  HEMATOLOGY HEMOGLOBIN  g/dL  13.2   11.7   15.9   N
101  2  HEMATOLOGY HEMOGLOBIN  g/dL  14.3   11.7   15.9   N
102  0  HEMATOLOGY HEMATOCRIT  %     39     39     52     N
102  1  HEMATOLOGY HEMATOCRIT  %     39     39     52     N
102  2  HEMATOLOGY HEMATOCRIT  %     44     39     52     N
102  0  HEMATOLOGY HEMOGLOBIN  g/dL  11.5   12.7   17.2   L
102  1  HEMATOLOGY HEMOGLOBIN  g/dL  13.2   12.7   17.2   N
102  2  HEMATOLOGY HEMOGLOBIN  g/dL  18.3   12.7   17.2   H
103  0  HEMATOLOGY HEMATOCRIT  %     50     35     49     H
103  1  HEMATOLOGY HEMATOCRIT  %     39     35     49     N
103  2  HEMATOLOGY HEMATOCRIT  %     55     35     49     H
103  0  HEMATOLOGY HEMOGLOBIN  g/dL  12.5   11.7   15.9   N
103  1  HEMATOLOGY HEMOGLOBIN  g/dL  12.2   11.7   15.9   N
103  2  HEMATOLOGY HEMOGLOBIN  g/dL  14.3   11.7   15.9   N
104  0  HEMATOLOGY HEMATOCRIT  %     55     39     52     H
104  1  HEMATOLOGY HEMATOCRIT  %     45     39     52     N
104  2  HEMATOLOGY HEMATOCRIT  %     44     39     52     N
104  0  HEMATOLOGY HEMOGLOBIN  g/dL  13.0   12.7   17.2   N
104  1  HEMATOLOGY HEMOGLOBIN  g/dL  13.3   12.7   17.2   N
104  2  HEMATOLOGY HEMOGLOBIN  g/dL  12.8   12.7   17.2   N
105  0  HEMATOLOGY HEMATOCRIT  %     36     35     49     N
105  1  HEMATOLOGY HEMATOCRIT  %     39     35     49     N
105  2  HEMATOLOGY HEMATOCRIT  %     39     35     49     N
105  0  HEMATOLOGY HEMOGLOBIN  g/dL  13.1   11.7   15.9   N
105  1  HEMATOLOGY HEMOGLOBIN  g/dL  14.0   11.7   15.9   N
105  2  HEMATOLOGY HEMOGLOBIN  g/dL  14.0   11.7   15.9   N
106  0  HEMATOLOGY HEMATOCRIT  %     53     39     52     H
106  1  HEMATOLOGY HEMATOCRIT  %     50     39     52     N
106  2  HEMATOLOGY HEMATOCRIT  %     53     39     52     H
106  0  HEMATOLOGY HEMOGLOBIN  g/dL  17.0   12.7   17.2   N
106  1  HEMATOLOGY HEMOGLOBIN  g/dL  12.3   12.7   17.2   L
106  2  HEMATOLOGY HEMOGLOBIN  g/dL  12.9   12.7   17.2   N
107  0  HEMATOLOGY HEMATOCRIT  %     55     39     52     H
107  1  HEMATOLOGY HEMATOCRIT  %     56     39     52     H
107  2  HEMATOLOGY HEMATOCRIT  %     57     39     52     H
107  0  HEMATOLOGY HEMOGLOBIN  g/dL  18.0   12.7   17.2   N
107  1  HEMATOLOGY HEMOGLOBIN  g/dL  18.3   12.7   17.2   H
107  2  HEMATOLOGY HEMOGLOBIN  g/dL  19.2   12.7   17.2   H
108  0  HEMATOLOGY HEMATOCRIT  %     40     39     52     N
108  1  HEMATOLOGY HEMATOCRIT  %     53     39     52     H
108  2  HEMATOLOGY HEMATOCRIT  %     54     39     52     H
108  0  HEMATOLOGY HEMOGLOBIN  g/dL  15.0   12.7   17.2   N
108  1  HEMATOLOGY HEMOGLOBIN  g/dL  18.0   12.7   17.2   H
108  2  HEMATOLOGY HEMOGLOBIN  g/dL  19.1   12.7   17.2   H
109  0  HEMATOLOGY HEMATOCRIT  %     39     39     52     N
109  1  HEMATOLOGY HEMATOCRIT  %     53     39     52     H
109  2  HEMATOLOGY HEMATOCRIT  %     57     39     52     H
109  0  HEMATOLOGY HEMOGLOBIN  g/dL  13.0   12.7   17.2   N
109  1  HEMATOLOGY HEMOGLOBIN  g/dL  17.3   12.7   17.2   H
109  2  HEMATOLOGY HEMOGLOBIN  g/dL  17.3   12.7   17.2   H
110  0  HEMATOLOGY HEMATOCRIT  %     50     39     52     N
110  1  HEMATOLOGY HEMATOCRIT  %     51     39     52     N
110  2  HEMATOLOGY HEMATOCRIT  %     57     39     52     H
110  0  HEMATOLOGY HEMOGLOBIN  g/dL  13.0   12.7   17.2   N
110  1  HEMATOLOGY HEMOGLOBIN  g/dL  18.0   12.7   17.2   H
110  2  HEMATOLOGY HEMOGLOBIN  g/dL  19.0   12.7   17.2   H
;
run;

proc sort
	data = lb;
	by usubjid lbcat lbtest lbstresu visitnum;
run;

proc sort
	data = adsl;
	by usubjid;
run;

**** merge treatment information with lab data.;
data lb;
	merge adsl(in = inadsl) lb(in = inlb);
	by usubjid;

	if inlb and not inadsl then
		put "WARN" "ING: Missing treatment assignment for subject " usubjid=;

	if inadsl and inlb;
run;

**** carry forward baseline laboratory abnormal flag.;
data lb;
	set lb;
	by usubjid lbcat lbtest lbstresu visitnum;
	retain baseflag " ";

	**** initialize baseline flag to missing.;
	if first.lbtest then
		baseflag = " ";

	**** at visitnum 0 assign baseline flag.;
	if visitnum = 0 then
		baseflag = lbnrind;
run;

proc sort
	data = lb;
	by lbcat lbtest lbstresu visitnum trtpn;
run;

**** get counts and percentages for shift table.
**** we do not want counts for visitnum 0 so it is supressed.;
ods listing close;
ods output CrossTabFreqs = freqs;

proc freq
	data=lb(where = (visitnum ne 0));
	by lbcat lbtest lbstresu visitnum trtpn;
	tables baseflag*lbnrind;
run;

ods output close;
ods listing;

**** WRITE LAB SHIFT SUMMARY TO FILE USING DATA _NULL_;
options nodate nonumber;
title1 "Table 5.6";
title2 "Laboratory Shift Table";
title3 " ";

data _null_;
	set freqs end = eof;
	by lbcat lbtest lbstresu visitnum trtpn;

	**** SUPPRESS TOTALS.;
	where baseflag ne '' and lbnrind ne '';

	**** SET OUTPUT FILE OPTIONS.;
	file print titles linesleft = ll pagesize = 50 linesize = 80;

	**** WHEN NEWPAGE = 1, A PAGE BREAK IS INSERTED.;
	retain newpage 0;

	**** WRITE THE HEADER OF THE TABLE TO THE PAGE.;
	if _n_ = 1 or newpage = 1 then
		put @1 "-----------------------------------"
		"-----------------------------------" /
		@1 lbcat ":" @39 "Baseline Value" /
		@1 lbtest
		@17 "------------------------------------------------------" /
		@1 "(" lbstresu ")" @25 "Placebo" @55 "Active" /
		@17 "--------------------------  "
		"--------------------------" /
		@20 "Low     Normal    High      Low     Normal    High" /
		@1 "-----------------------------------"
		"-----------------------------------" /;

	**** RESET NEWPAGE TO ZERO.;
	newpage = 0;

	**** define array values which represents the 3 rows and
	**** 6 columns for any given visitnum.;
	array values {3,6} $10 _temporary_;

	**** initialize array to "0(  0%)".;
	if first.visitnum then
		do i = 1 to 3;
			do j = 1 to 6;
				values(i,j) = "0(  0%)";
			end;
		end;

	**** load frequency/precents from freqs data set to
	**** the proper place in the values array.;
	values( sum((lbnrind = "L") * 1,(lbnrind = "N") * 2,
		(lbnrind = "H") * 3) ,
		sum((baseflag = "L") * 1,(baseflag = "N") * 2,
		(baseflag = "H") * 3) + (trtpn * 3)) =
		put(frequency,2.) || "(" || put(percent,3.) || "%)";

	**** once all data has been loaded into the array for the visitnum,
	**** put the data on the page.;
	if last.visitnum then
		do;
			put @1 "Week " visitnum
				@10 "Low"    @18 values(1,1) @27 values(1,2)
				@36 values(1,3) @46 values(1,4)
				@55 values(1,5) @64 values(1,6) /
				@10 "Normal" @18 values(2,1) @27 values(2,2)
				@36 values(2,3) @46 values(2,4)
				@55 values(2,5) @64 values(2,6) /
				@10 "High"   @18 values(3,1) @27 values(3,2)
				@36 values(3,3) @46 values(3,4)
				@55 values(3,5) @64 values(3,6) /;

			**** if it is the end of the file, put a double line.;
			if eof then
				put @1 "-----------------------------------"
				"-----------------------------------" /
				"-----------------------------------"
				"-----------------------------------" //
				"Created by %sysfunc(getoption(sysin)) on &sysdate9..";

			**** if only the last visitnum in a test, then put page break.;
			else if last.lbtest then
				do;
					put @1 "-----------------------------------"
						"-----------------------------------" /
						@60 "(CONTINUED)" /
						"Created by %sysfunc(getoption(sysin)) on &sysdate9.."
						_page_;
					newpage = 1;
				end;
		end;
run;