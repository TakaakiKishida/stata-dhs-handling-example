gl controls ///
	is_female i.age_month /// children 
	age_year_mother educ_years_mother age_year_mother2 is_mother_working ///
	age_year_father educ_years_father age_year_father2 /// parents
	is_poorer is_middle is_richer is_richest /// household 1
	is_fertility_completed is_HHhead_female is_rural use_open_pit_latrine drink_piped_water 
	/// preceding_birth_interval <-- had 36.8% missing obs

dis "$controls"

* ssc install ietoolkit, replace
ta border3 
gen border_1dummy = 1 if border3 == 1
replace border_1dummy = 0 if border3 == 0

iebaltab $controls, grpvar(border_1dummy) browse 
iebaltab st2 uw2 wa2 diar, grpvar(toiletgood) browse 
iebaltab st2 uw2 wa2 diar, grpvar(wash) browse


gl controls_summary ///
	is_female age_month /// children 
	age_year_mother educ_years_mother is_mother_working ///
	age_year_father educ_years_father /// parents
	is_poorer is_middle is_richer is_richest /// household 1
	is_fertility_completed is_HHhead_female is_rural use_open_pit_latrine drink_piped_water 
	/// preceding_birth_interval <-- had 36.8% missing obs

gl controls ///
	is_female i.age_month /// children 
	distance_minus2 distance_minus1 distance_plus1 distance_plus2 /// Desirebility
	age_year_mother educ_years_mother age_year_mother2 is_mother_working_imputed ///
	age_year_father educ_years_father age_year_father2 /// parents
	is_poorer is_middle is_richer is_richest /// household 1
	is_fertility_completed_imputed is_HHhead_female is_rural use_open_pit_latrine drink_piped_water 

	
gl outcomes_treatment ///
	haz is_stunted is_sev_stunted birth_order
	
gl controls_summary ///
	is_female age_month /// children 
	distance_minus2 distance_minus1 distance_0 distance_plus1 distance_plus2 /// Desirebility
	age_year_mother educ_years_mother is_mother_working_imputed ///
	age_year_father educ_years_father /// parents
	is_poorest is_poorer is_middle is_richer is_richest /// household 1
	is_fertility_completed_imputed is_HHhead_female is_rural use_open_pit_latrine drink_piped_water 	

	
estimates drop _all 
estpost sum $outcomes_treatment $controls_summary if end_year == 2007
est sto A
estpost sum $outcomes_treatment $controls_summary if end_year == 2011
est sto B
estpost sum $outcomes_treatment $controls_summary if end_year == 2014
est sto C
estpost sum $outcomes_treatment $controls_summary if end_year == 2018
est sto D
esttab A B C D using "${projectFolder}/out/analysis/summarystatsA.tex", /// 
	main(mean) aux(sd) ///
	title("") collabels("Mean/[S.D.]") mtitle("2007" "2011" "2014" "2017-18") nonum brackets replace 

	
	
esttab A B C D, /// 
	cells("mean(fmt(%11.2fc))") /// 
	title("") collabels("Mean") mtitle("2007" "2011" "2014" "2017-18") nonum replace 
	
esttab A B C D, /// 
	cells("sd(fmt(%11.2fc))") /// 
	title("") collabels("S.D.") mtitle("2007" "2011" "2014" "2017-18") nonum replace 

	
ta border3
gl bo ///
	bo1 bo2 bo3 bo4 bo5over

estimates drop _all 
estpost sum $bo if end_year == 2007
est sto A
estpost sum $bo if end_year == 2011
est sto B
estpost sum $bo if end_year == 2014
est sto C
estpost sum $bo if end_year == 2018
est sto D
esttab A B C D, /// 
	cells("mean(fmt(%11.2fc)) sd(fmt(%11.2fc))") /// 
	title("") collabels("Mean" "S.D.") mtitle("2007" "2011" "2014" "2017-18") nonum replace 

esttab A B C D, /// 
	cells("mean(fmt(%11.2fc))") /// 
	title("") collabels("Mean") mtitle("2007" "2011" "2014" "2017-18") nonum replace 
	
esttab A B C D, /// 
	cells("sd(fmt(%11.2fc))") /// 
	title("") collabels("S.D.") mtitle("2007" "2011" "2014" "2017-18") nonum replace 
	

// su $controls
//local vars fever-diarrhea loss_0year_ago-loss_2year_ago 
//local divide race     /* divide is the var that determines the subgroups */ 
estimates drop _all 
estpost sum $controls_summary if border3 == 1
est sto A
estpost sum $controls_summary if border3 == 2
est sto B
estpost sum $controls_summary if border3 == 3
est sto C
esttab A B C /// 
	using summarystats.tex, ///
	cells("mean(fmt(%11.2fc)) sd(fmt(%11.2fc)) min(fmt(%8.3g)) max(fmt(%12.0f))") /// 
	title("") collabels("Mean" "S.D." "Min" "Max") mtitle("2007" "2011" "2014" "2017-18") nonum replace 

