/*
	
	Make repeated-cross-section dataset in Cambodia from DHS 2000 to DHS 2014
	Process: (1) & (2) for each year --> (3) Append all waves --> (4) --> (5)
	
	(1) For HH and individual data, merge Children's Recode (KR) with HH Members Record (PR)
	
	(2) For Geospatial variables provided by original DHS, include original CSV (GC) when merging data at each year
	
	(3) Append the all waves (years)
	
	(4) For administrative region names, include it after completing (1)-(3)
	
	(5) For Geospatial variables provided by AReNA's DHS, include it after completing (1)-(4)
		--> This is created by `src/data_management/extract_dhs_region_name.R` using data from GE files in original DHS
	
	Note: As `tempfile` is used to save intermediate data for merge works, running code by each line cause an error.
		  Instead, running codes by each (DHS) year (or entire do-file) can successfully execute and make expected results.
		  
	Data to be used: - `data-raw/Original_DHS/Cambodia/...` 
					 - `out/data/administrative_division/name_cambodia.csv`
	
	Output: `out/data/analysis/cambodia.dta`
	
*/


* Setup -------------------------------------------------

** Install command if not yet
* ssc install filelist
* ssc install distinct

clear all
macro drop _all
set more off

** Fixed throughout this Cambodia do-file
global projectFolder "~/Dropbox/Agri_Food_DHS"
global countryFolder "${projectFolder}/data-raw/Original_DHS/Cambodia"




* -------------------------------------------------------
* DHS 2014 ----------------------------------------------

** Fixed throughout 2014
global yearFolder "${countryFolder}/KH_2014_DHS" // change the year folder accordingly


*** (1) MERGE: HH Member Record (PR) and Children's Record (KR) ----

** Open HH Member Record file (PR) 
filelist, dir("${yearFolder}/KHPR73DT") pattern("*.DTA")
use "${yearFolder}/KHPR73DT/`=filename'", clear

** Rename (and sort by) IDs (uniquely identify a case)
rename (hv001 hv002 hvidx) (v001 v002 b16)
sort v001 v002 b16

** Save temporary data file 
tempfile PR2014
save "`PR2014'", replace


** Open Children's Record file (KR)
filelist, dir("${yearFolder}/KHKR73DT") pattern("*.DTA")
use "${yearFolder}/KHKR73DT/`=filename'", clear

* distinct v001 // 609 distinct clusters

** Drop children who died or are not listed in the household 
drop if b16 == 0 | b16 == . | b5 == 0 // noted that #{b16==0|b16==.} = #{b5==0}
sort v001 v002 b16

** Merge Children's (KR) and HH Member (PR) file
merge 1:1 v001 v002 b16 using "`PR2014'"
sort v001
keep if _merge == 3
drop _merge

* keep if _merge == 2 & hv105 <= 4
* ta hv105
** Majority of children in KR file are also in PR file, but not all

*** Save temporary data file
tempfile KRPR2014
save "`KRPR2014'", replace



*** (2) MERGE: Combined HR-PR and Geospatial covariate (GC) ----

*** Open Geospatial covariate file (GC) ----
filelist, dir("${yearFolder}/KHGC72FL") pattern("*.csv")
insheet using "${yearFolder}/KHGC72FL/`=filename'", clear
* distinct dhsclust // 611 distinct clusters

rename dhsclust v001
sort v001

** Save temporary data file 
tempfile GC2014
save "`GC2014'", replace


** Open combined and temporary saved KR & PR data
use "`KRPR2014'", clear

** Merge (KR & PR) with Geospatial covariate (GC)
merge m:1 v001 using "`GC2014'"
keep if _merge == 3
drop _merge

** Save the list of variable names
unab name2014: *

** Save combined 2014 data (done by (1)-(2))  as temporary data file
tempfile data2014
save "`data2014'", replace




* -------------------------------------------------------
* DHS 2010 ----------------------------------------------

** Fixed throughout 2010
global yearFolder "${countryFolder}/KH_2010_DHS" // change the year folder accordingly


*** (1) MERGE: HH Member Record (PR) and Children's Record (KR) ----

** Open HH Member Record file (PR) 
filelist, dir("${yearFolder}/KHPR61DT") pattern("*.DTA")
use "${yearFolder}/KHPR61DT/`=filename'", clear

** Rename (and sort by) IDs (uniquely identify a case)
rename (hv001 hv002 hvidx) (v001 v002 b16)
sort v001 v002 b16

