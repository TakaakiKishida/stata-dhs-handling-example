/*
	
	Make repeated-cross-section dataset in Bangladesh from DHS 1999-00 to DHS 2014
	Process: (1) & (2) for each year --> (3) Append all waves --> (4) --> (5)
	
	(1) For HH and individual data, merge Children's Recode (KR) with HH Members Record (PR)
	
	(2) For Geospatial variables provided by original DHS, include original CSV (GC) when merging data at each year
	
	(3) Append the all waves (years)
	
	(4) For administrative region names, include it after completing (1)-(3)
	
	(5) For Geospatial variables provided by AReNA's DHS, include it after completing (1)-(4)
		--> This is created by `src/data_management/extract_dhs_region_name.R` using data from GE files in original DHS
	
	Note: As `tempfile` is used to save intermediate data for merge works, running code by each line cause an error.
		  Instead, running codes by each (DHS) year (or entire do-file) can successfully execute and make expected results.
		  
	Data to be used: - `data-raw/Original_DHS/Bangladesh/...` 
					 - `out/data/administrative_division/name_bangladesh.csv`
	
	Output: `out/data/analysis/bangladesh.dta`
	
*/


* Setup -------------------------------------------------

** Install command if not yet
* ssc install filelist
* ssc install distinct

clear all
macro drop _all
set more off

** Fixed throughout this Bangladesh do-file
global projectFolder "~/Dropbox/Agri_Food_DHS"
global countryFolder "${projectFolder}/data-raw/Original_DHS/Bangladesh"



* -------------------------------------------------------
* DHS 2017-18 -------------------------------------------

** Fixed throughout 2017-18
global yearFolder "${countryFolder}/BD_2017-18_DHS" // change the year folder accordingly

*** (1) MERGE: HH Member Record (PR) and Children's Record (KR) ----

** Open HH Member Record file (PR) 
filelist, dir("${yearFolder}/BDPR7RDT") pattern("*.DTA")
use "${yearFolder}/BDPR7RDT/`=filename'", clear

** Rename (and sort by) IDs (uniquely identify a case)
rename (hv001 hv002 hvidx) (v001 v002 b16)
sort v001 v002 b16

** Save temporary data file 
tempfile PR2018
save "`PR2018'", replace

** Open Children's Record file (KR)
filelist, dir("${yearFolder}/BDKR7RDT") pattern("*.DTA")
use "${yearFolder}/BDKR7RDT/`=filename'", clear

** Drop children who died or are not listed in the household 
drop if b16 == 0 | b16 == . | b5 == 0 // noted that #{b16==0|b16==.} = #{b5==0}
sort v001 v002 b16

** Merge Children's (KR) and HH Member (PR) file
merge 1:1 v001 v002 b16 using "`PR2018'"
sort v001
keep if _merge == 3
drop _merge

*** Save temporary data file
tempfile KRPR2018
save "`KRPR2018'", replace


*** (2) MERGE: Combined HR-PR and Geospatial covariate (GC) ----

*** Open Geospatial covariate file (GC) ----
filelist, dir("${yearFolder}/BDGC7RFL/BDGC7RFL") pattern("*.csv")
insheet using "${yearFolder}/BDGC7RFL/BDGC7RFL/`=filename'", clear
* distinct dhsclust // 600 distinct clusters

rename dhsclust v001
sort v001

** Save temporary data file 
tempfile GC2018
save "`GC2018'", replace


** Open combined and temporary saved KR & PR data
use "`KRPR2018'", clear

** Merge (KR & PR) with Geospatial covariate (GC)
merge m:1 v001 using "`GC2018'"
drop _merge

** Save the list of variable names
unab name2018: *

** Save combined 2014 data (done by (1)-(2))  as temporary data file
tempfile data2018
save "`data2018'", replace



* -------------------------------------------------------
* DHS 2014 ----------------------------------------------

** Fixed throughout 2014
global yearFolder "${countryFolder}/BD_2014_DHS" // change the year folder accordingly


*** (1) MERGE: HH Member Record (PR) and Children's Record (KR) ----

** Open HH Member Record file (PR) 
filelist, dir("${yearFolder}/BDPR72DT") pattern("*.DTA")
use "${yearFolder}/BDPR72DT/`=filename'", clear

** Rename (and sort by) IDs (uniquely identify a case)
rename (hv001 hv002 hvidx) (v001 v002 b16)
sort v001 v002 b16

