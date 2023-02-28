ta job_group_partner
ta job_group_partner, m nolab 

* agri-related: 4, 5

gen age_year_mother2 = age_year_mother^2
gen age_year_father2 = age_year_father^2

ta educ_years_mother
ta educ_years_mother, nolab
replace educ_years_mother = . if educ_years_mother == 99

ta educ_years_father
ta educ_years_father, nolab
replace educ_years_father = . if educ_years_father == 98 | educ_years_father == 99

replace is_mother_working = . if is_mother_working == 9


gen is_rural = 1 if rural == 2
replace is_rural = 0 if rural == 1


gen is_poorest = 1 if wealth == 1 
replace is_poorest=0 if wealth != 1

gen is_poorer = 1 if wealth == 2
replace is_poorer = 0 if wealth != 2

gen is_middle = 1 if wealth == 3
replace is_middle = 0 if wealth != 3

gen is_richer = 1 if wealth == 4
replace is_richer = 0 if wealth !=4

gen is_richest = 1 if wealth == 5
replace is_richest = 0 if wealth != 5



gen is_HHhead_female = 1 if sex_HHhead == 2
replace is_HHhead_female = 2 if sex_HHhead == 1
replace is_HHhead_female = 0 if is_HHhead_female == 2


gen use_open_pit_latrine = 1 if toilet == 22 | toilet == 23
replace use_open_pit_latrine = 0 if toilet == 11 | toilet == 12 | toilet == 13 | toilet == 14 | toilet == 15 | ///
                                    toilet == 21 | toilet == 31 | toilet == 41 | toilet == 42 | toilet == 43
replace use_open_pit_latrine = . if toilet == 97 
// gen toilet = 1 if toilet == 11 | toilet == 12					  // having a private toilet
// replace toilet=0 if hv205==13|hv205==21|hv205==31|hv205==32|hv205==33|hv205==34|hv205==35|hv205==36


gen drink_piped_water = 1 if water_drink == 11 | water_drink == 12
replace drink_piped_water = 0 if water_drink >= 13 & water_drink <= 96


gen father_agri = .
replace father_agri = 1 if job_group_partner == 4 | job_group_partner == 5
** note that this (below) is not correct approach
replace father_agri = 0 if father_agri == .

/*
ta N_children_living, m
gen N_children_living2 = 1 if N_children_living == 2
replace N_children_living2 = 0 if N_children_living != 2

gen N_children_living3 = 1 if N_children_living == 3
replace N_children_living3 = 0 if N_children_living != 3

gen N_children_living4 = 1 if N_children_living >= 4
replace N_children_living4 = 0 if N_children_living < 4

ta N_children_living2
ta N_children_living3
ta N_children_living4
*/

ta more_N_children
ta more_N_children, m nolab // "wants no more" == 5; sterilized == 6
gen is_fertility_completed = 1 if more_N_children == 5 | more_N_children == 6
replace is_fertility_completed = 0 if inlist(more_N_children, 1, 2, 3, 4, 7, 9) 
ta is_fertility_completed, m


// v614 ideal_N_children
gen ideal_N_children = v614
ta ideal_N_children
ta ideal_N_children, m nolab
replace ideal_N_children = . if inlist(ideal_N_children, 7, 8) 
gen is_birth_desired = 1 if birth_order <= ideal_N_children
replace is_birth_desired = 0 if birth_order > ideal_N_children
ta is_birth_desired
ta is_birth_desired, m nolab


* preceding birth interval (years): <2, 2, 3, 4, 5+
/* 
gen preceding_birth_interval = 1
replace preceding_birth_interval = 2 if b11 > 23
replace preceding_birth_interval = 3 if b11 > 35
replace preceding_birth_interval = 4 if b11 > 47
replace preceding_birth_interval = 5 if b11 > 59
replace preceding_birth_interval = . if b11 == .
* tab b11 prev_bint
*/


* Ideal Children
ta v613
ta v613, m nolab
gen ideal_ch = 0 if v613 == 0
replace ideal_ch = 1 if v613 == 0 | v613 == 1
replace ideal_ch = 2 if v613 == 2
replace ideal_ch = 3 if v613 == 3
replace ideal_ch = 4 if v613 == 4
replace ideal_ch = 5 if v613 >= 5
replace ideal_ch = . if v613 == 95 | v613 == 96

gen ideal_ch_2 = 1 if v613 == 0 | v613 == 1
replace ideal_ch_2 = 0 if v613 >= 2
replace ideal_ch_2 = . if v613 == 95 | v613 == 96

gen ideal_ch_3 = 1 if v613 == 0 | v613 == 1 | v613 == 2 
replace ideal_ch_3 = 0 if v613 >= 3
replace ideal_ch_3 = . if v613 == 95 | v613 == 96

gen ideal_boy = v627
replace ideal_boy = . if v627 == 95 | v627 == 96

gen ideal_girl = v628
replace ideal_girl = . if v628 == 95 | v628 == 96

gen son_pref = 1 if ideal_boy > ideal_girl
replace son_pref = 1 if ideal_boy > ideal_girl
replace son_pref = 0 if ideal_boy < ideal_girl
replace son_pref = 0.5 if ideal_boy == ideal_girl
su son_pref
ta son_pref

gen is_boy_preferred = 1 if son_pref == 1
replace is_boy_preferred = 0 if inlist(son_pref, 0, 0.5)
su is_boy_preferred
ta is_boy_preferred

