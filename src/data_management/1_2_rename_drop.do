/*

	Rename Variables to be Used in our Analysis
	Drop Unnecessary Variables
	
	(1-1) Survey & Household General Information
	
	(1-2) Children's Intake (Food, Liquid, etc)
	
	(1-3) Other Parents and Household Information 
	
	(2-1) Children's Birth, Nutrition, Disease, etc
	
	(3-1) xxx
	
	(ZZZ) Modify Variables with Incorrect/Inconsistent Encoding

*/


* -------------------------------------------------------
* (1-1) Survey & Household General Information ----------

drop country_code
egen country_code = group(country)
egen region_2 = group(region_name_2)
egen region_3 = group(region_name_3)

rename v000 DHScountryphase
rename v001 DHScluster
rename v002 HHnumber
rename v003 line_number
rename v004 area_unit
rename v005 sample_weight
rename v006 DHSmonth
rename v007 DHSyear
rename v008 DHSdate
rename v009 birthmonth_resp
rename v010 birthyear_resp
rename v011 birthdatecmc_resp
rename v012 age_year_mother
rename v013 age_group_resp
rename v014 information_completed
rename v015 interview_completed
rename v016 DHSday
rename v017 calendar
rename v020 ever_married
rename v021 sampling_unit
rename v022 stratum_number
rename v023 domain
rename v024 region
rename v025 rural
rename v026 residence_place
rename v033 area_selection_prob
rename v034 husband_linenumber


* -------------------------------------------------------
* rename v101 region
* rename v025 rural
rename v102 residence_place_childhood
rename v104 years_lived
rename v105 residence_previous_place
rename v106 educ_respondent_level // respondent's highest year of education: https://www.dhsprogram.com/data/Using-Datasets-for-Analysis.cfm
rename v107 educ_year  // whose? --
rename hv201 water_drink
rename v115 water_time_NA
rename hv205 toilet
rename v119 electricity
rename v120 radio
rename v121 tv
rename v122 refrigerator_NA
rename v123 bike
rename v124 motorbike
rename v125 car_NA
rename v127 floor
rename v128 wall
rename v129 roof
rename v130 religion
rename v131 ethnicity_NA
rename v133 educ_years_mother // EDYRTOTAL (V133) reports the woman's education level in single years. 
                                  // This variable is constructed from responses to EDUCLVL (V106) and YRSCHL (V107) as follows:
rename v135 resident_type


* -------------------------------------------------------
rename v149 educ_attain // whose?
rename v150 relation_HHhead
rename v151 sex_HHhead
rename v152 age_HHhead
rename v153 telephone


* -------------------------------------------------------
rename v201 N_children_born
rename v202 son_home
rename v203 daughter_home
rename v204 son_elsewhere
rename v205 daughter_elsewhere
rename v206 son_died
rename v207 daughter_died
rename v208 birth_last5yrs
rename v209 birth_pastyr
rename v210 birth_interviewed
rename v211 date_firstbirth
rename v212 age_firstbirth
rename v213 pregnant
rename v214 pregnancy_duration
rename v215 menstr_lasttime
rename v216 menstr_6w
rename v217 know_ovulatory
rename v218 N_children_living
rename v219 children_preg
rename v220 children_preg6
* rename v221 ... v227
rename v228 ever_terminated_preg
* rename v229 ... v401


* -------------------------------------------------------
* (1-2) Children's Intake (Food, Liquid, etc) -----------
rename v404 breastfeeding
rename v405 amenorrheic
rename v406 abstaining
rename v407 time_breastfed_night
rename v408 time_breastfed_day
rename v409 water_plain
rename v409a water_suger
rename v411 milna
rename v411a baby_formula
rename v412 milk
rename v413 other_liquid
rename v414a banana_papaya_mango
rename v414b dal
rename v414c vegetable
rename v414d solid_food
rename v414e grain_food
rename v414f tuber_NA
rename v414g egg_fish_poultry
rename v414h meatna