** Save temporary data file 
tempfile PR2014
save "`PR2014'", replace


** Open Children's Record file (KR)
filelist, dir("${yearFolder}/BDKR72DT") pattern("*.DTA")
use "${yearFolder}/BDKR72DT/`=filename'", clear

* distinct v001 // 600 distinct clusters

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
filelist, dir("${yearFolder}/BDGC72FL") pattern("*.csv")
insheet using "${yearFolder}/BDGC72FL/`=filename'", clear
* distinct dhsclust // 600 distinct clusters

rename dhsclust v001
sort v001

** Save temporary data file 
tempfile GC2014
save "`GC2014'", replace


** Open combined and temporary saved KR & PR data
use "`KRPR2014'", clear

** Merge (KR & PR) with Geospatial covariate (GC)
merge m:1 v001 using "`GC2014'"
drop _merge

** Save the list of variable names
unab name2014: *

** Save combined 2014 data (done by (1)-(2))  as temporary data file
tempfile data2014
save "`data2014'", replace



* -------------------------------------------------------
* DHS 2011 ----------------------------------------------

** Fixed throughout 2011
global yearFolder "${countryFolder}/BD_2011_DHS" // change the year folder accordingly


*** (1) MERGE: HH Member Record (PR) and Children's Record (KR) ----

** Open HH Member Record file (PR) 
filelist, dir("${yearFolder}/BDPR61DT") pattern("*.DTA")
use "${yearFolder}/BDPR61DT/`=filename'", clear

** Rename (and sort by) IDs (uniquely identify a case)
rename (hv001 hv002 hvidx) (v001 v002 b16)
sort v001 v002 b16

** Save temporary data file
tempfile PR2011
save "`PR2011'", replace


** Open Children's Record file (KR)
filelist, dir("${yearFolder}/BDKR61DT") pattern("*.DTA")
use "${yearFolder}/BDKR61DT/`=filename'", clear

* distinct v001 // 600 distinct clusters

** Drop children who died or are not listed in the household 
drop if b16 == 0 | b16 == . | b5 == 0 
sort v001 v002 b16

** Merge Children's (KR) and HH Member (PR) file 
merge 1:1 v001 v002 b16 using "`PR2011'"
sort v001
keep if _merge == 3
drop _merge

** Save temporary data file 
tempfile KRPR2011
save "`KRPR2011'", replace


*** (2) MERGE: Combined HR-PR and Geospatial covariate (GC) ----

** Open Geospatial covariate file (GC)
filelist, dir("${yearFolder}/BDGC62FL") pattern("*.csv")
insheet using "${yearFolder}/BDGC62FL/`=filename'", clear
* distinct dhsclust

rename dhsclust v001
sort v001

** Save temporary data file
tempfile GC2011
save "`GC2011'", replace

** Open combined and temporary saved KR & PR data
use "`KRPR2011'", clear

** Merge (KR & PR) with Geospatial covariate (GC)
merge m:1 v001 using "`GC2011'"
drop _merge

** Save the list of variable names
unab name2011: *

** Save combined 2011 data (done by (1)-(2))  as temporary data file
tempfile data2011
save "`data2011'", replace

di c(k)
* 1561



* -------------------------------------------------------
* DHS 2007 ----------------------------------------------

** Fixed throughout 2007
global yearFolder "${countryFolder}/BD_2007_DHS" // change the year folder accordingly


*** (1) MERGE: HH Member Record (PR) and Children's Record (KR) ----

** Open HH Member Record file (PR) 
filelist, dir("${yearFolder}/BDPR51DT") pattern("*.DTA")
use "${yearFolder}/BDPR51DT/`=filename'", clear

** As the year of interview (hv007) is masked by an empty label, remove it
label values hv007

** Rename (and sort by) IDs (uniquely identify a case)
rename (hv001 hv002 hvidx) (v001 v002 b16)
sort v001 v002 b16

** Save temporary data file
tempfile PR2007
save "`PR2007'", replace


** Open Children's Record file (KR)
filelist, dir("${yearFolder}/BDKR51DT") pattern("*.DTA")
use "${yearFolder}/BDKR51DT/`=filename'", clear

** As the year of interview (hv007) is masked by an empty label, remove it
label values v007

* distinct v001 // 361 distinct clusters

** Drop children who died or are not listed in the household 
drop if b16 == 0 | b16 == . | b5 == 0 
sort v001 v002 b16