ta N_children_born
gen N_children = N_children_born
replace N_children = 5 if N_children_born >= 5


gen bo1 = 1 if birth_order == 1
gen bo2 = 1 if birth_order == 2
gen bo3 = 1 if birth_order == 3
gen bo4 = 1 if birth_order == 4
gen bo5 = 1 if birth_order == 5
gen bo3over = 1 if birth_order >= 3
gen bo4over = 1 if birth_order >= 4
gen bo5over = 1 if birth_order >= 5
gen border3 = birth_order 
gen border5 = birth_order 

replace bo1 = 0 if birth_order != 1
replace bo2 = 0 if birth_order != 2
replace bo3 = 0 if birth_order != 3
replace bo4 = 0 if birth_order != 4
replace bo5 = 0 if birth_order != 5
replace bo3over = 0 if birth_order <= 2
replace bo4over = 0 if birth_order <= 3
replace bo5over = 0 if birth_order <= 4

replace border3 = 3 if birth_order >= 3
replace border5 = 5 if birth_order >= 5

ta bo1
ta bo2
ta bo3
ta bo4
ta bo5
ta bo3over
ta bo4over
ta bo5over


ta birth_order is_female, m
gen is_1st_child_male = 1 if (birth_order == 1) & (is_female == 0)
replace is_1st_child_male = 0 if (birth_order != 1) | (is_female != 0)
ta is_1st_child_male

gen is_1st_child_girl = 1 if (birth_order == 1) & (is_female == 1)
replace is_1st_child_girl = 0 if (birth_order != 1) | (is_female != 1)
ta is_1st_child_girl

ta wealth, m 
ta wealth, m nolab
gen is_poor = 1 if inlist(wealth, 1, 2)
replace is_poor = 0 if inlist(wealth, 3, 4, 5)
ta is_poor

gen is_rich = 1 if inlist(wealth, 4, 5)
replace is_rich = 0 if inlist(wealth, 1, 2, 3)


ta v613
ta v613, m nolab
gen ideal_N_children_raw = v613
replace ideal_N_children_raw = . if inlist(v613, 95, 96)
ta ideal_N_children_raw, m
gen distance_ideal_N_children = ideal_N_children_raw - birth_order
ta distance_ideal_N_children, m

gen distance_ideal_N_children2 = distance_ideal_N_children
ta distance_ideal_N_children2, m

replace distance_ideal_N_children2 = -2 if distance_ideal_N_children <= -2
replace distance_ideal_N_children2 = 2 if distance_ideal_N_children >= 2
replace distance_ideal_N_children2 = . if distance_ideal_N_children == .

gen distance_minus2 = 1 if distance_ideal_N_children2 == -2
replace distance_minus2 = 0 if inlist(distance_ideal_N_children2, -1, 0, 1, 2)
ta distance_minus2, m

gen distance_minus1 = 1 if distance_ideal_N_children2 == -1
replace distance_minus1 = 0 if inlist(distance_ideal_N_children2, -2, 0, 1, 2)
ta distance_minus1, m

gen distance_0 = 1 if distance_ideal_N_children2 == 0
replace distance_0 = 0 if inlist(distance_ideal_N_children2, -2, -1, 1, 2)
ta distance_0, m

gen distance_plus1 = 1 if distance_ideal_N_children2 == 1
replace distance_plus1 = 0 if inlist(distance_ideal_N_children2, -2, -1, 0, 2)
ta distance_plus1, m

gen distance_plus2 = 2 if distance_ideal_N_children2 == 2
replace distance_plus2 = 0 if inlist(distance_ideal_N_children2, -2, -1, 0, 1)
ta distance_plus2, m

gen is_still_wanted = 1 if distance_ideal_N_children >= 0
replace is_still_wanted = 0 if distance_ideal_N_children < 0
replace is_still_wanted = . if distance_ideal_N_children == .
ta is_still_wanted, m

gen ideal_group = 0 if distance_ideal_N_children == 0
replace ideal_group = 1 if distance_ideal_N_children >= 1
replace ideal_group = 2 if distance_ideal_N_children <= -1
replace ideal_group = . if distance_ideal_N_children == .
ta ideal_group, m



/*
* gen se = 1.96 * (sdz/sqrt(n))
gen haz95cihig = haz + 1.96 * (hazsd/sqrt(n_haz))
gen haz95cilow = haz - 1.96 * (hazsd/sqrt(n_haz))

gen whz95cihig = whz + 1.96 * (whzsd/sqrt(n_whz))
gen whz95cilow = whz - 1.96 * (whzsd/sqrt(n_whz))

gen waz95cihig = waz + 1.96 * (wazsd/sqrt(n_waz))
gen waz95cilow = waz - 1.96 * (wazsd/sqrt(n_waz))
*/

gen N_children_over3 = 1 if N_children_born >= 3
replace N_children_over3 = 0 if N_children_born <= 2

ta N_children_over3 ideal_ch_3
gen unplanned_3 = 1 if N_children_over3 == 1 & ideal_ch_3 == 0
replace unplanned_3 = 0 if N_children_over3 == 0 & ideal_ch_3 == 1
replace unplanned_3 = 0 if N_children_over3 == 0 & ideal_ch_3 == 0
replace unplanned_3 = 0 if N_children_over3 == 1 & ideal_ch_3 == 1
ta unplanned_3
