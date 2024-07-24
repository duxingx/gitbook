/* change the working directory to the current file folder. */
%macro cd_currfile_path;
	%let currfile_path = %qsubstr(%sysget(SAS_EXECFILEPATH), 1, %length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILEname)) );
	x "cd &currfile_path.";
%mend cd_currfile_path;

%cd_currfile_path;


data trest;
	do x =1 to 100;
		y = "usubjid1" || cats(x);
		output;
	end;
run;


ods rtf file="./test_tfl.rtf" style=global.rtf;
proc report data=test;
	column x y;
run;
ods rtf close;