** Save temporary data file
tempfile PR2010
save "`PR2010'", replace


** Open Children's Record file (KR)
filelist, dir("${yearFolder}/KHKR61DT") pattern("*.DTA")
use "${yearFolder}/KHKR61DT/`=filename'", clear

* distinct v001 // 611 distinct clusters

** Drop children who died or are not listed in the household 
drop if b16 == 0 | b16 == . | b5 == 0 
sort v001 v002 b16

** Merge Children's (KR) and HH Member (PR) file 
merge 1:1 v001 v002 b16 using "`PR2010'"
sort v001
keep if _merge == 3
drop _merge

** Save temporary data file 
tempfile KRPR2010
save "`KRPR2010'", replace



*** (2) MERGE: Combined HR-PR and Geospatial covariate (GC) ----

** Open Geospatial covariate file (GC)
filelist, dir("${yearFolder}/KHGC62FL") pattern("*.csv")
insheet using "${yearFolder}/KHGC62FL/`=filename'", clear
* distinct dhsclust // 611 distinct clusters

rename dhsclust v001
sort v001

** Save temporary data file
tempfile GC2010
save "`GC2010'", replace

** Open combined and temporary saved KR & PR data
use "`KRPR2010'", clear

** Merge (KR & PR) with Geospatial covariate (GC)
merge m:1 v001 using "`GC2010'"
drop _merge

** Save the list of variable names
unab name2010: *

** Save combined 2010 data (done by (1)-(2))  as temporary data file
tempfile data2010
save "`data2010'", replace

* di c(k)
* 1428




* -------------------------------------------------------
* DHS 2005 ----------------------------------------------

** Fixed throughout 2005
global yearFolder "${countryFolder}/KH_2005_DHS" // change the year folder accordingly


*** (1) MERGE: HH Member Record (PR) and Children's Record (KR) ----

** Open HH Member Record file (PR) 
filelist, dir("${yearFolder}/KHPR51DT") pattern("*.DTA")
use "${yearFolder}/KHPR51DT/`=filename'", clear

** As the year of interview (hv007) is masked by an empty label, remove it
label values hv007

** Rename (and sort by) IDs (uniquely identify a case)
rename (hv001 hv002 hvidx) (v001 v002 b16)
sort v001 v002 b16

** Save temporary data file
tempfile PR2005
save "`PR2005'", replace


** Open Children's Record file (KR)
filelist, dir("${yearFolder}/KHKR51DT") pattern("*.DTA")
use "${yearFolder}/KHKR51DT/`=filename'", clear

** As the year of interview (hv007) is masked by an empty label, remove it
label values v007

* distinct v001 // 557 distinct clusters

** Drop children who died or are not listed in the household 
drop if b16 == 0 | b16 == . | b5 == 0 
sort v001 v002 b16

** Merge Children's (KR) and HH Member (PR) file 
merge 1:1 v001 v002 b16 using "`PR2005'"
sort v001
keep if _merge == 3
drop _merge

** Save temporary data file 
tempfile KRPR2005
save "`KRPR2005'", replace



*** (2) MERGE: Combined HR-PR and Geospatial covariate (GC) ----

** Open Geospatial covariate file (GC)
filelist, dir("${yearFolder}/KHGC52FL") pattern("*.csv")
insheet using "${yearFolder}/KHGC52FL/`=filename'", clear
* distinct dhsclust // 577 distinct clusters

rename dhsclust v001
sort v001

** Save temporary data file
tempfile GC2005
save "`GC2005'", replace

** Open combined and temporary saved KR & PR data
use "`KRPR2005'", clear

** Merge (KR & PR) with Geospatial covariate (GC)
merge m:1 v001 using "`GC2005'"
drop _merge

** Save the list of variable names
unab name2005: *

** Save combined 2005 data (done by (1)-(2))  as temporary data file
tempfile data2005
save "`data2005'", replace

* di c(k)
* 1741




* -------------------------------------------------------
* DHS 2000 ----------------------------------------------

** Fixed throughout 2001
global yearFolder "${countryFolder}/KH_2000_DHS" // change the year folder accordingly


*** (1) MERGE: HH Member Record (PR) and Children's Record (KR) ----

** Open HH Member Record file (PR) 
filelist, dir("${yearFolder}/KHPR42DT") pattern("*.dta")
use "${yearFolder}/KHPR42DT/`=filename'", clear

