/*

	Make Child-related Variables

*/

* Check (same name vars are actually the same?) ---------
** hw[x] from KR (children), hc[x] from PR (Household)

** hc2 in 1999-00 is missing. 
** Missing codes in hw2 and hc2 are different, but they are identical other than this
** same for height (hw3 & hc3) --> drop hc2 & hc3
* drop if v007 == 1999 | v007 == 2000

/*
list hw2 hc2 if hw2 != hc2 // weight (essentially same)
list hw3 hc3 if hw3 != hc3 // height (essentially same)
list hw70 hc70 if hw70 != hc70 // stunting (essentially same)
list hw72 hc72 if hw72 != hc72 // wasting (essentially same)
list hw71 hc71 if hw71 != hc71 // underweight (essentially same)
*/

* gen wt = hv005/1000000


gen is_female = 1 if sex == 2
replace is_female = 0 if sex == 1


* Anthropometry Indicators | Weight and Height ----------

** (code) https://hdr.undp.org/sites/default/files/benin.do 
** (ref)  https://userforum.dhsprogram.com/index.php?t=msg&goto=6941&S=ea05a1dddc49c96937b9664105f2aead

*** Body Weight (kg) ----
ta hw2, m nolab
** Divide it by 10 to express it in kilograms
gen weight = .
replace	weight = hw2/10 
** --------------------------------------------------> Below Necessary?
** Replace abnormal values by .
* replace weight = . if hw2 >= 300 | hw2 == . 


*** Body Height (cm) ----
ta hw3, m nolab
** Divide it by 10 to express it in centimeter
gen height = .
replace	height = hw3/10 
** --------------------------------------------------> Below Necessary?
** Replace abnormal values by .
* replace height = . if hw3 >= 1400 | hw3 == .




* Disease -----------------------------------------------

ta h11
ta h11, m nolab
gen had_diarrhea = 0
replace had_diarrhea = 1 if h11 == 2
replace had_diarrhea = . if inlist(h11, 8, 9)
ta had_diarrhea

ta h22 
ta h22, m nolab
gen had_fever = 0
replace had_fever = 1 if h22 == 1
replace had_fever = . if inlist(h22, 8, 9)
ta had_fever

* rename h31 had_cough
ta h31
ta h31, m nolab
gen had_cough = 0
replace had_cough = 1 if h31 == 2
replace had_cough = . if inlist(h31, 8, 9)
ta had_cough



* Anthropometry Indicators | Nutrition ------------------

** Anemia is not applicable (more than 75% are missing)

** (code) https://github.com/DHSProgram/DHS-Indicators-Stata/blob/master/Chap11_NT/NT_CH_NUT.do
** (ref)  https://dhsprogram.com/data/Guide-to-DHS-Statistics/Nutritional_Status.htm


*** (a1) Severely Stunted -------------------------------
ta hw70, m nolab
gen is_sev_stunted = 0
replace is_sev_stunted = 1 if hw70 < -300
replace is_sev_stunted = . if hw70 >= 9996 | hw70 == .


*** (a2) Stunted ----
gen is_stunted = 0
replace is_stunted = 1 if hw70 < -200
replace is_stunted = . if hw70 >= 9996 | hw70 == . 


*** (a3) HAZ (z-score for height-for-age) ----
gen haz = hw70 / 100 if hw70 < 996
* summarize haz if hv103 == 1 [iw=wt]
* gen nt_ch_mean_haz = round(r(mean), 0.1)


*** (b1) Severely Wasted --------------------------------
ta hw72, m nolab
gen is_sev_wasted = 0
replace is_sev_wasted = 1 if hw72 < -300
replace is_sev_wasted = . if hw72 >= 9996 | hw72 == . 


*** (b2) Wasted ----
gen is_wasted = 0
replace is_wasted = 1 if hw72 < -200
replace is_wasted = . if hw72 >= 9996 | hw72 == . 


*** (b3) Overweight for height ----
gen is_overweight_height = 0
replace is_overweight_height = 1 if hw72 > 200
replace is_overweight_height = . if hw72 >= 9996 | hw72 == . 


*** (b4) WHZ (z-score for weight-for-height) ----
gen whz = hw72 / 100 if hw72 < 996
* summarize whz if hv103==1 [iw=wt]
* gen nt_ch_mean_whz = round(r(mean), 0.1)


*** (c1) Severely underweight ---------------------------
ta hw71, m nolab
gen is_sev_underweight = 0
replace is_sev_underweight = 1 if hw71 < -300
replace is_sev_underweight = . if hw71 >= 9996 | hw71 == . 


*** (c2) Underweight ----
gen is_underweight = 0
replace is_underweight = 1 if hw71 < -200
replace is_underweight = . if hw71 >= 9996 | hw71 == . 


*** (c3) Underweight for age ----
gen is_underweight_age = 0
replace is_underweight_age = 1 if hw71 > 200
replace is_underweight_age = . if hw71 >= 9996 | hw71 == . 


*** (c4) WAZ (z-score for weight-for-age) ----
//Mean waz
gen waz = hw71/100 if hw71 < 996
* summarize waz if hv103 == 1 [iw=wt]
* gen nt_ch_mean_waz=round(r(mean),0.1)


* https://microdata.worldbank.org/index.php/catalog/2929/variable/F17/V872?name=m5
gen breastfeeding_month = m5
replace breastfeeding_month = 0 if m5 == 94
replace breastfeeding_month = . if inlist(m5, 97, 98, 99)

ta breastfeeding_month
ta breastfeeding_month, m nolab



* (Label) Child variables ---------------------------------------

label var weight "weight in kilograms"
label var height "height in centimeters"
** (a)
label var is_sev_stunted "Severely stunted child under 5 years"
label var is_sev_stunted "Stunted child under 5 years"
label var haz "Height-for-Age Z-score for children under 5 years"
** (b)
label var is_sev_wasted "Severely wasted child under 5 years"
label var is_wasted "Wasted child under 5 years"
label var is_overweight_height "Overweight for height child under 5 years"
label var whz "Weight-for-Height Z-score for children under 5 years"
** (c)
label var is_sev_underweight	"Severely underweight child under 5 years"
label var is_underweight "Underweight child under 5 years"
label var is_underweight_age "Overweight for age child under 5 years"
label var waz "Weight-for-Age Z-score for children under 5 years"