** Merge Children's (KR) and HH Member (PR) file 
merge 1:1 v001 v002 b16 using "`PR2007'"
sort v001
keep if _merge == 3
drop _merge

** Save temporary data file 
tempfile KRPR2007
save "`KRPR2007'", replace


*** (2) MERGE: Combined HR-PR and Geospatial covariate (GC) ----

** Open Geospatial covariate file (GC)
filelist, dir("${yearFolder}/BDGC52FL") pattern("*.csv")
insheet using "${yearFolder}/BDGC52FL/`=filename'", clear
* distinct dhsclust // 361 distinct clusters

rename dhsclust v001
sort v001

** Save temporary data file
tempfile GC2007
save "`GC2007'", replace

** Open combined and temporary saved KR & PR data
use "`KRPR2007'", clear

** Merge (KR & PR) with Geospatial covariate (GC)
merge m:1 v001 using "`GC2007'"
drop _merge

** Save the list of variable names
unab name2007: *

** Save combined 2007 data (done by (1)-(2))  as temporary data file
tempfile data2007
save "`data2007'", replace

* di c(k)
* 1459



* -------------------------------------------------------
* DHS 2004 ----------------------------------------------

** Fixed throughout 2004
global yearFolder "${countryFolder}/BD_2004_DHS" // change the year folder accordingly


*** (1) MERGE: HH Member Record (PR) and Children's Record (KR) ----

** Open HH Member Record file (PR) 
filelist, dir("${yearFolder}/BDPR4JDT") pattern("*.DTA")
use "${yearFolder}/BDPR4JDT/`=filename'", clear

** Rename (and sort by) IDs (uniquely identify a case)
rename (hv001 hv002 hvidx) (v001 v002 b16)
sort v001 v002 b16

** Save temporary data file
tempfile PR2004
save "`PR2004'", replace


** Open Children's Record file (KR)
filelist, dir("${yearFolder}/BDKR4JDT") pattern("*.DTA")
use "${yearFolder}/BDKR4JDT/`=filename'", clear

* distinct v001 // 361 distinct clusters

** Drop children who died or are not listed in the household 
drop if b16 == 0 | b16 == . | b5 == 0 
sort v001 v002 b16

** Merge Children's (KR) and HH Member (PR) file 
merge 1:1 v001 v002 b16 using "`PR2004'"
sort v001
keep if _merge == 3
drop _merge

** Save temporary data file 
tempfile KRPR2004
save "`KRPR2004'", replace


*** (2) MERGE: Combined HR-PR and Geospatial covariate (GC) ----

** Open Geospatial covariate file (GC)
filelist, dir("${yearFolder}/BDGC4JFL") pattern("*.csv")
insheet using "${yearFolder}/BDGC4JFL/`=filename'", clear
* distinct dhsclust // 361 distinct clusters

rename dhsclust v001
sort v001

** Save temporary data file
tempfile GC2004
save "`GC2004'", replace

** Open combined and temporary saved KR & PR data
use "`KRPR2004'", clear

** Merge (KR & PR) with Geospatial covariate (GC)
merge m:1 v001 using "`GC2004'"
drop _merge

** Save the list of variable names
unab name2004: *

** Save combined 2004 data (done by (1)-(2))  as temporary data file
tempfile data2004
save "`data2004'", replace

* di c(k)
* 1488



* -------------------------------------------------------
* DHS 1999-00 -------------------------------------------

** Fixed throughout 1999-00
global yearFolder "${countryFolder}/BD_1999-00_DHS" // change the year folder accordingly


*** (1) MERGE: HH Member Record (PR) and Children's Record (KR) ----

** Open HH Member Record file (PR) 
filelist, dir("${yearFolder}/BDPR41DT") pattern("*.DTA")
use "${yearFolder}/BDPR41DT/`=filename'", clear

** As the year of interview (hv007) is masked and digits are not 4, remove a mask and replace
label values hv007
replace hv007 = 1999 if hv007 == 99
replace hv007 = 2000 if hv007 == 0

** Rename (and sort by) IDs (uniquely identify a case)
rename (hv001 hv002 hvidx) (v001 v002 b16)
sort v001 v002 b16

** Save temporary data file
tempfile PR2000
save "`PR2000'", replace


** Open Children's Record file (KR)
filelist, dir("${yearFolder}/BDKR41DT") pattern("*.DTA")
use "${yearFolder}/BDKR41DT/`=filename'", clear

