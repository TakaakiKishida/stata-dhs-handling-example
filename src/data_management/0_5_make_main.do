/*

	Append Data for Bangladesh, Nepal, and Cambodia
	
	Data to be used: - `out/data/analysis/bangladesh.dta`
					 - `out/data/analysis/`
					 - `out/data/analysis/cambodia.dta`
	
	Output: `out/data/analysis/main_dataset.dta`

*/


* Setup -------------------------------------------------

clear all
macro drop _all
set more off

** Fixed throughout the do-file
global projectFolder "~/Dropbox/Agri_Food_DHS"
global dataFolder "${projectFolder}/out/data/analysis"




* -------------------------------------------------------
* Append Data for Three Countries -----------------------

* local target_filelist: bangladesh.dta nepal.dta cambodia.dta
* local target_filelist: bangladesh.dta cambodia.dta
/*
foreach DHScountry in "`bangladesh.dta'" "`nepal.dta'" {
	append using "`DHScountry'"
}
*/

use "${dataFolder}/cambodia.dta", clear
d, varl
local name_cambodia = "`r(varlist)'"

use "${dataFolder}/bangladesh.dta", clear
d, varl
local name_bangladesh = "`r(varlist)'"

** Make a list of common variables
local common_var_uniq : list name_bangladesh & name_cambodia
dis "`common_var_uniq'"

** Append dataset 
append using "${dataFolder}/cambodia.dta"

** Keep the common variables across 2004-2014 (approx. 3,040 --> 2,700)
keep `common_var_uniq'




* -------------------------------------------------------
* Save --------------------------------------------------

save "${projectFolder}/out/data/analysis/main_dataset_raw.dta", replace
