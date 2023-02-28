/*

	Execute All Do-Files Making/Labeling the Variables

*/


clear all
macro drop _all
set more off


* Running Do-Files --------------------------------------

** Fixed throughout the do-file
global projectFolder "~/Dropbox/Agri_Food_DHS"
global srcFolder "${projectFolder}/src"

use "${projectFolder}/out/data/analysis/bangladesh.dta", clear

* Unique PSU
egen psu = group(v000 v021)
label var psu "Unique PSU"

egen motherid = group(v000 v007 caseid)

do "${srcFolder}/data_management/1_2_rename_drop.do"

do "${srcFolder}/data_management/1_3_make_child_u5_vars.do"

do "${srcFolder}/data_management/1_4_make_parent_hh_vars.do"

do "${srcFolder}/data_management/1_8_region_character.do"

do "${srcFolder}/1_5_make_rain_vars.do"



* -------------------------------------------------------
* Save --------------------------------------------------

save "${projectFolder}/out/data/analysis/main_dataset.dta", replace

