* -------------------------------------------------------
* Setup

global projectFolder "~/Dropbox/Agri_Food_DHS"
global srcFolder "${projectFolder}/src"

do "${srcFolder}/analysis/0_setup.do"


* -------------------------------------------------------
* Export Results

* -------------------------------------------------------
* Export Table 2: HAZ and Stunted

estimates clear
eststo: qui: reg haz i.border3, cluster(motherid)
		estadd local controls "No"
		estadd local psufe "No"
		estadd local timefe "No"
		estadd local regionfe "No"
		estadd local cohortfe "No"
eststo: qui: reg haz i.border3 $controls, cluster(motherid)
		estadd local controls "Yes"
		estadd local psufe "No"
		estadd local timefe "No"
		estadd local regionfe "No"
		estadd local cohortfe "No"	
eststo: qui: reghdfe haz i.border3 $controls, cluster(motherid) absorb(psu)
		estadd local controls "Yes"
		estadd local psufe "Yes"
		estadd local timefe "No"
		estadd local regionfe "No"
		estadd local cohortfe "No"
eststo: qui: reghdfe haz i.border3 $controls, cluster(motherid) absorb(psu year_month)
		estadd local controls "Yes"
		estadd local psufe "Yes"
		estadd local timefe "Yes"
		estadd local regionfe "No"
		estadd local cohortfe "No"
eststo: qui: reghdfe haz i.border3 $controls, cluster(motherid) absorb(year_month psu birth_year) 
		estadd local controls "Yes"
		estadd local psufe "Yes"
		estadd local timefe "Yes"
		estadd local regionfe "No"
		estadd local cohortfe "Yes"
eststo: qui: reghdfe is_stunted i.border3 $controls, cluster(motherid) absorb(year_month psu birth_year) 
		estadd local controls "Yes"
		estadd local psufe "Yes"
		estadd local timefe "Yes"
		estadd local regionfe "No"
		estadd local cohortfe "Yes"
eststo: qui: reghdfe is_sev_stunted i.border3 $controls, cluster(motherid) absorb(year_month psu birth_year) 
		estadd local controls "Yes"
		estadd local psufe "Yes"
		estadd local timefe "Yes"
		estadd local regionfe "No"
		estadd local cohortfe "Yes"
esttab using "${projectFolder}/out/analysis/table2_main.rtf", replace /// 
		se star(* 0.10 ** 0.05 *** 0.01) varwidth(15) nobaselevels nocons keep(*.border3) /// 
		title("(Main) The Effects on Height-for-Age Z-score (HAZ)") ///
		varlabels(2.border3 "2nd Child" 3.border3 "3rd+ Child") ///
		s(N r2 controls psufe timefe cohortfe, label("N" "R-squared" "Controls" "PSU FE" "Survey-Year-Month FE" "Birth-Cohort FE")) /// 
		addnotes("Note: 2nd Child is an indicator for children whose birth order is 2; 3rd+ Child is an indicator for children whose birth order is 3 or higher")

		