* -------------------------------------------------------
* (1-3) Other Parents and Household Information ---------
rename v437 weight_resp
rename v438 height_resp
rename v445 bmi_resp
rename v501 currently_married
rename v502 marital_history
rename v504 husband_living
rename v507 marriage_month
rename v508 marriage_year
rename v509 marriage_date
rename v511 marriage_age
rename v512 marriage_years
rename v513 marriage_years_group
rename v602 fertility
rename v605 more_N_children
// rename v614 ideal_N_children
rename v621 husband_more_children
rename v701 educ_partner      // husband? --> probably yes
rename v704 job_partner       // husband?
rename v705 job_group_partner // husband?
rename v714 is_mother_working
rename v715 educ_years_father
rename v716 job_resp
rename v717 job_group_resp
rename v729 educ_attain_partner // husband?
rename v730 age_year_father


* -------------------------------------------------------
* (2-1) Children's Birth, Nutrition, Disease, etc -------
rename bord birth_order
rename b0 twin
rename b1 birth_month
rename b2 birth_year
rename b3 birth_date
rename b4 sex
rename b5 alive
rename b6 death_age
rename b8 age_year
rename m4 breastfeeding_duration
// rename m5 breastfeeding_month
rename m15 delivery_place
rename m18 birth_size
* rename h11 had_diarrhea
* rename h22 had_fever 
* rename h31 had_cough
rename hw1 age_month
* rename hw2 weight
* rename hw3 height
rename hv009 N_HH_member
rename hv010 N_eligible_women
rename hv011 N_eligible_men
rename hv014 N_children_u5


* -------------------------------------------------------
rename hv226 fuel
rename hv270 wealth
rename hv271 wealth_factor

* rename hc30 birth_month // b1 different?
* rename hc31 birth_year  // b2 different?
rename hc57 anemia
* rename hc61 educ_level_mother
* rename hc62 educ_years_mother

rename hv241 cooking_place
rename hv243a mobile_telephone
rename hv244 own_agriland
rename hv245 own_agriland_ha
rename hv246 farm
rename hv246b cow_bull
rename hv246g goat_sheep
rename hv246h chicken_duck

rename sh104a share_water
rename sh104b share_water_N
rename sh110h tables
rename sh110i chair
rename sh110j fan
* rename sh110k player
* rename sh110l water_pump
* rename sh118b rickshaw
* rename sh122a homestead
* rename sh122c land_amount 


* -------------------------------------------------------
* (3-1)







* -------------------------------------------------------
* 
drop v028-v032 v134 v136 v138 v139-v141 awfactt-awfacte v410 v410a
drop v413a-v413d v505 v506 v719 v721 v731
drop hv106-idxh4
drop dhsid-surveyid itn_coverage_2005-itn_coverage_2015 malaria_incidence_2000-malaria_prevalence_2015
drop v019a-hv225 hv227-hv234 hml1-hml2 /*shslum*/ hv120-ha58

drop hc2 hc3
drop hc63-m65x
drop h13b-h46b
drop ha60-ha69
* drop v3a08aa-s714bc
* drop awfacte3-hv253z
* drop sh13 ha70

** Geo covariate
drop urban_rura // alt_gps


* -------------------------------------------------------
* (ZZZ) Modify Variables with Incorrect/Inconsistent Encoding 

replace birth_year = 2000 if birth_year == 0
replace birth_year = 1994 if birth_year == 94
replace birth_year = 1995 if birth_year == 95
replace birth_year = 1996 if birth_year == 96
replace birth_year = 1997 if birth_year == 97
replace birth_year = 1998 if birth_year == 98
replace birth_year = 1999 if birth_year == 99


* -------------------
/*
list v024 v101 if v024 != v101 // region (same)
list v107 hc62 if v107 != hc62 // educ (different)
list v107 v133 if v107 != v133 // educ (different)
list hc62 v133 if hc62 != v133 // educ (different)
list v026 v134 if v026 != v134 // place residence (same)
list v137 v218 if v137 != v218 // N of children
list v136 hv009 if v136 != hv009 // N of HH member (same)
list v138 hv010 if v138 != hv010 // N of eligible womem (same)
list hv014 v137 if hv014 != v137 // N of children under 5 (same)
list b1 hc30 if b1 != hc30 // month age (different)
*/





** There are 80 children recorded age > 5 in the HH record
* drop if hv105 >= 5 