* distinct v001 // 341 distinct clusters

** As the year of interview (hv007) is masked and digits are not 4, remove a mask and replace
label values v007
replace v007 = 1999 if v007 == 99
replace v007 = 2000 if v007 == 0

** Rename child's line number (to be consistent with DHS 2004 onward)
rename s219 b16

** Drop children who died or are not listed in the household 
drop if b16 == 0 | b16 == . | b5 == 0 
sort v001 v002 b16

** Merge Children's (KR) and HH Member (PR) file 
merge m:1 v001 v002 b16 using "`PR2000'"
sort v001
keep if _merge == 3
drop _merge

** Save temporary data file 
tempfile KRPR2000
save "`KRPR2000'", replace


*** (2) MERGE: Combined HR-PR and Geospatial covariate (GC) ----

** Open Geospatial covariate file (GC)
filelist, dir("${yearFolder}/BDGC42FL") pattern("*.csv")
insheet using "${yearFolder}/BDGC42FL/`=filename'", clear
* distinct dhsclust // 341 distinct clusters

rename dhsclust v001
sort v001

** Save temporary data file
tempfile GC2000
save "`GC2000'", replace

** Open combined and temporary saved KR & PR data
use "`KRPR2000'", clear

** Merge (KR & PR) with Geospatial covariate (GC)
merge m:1 v001 using "`GC2000'"
drop _merge

** Save the list of variable names
unab name2000: *

** Save combined 2000 data (done by (1)-(2)) as temporary data file
tempfile data2000
save "`data2000'", replace

* di c(k)
* 1103



* -------------------------------------------------------
* Append All Waves --------------------------------------


*** (3) APPEND ----

* use tempfile of: data2014 data2011 data2007 data2004 data2000
foreach DHSyear in "`data2004'" "`data2007'" "`data2011'" "`data2014'" "`data2018'" {
	append using "`DHSyear'", force
}

** Remove unnecessary variables 
** Make a list of common variables
local common_04_07: list name2004 & name2007
local common_11_14: list name2011 & name2014
local common_14_18: list name2014 & name2018

local common_var `common_04_07' `common_11_14' `common_14_18'

local common_var_uniq: list uniq common_var
dis "`common_var_uniq'"

** Keep the common variables across 2004-2014 (approx. 2,843 --> 1,356)
keep `common_var_uniq'

** Make a `country' and `end_year' variable as a key to merge with region name data
gen country = "Bangladesh"
gen end_year = v007
replace end_year = 2000 if inlist(v007, 1999, 2000)

** Save temporary data file
tempfile original_dhs
save "`original_dhs'", replace



* -------------------------------------------------------
* Including the admin region names ----------------------


*** (4) MARGE: PR, KR, GC (1999-00 to 2018) and the administrative region names ----

** Noted that the region names were extracted by using survey GPS 
** from the GE (shp file) file of original DHS and data of administrative boundary data 

insheet using "${projectFolder}/out/data/administrative_division/name_bangladesh.csv", clear
sort end_year v001

** Save temporary data file
tempfile region_name
save "`region_name'", replace

** Open tmp saved DHS (PR, KR, GC)
use "`original_dhs'", clear

** Merge (in 35 obs, 5 clusters, GPS info were missing thus no admin region names were attached)
merge m:1 country end_year v001 using "`region_name'"
drop _merge // in case keep those no-region-name observations (_merge == 1)


* -------------------------------------------------------
* Including the AReNA DHS (the final step) --------------

*** (5) MERGE: with merged (combined) AReNA DHS ----
** Do-file to make the merged AReNA DHS: `src/data_management/0_1_merge_AReNA_DHS.do`

/* Comment out on Feb 1, 2023 by Takaaki Kishida as including BD-DHS 2017-18 but AReNA does not have the period
merge m:1 country end_year v001 using "${projectFolder}/out/data/AReNA_DHS/AReNA_DHS_merged.dta"

* ta country _merge
keep if _merge == 3
drop _merge // in case keep those no-region-name observations (_merge == 1)
*/



* -------------------------------------------------------
* Adjust end_year
replace end_year = 2018 if end_year == 2017

* Drop observation with completely no information (generated in a matching/merging step)
drop if v002 == .


* -------------------------------------------------------
* Save --------------------------------------------------

save "${projectFolder}/out/data/analysis/bangladesh.dta", replace
