/*
	
	Merge the individual AReNA DHS files
	Saved as a single .dta file in `out/data/AReNA_DHS`
	
	Data to be used: `data-raw/AReNA_DHS/dta`	
	Output: `out/data/AReNA_DHS/AReNA_DHS_merged.dta`

*/


* Setup -------------------------------------------------

** Install command if not yet
* ssc install filelist

clear all
macro drop _all
set more off


** Directory
global projectFolder "~/Dropbox/Agri_Food_DHS"
global AReNAFolder "${projectFolder}/data-raw/AReNA_DHS/dta"



* Merge -------------------------------------------------
** Combine all AReNA DHS files into one .dta file 

use "${AReNAFolder}/001_DHS_distance.dta", clear 
keep if inlist(country, "Bangladesh", "Cambodia", "Nepal")

local filelist: dir "${AReNAFolder}" files "*.dta"
local _remove 001_DHS_distance.dta
local filelist_d: list filelist - _remove

local sorted_filelist: list sort filelist_d

foreach file of local sorted_filelist {
	dis in red "Merge `file' with main data"
	merge 1:m country_code dhsyear v001 using "${AReNAFolder}/`file'"
	keep if _merge == 3
	drop _merge
	quietly describe
	local N_vars = `r(k)'
	dis "The Number of Variables: `N_vars'"
}



* Save --------------------------------------------------

save "${projectFolder}/out/data/AReNA_DHS/AReNA_DHS_merged.dta", replace

