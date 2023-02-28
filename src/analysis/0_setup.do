
* -------------------------------------------------------
* Read data

global projectFolder "~/Dropbox/Agri_Food_DHS"
use "${projectFolder}/out/data/analysis/main_dataset.dta", clear

// ta end_year


* -------------------------------------------------------
* Set controls


* Currently using below
gl controls ///
	is_female i.age_month /// children 
	distance_minus2 distance_minus1 distance_plus1 distance_plus2 /// Desirebility
	age_year_mother educ_years_mother age_year_mother2 is_mother_working_imputed ///
	age_year_father educ_years_father age_year_father2 /// parents
	is_poorer is_middle is_richer is_richest /// household 1
	is_fertility_completed_imputed is_HHhead_female is_rural use_open_pit_latrine drink_piped_water 

dis "$controls"
	
/*
gl controls ///
	is_female i.age_month /// children 
	age_year_mother educ_years_mother age_year_mother2 is_mother_working_imputed ///
	age_year_father educ_years_father age_year_father2 /// parents
	is_poorer is_middle is_richer is_richest /// household 1
	is_fertility_completed is_HHhead_female is_rural use_open_pit_latrine drink_piped_water 
	/// preceding_birth_interval <-- had 36.8% missing obs
	
gl distance2 ///
	distance_minus2 distance_minus1 distance_plus1 distance_plus2
dis "$distance2"
*/

* check missings
mdesc ///
	is_female age_month /// children 
	distance_minus2 distance_minus1 distance_plus1 distance_plus2 /// Desirebility
	age_year_mother educ_years_mother age_year_mother2 is_mother_working_imputed ///
	age_year_father educ_years_father age_year_father2 /// parents
	is_poorer is_middle is_richer is_richest /// household 1
	is_fertility_completed_imputed is_HHhead_female is_rural use_open_pit_latrine drink_piped_water 