** Rename (and sort by) IDs (uniquely identify a case)
rename (hv001 hv002 hvidx) (v001 v002 b16)
sort v001 v002 b16

** Save temporary data file
tempfile PR2000
save "`PR2000'", replace


** Open Children's Record file (KR)
filelist, dir("${yearFolder}/KHKR42DT") pattern("*.dta")
use "${yearFolder}/KHKR42DT/`=filename'", clear

* distinct v001 // 471 distinct clusters

** Drop children who died or are not listed in the household 
drop if b16 == 0 | b16 == . | b5 == 0 
sort v001 v002 b16

** Merge Children's (KR) and HH Member (PR) file 
merge 1:1 v001 v002 b16 using "`PR2000'"
sort v001
keep if _merge == 3
drop _merge

** Save temporary data file 
tempfile KRPR2000
save "`KRPR2000'", replace



*** (2) MERGE: Combined HR-PR and Geospatial covariate (GC) ----

** Open Geospatial covariate file (GC)
filelist, dir("${yearFolder}/KHGC42FL") pattern("*.csv")
insheet using "${yearFolder}/KHGC42FL/`=filename'", clear
* distinct dhsclust // 471 distinct clusters

rename dhsclust v001
sort v001

** Save temporary data file
tempfile GC2000
save "`GC2000'", replace

** Open combined and temporary saved KR & PR data
use "`KRPR2000'", clear

** Merge (KR & PR) with Geospatial covariate (GC)
merge m:1 v001 using "`GC2000'"
keep if _merge == 3
drop _merge

** Save the list of variable names
unab name2000: *

** Save combined 2000 data (done by (1)-(2))  as temporary data file
tempfile data2000
save "`data2000'", replace

* di c(k)
* 1316




* -------------------------------------------------------
* Append All Waves --------------------------------------


*** (3) APPEND ----

* use tempfile of: data2014 data2010 data2005 data2000
foreach DHSyear in "`data2000'" "`data2005'" "`data2010'" "`data2014'" {
	append using "`DHSyear'"
}


** Remove unnecessary variables 
** Make a list of common variables
local common_00_05: list name2000 & name2005
local common_10_14: list name2010 & name2014

local common_var `common_00_05' `common_10_14'

local common_var_uniq: list uniq common_var
dis "`common_var_uniq'"

** Keep the common variables across 2000-2014 (approx. 2,412 --> 1,362)
keep `common_var_uniq'


** Make a `country' and `end_year' variable as a key to merge with region name data
gen country = "Cambodia"
gen end_year = v007
replace end_year = 2005 if inlist(v007, 2005, 2006)
replace end_year = 2010 if inlist(v007, 2010, 2011)

** Save temporary data file
tempfile original_dhs
save "`original_dhs'", replace




* -------------------------------------------------------
* Including the admin region names ----------------------


*** (4) MARGE: PR, KR, GC (1999-00 to 2014) and the administrative region names ----

** Noted that the region names were extracted by using survey GPS 
** from the GE (shp file) file of original DHS and data of administrative boundary data 

insheet using "${projectFolder}/out/data/administrative_division/name_cambodia.csv", clear
sort end_year v001

** Save temporary data file
tempfile region_name
save "`region_name'", replace

** Open tmp saved DHS (PR, KR, GC)
use "`original_dhs'", clear

** Merge (in 35 obs, 5 clusters, GPS info were missing thus no admin region names were attached)
merge m:1 country end_year v001 using "`region_name'"
* keep if _merge == 1
drop if _merge == 2
drop _merge // in case keep those no-region-name observations (_merge == 1)




* -------------------------------------------------------
* Including the AReNA DHS (the final step) --------------

*** (5) MERGE: with merged (combined) AReNA DHS ----
** Do-file to make the merged AReNA DHS: `src/data_management/0_1_merge_AReNA_DHS.do`

merge m:1 country end_year v001 using "${projectFolder}/out/data/AReNA_DHS/AReNA_DHS_merged.dta"

* ta country _merge
keep if _merge == 3
drop _merge // in case keep those no-region-name observations (_merge == 1)




* -------------------------------------------------------
* Modify Incorrect End-Years ----------------------------
* (`end_year` created in the Cambodian DHS is adjusted to years in AReNA)

replace end_year = 2006 if inlist(v007, 2005, 2006)
replace end_year = 2011 if inlist(v007, 2010, 2011)




* -------------------------------------------------------
* Save --------------------------------------------------

save "${projectFolder}/out/data/analysis/cambodia.dta", replace
