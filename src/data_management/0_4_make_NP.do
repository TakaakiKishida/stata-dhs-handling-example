/*
	
	Make repeated-cross-section dataset in Nepal from DHS 2001 to DHS 2016
	Process: (1) & (2) for each year --> (3) Append all waves --> (4) --> (5)
	
	(1) For HH and individual data, merge Children's Recode (KR) with HH Members Record (PR)
	
	(2) For Geospatial variables provided by original DHS, include original CSV (GC) when merging data at each year
	
	(3) Append the all waves (years)
	
	(4) For administrative region names, include it after completing (1)-(3)
	
	(5) For Geospatial variables provided by AReNA's DHS, include it after completing (1)-(4)
		--> This is created by `src/data_management/extract_dhs_region_name.R` using data from GE files in original DHS
	
	Note: As `tempfile` is used to save intermediate data for merge works, running code by each line cause an error.
		  Instead, running codes by each (DHS) year (or entire do-file) can successfully execute and make expected results.
		  
	Data to be used: - `data-raw/Original_DHS/Nepal/...` 
					 - `out/data/administrative_division/name_nepal.csv`
	
	Output: `out/data/analysis/nepal.dta`
	
*/


* Setup -------------------------------------------------

** Install command if not yet
* ssc install filelist
* ssc install distinct

clear all
macro drop _all
set more off

** Fixed throughout this Nepal do-file
global projectFolder "~/Dropbox/Agri_Food_DHS"
global countryFolder "${projectFolder}/data-raw/Original_DHS/Nepal"




* -------------------------------------------------------
* DHS 2016 ----------------------------------------------

** Fixed throughout 2016
global yearFolder "${countryFolder}/NP_2016_DHS" // change the year folder accordingly


*** (1) MERGE: HH Member Record (PR) and Children's Record (KR) ----

** Open HH Member Record file (PR) 
filelist, dir("${yearFolder}/NPPR7HDT") pattern("*.DTA")
use "${yearFolder}/NPPR7HDT/`=filename'", clear

** Rename (and sort by) IDs (uniquely identify a case)
rename (hv001 hv002 hvidx) (v001 v002 b16)
sort v001 v002 b16

** Save temporary data file 
tempfile PR2016
save "`PR2016'", replace


** Open Children's Record file (KR)
filelist, dir("${yearFolder}/NPKR7HDT") pattern("*.DTA")
use "${yearFolder}/NPKR7HDT/`=filename'", clear

* distinct v001 // 383 distinct clusters

** Drop children who died or are not listed in the household 
drop if b16 == 0 | b16 == . | b5 == 0 // noted that #{b16==0|b16==.} = #{b5==0}
sort v001 v002 b16

** Merge Children's (KR) and HH Member (PR) file
merge 1:1 v001 v002 b16 using "`PR2016'"
sort v001
keep if _merge == 3
drop _merge

* keep if _merge == 2 & hv105 <= 4
* ta hv105
** Majority of children in KR file are also in PR file, but not all

*** Save temporary data file
tempfile KRPR2016
save "`KRPR2016'", replace



*** (2) MERGE: Combined HR-PR and Geospatial covariate (GC) ----

*** Open Geospatial covariate file (GC) ----
filelist, dir("${yearFolder}/NPGC7BFL") pattern("*.csv")
insheet using "${yearFolder}/NPGC7BFL/`=filename'", clear
* distinct dhsclust // 383 distinct clusters

rename dhsclust v001
sort v001

** Save temporary data file 
tempfile GC2016
save "`GC2016'", replace


** Open combined and temporary saved KR & PR data
use "`KRPR2016'", clear

** Merge (KR & PR) with Geospatial covariate (GC)
merge m:1 v001 using "`GC2016'"
drop _merge

** Save the list of variable names
unab name2016: *

** Save combined 2016 data (done by (1)-(2))  as temporary data file
tempfile data2016
save "`data2016'", replace




* -------------------------------------------------------
* DHS 2011 ----------------------------------------------

** Fixed throughout 2011
global yearFolder "${countryFolder}/NP_2011_DHS" // change the year folder accordingly


*** (1) MERGE: HH Member Record (PR) and Children's Record (KR) ----

** Open HH Member Record file (PR) 
filelist, dir("${yearFolder}/NPPR61DT") pattern("*.DTA")
use "${yearFolder}/NPPR61DT/`=filename'", clear

** Rename (and sort by) IDs (uniquely identify a case)
rename (hv001 hv002 hvidx) (v001 v002 b16)
sort v001 v002 b16

** Save temporary data file
tempfile PR2011
save "`PR2011'", replace


** Open Children's Record file (KR)
filelist, dir("${yearFolder}/NPKR61DT") pattern("*.DTA")
use "${yearFolder}/NPKR61DT/`=filename'", clear

* distinct v001 // 289 distinct clusters

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
filelist, dir("${yearFolder}/NPGC62FL") pattern("*.csv")
insheet using "${yearFolder}/NPGC62FL/`=filename'", clear
* distinct dhsclust // 289 distinct clusters

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

* di c(k)
* 1465




* -------------------------------------------------------
* DHS 2006 ----------------------------------------------

** Fixed throughout 2006
global yearFolder "${countryFolder}/NP_2006_DHS" // change the year folder accordingly


*** (1) MERGE: HH Member Record (PR) and Children's Record (KR) ----

** Open HH Member Record file (PR) 
filelist, dir("${yearFolder}/NPPR51DT") pattern("*.dta")
use "${yearFolder}/NPPR51DT/`=filename'", clear

** As the year of interview (hv007) is masked by an empty label, remove it
label values hv007

** Rename (and sort by) IDs (uniquely identify a case)
rename (hv001 hv002 hvidx) (v001 v002 b16)
sort v001 v002 b16

** Save temporary data file
tempfile PR2006
save "`PR2006'", replace


** Open Children's Record file (KR)
filelist, dir("${yearFolder}/NPKR51DT") pattern("*.DTA")
use "${yearFolder}/NPKR51DT/`=filename'", clear

** As the year of interview (hv007) is masked by an empty label, remove it
label values v007

* distinct v001 // 260 distinct clusters

** Drop children who died or are not listed in the household 
drop if b16 == 0 | b16 == . | b5 == 0 
sort v001 v002 b16

** Merge Children's (KR) and HH Member (PR) file 
merge 1:1 v001 v002 b16 using "`PR2006'"
sort v001
keep if _merge == 3
drop _merge

** Save temporary data file 
tempfile KRPR2006
save "`KRPR2006'", replace



*** (2) MERGE: Combined HR-PR and Geospatial covariate (GC) ----

** Open Geospatial covariate file (GC)
filelist, dir("${yearFolder}/NPGC52FL") pattern("*.csv")
insheet using "${yearFolder}/NPGC52FL/`=filename'", clear
* distinct dhsclust // 361 distinct clusters

rename dhsclust v001
sort v001

** Save temporary data file
tempfile GC2006
save "`GC2006'", replace

** Open combined and temporary saved KR & PR data
use "`KRPR2006'", clear

** Merge (KR & PR) with Geospatial covariate (GC)
merge m:1 v001 using "`GC2006'"
drop _merge

** Save the list of variable names
unab name2006: *

** Save combined 2006 data (done by (1)-(2))  as temporary data file
tempfile data2006
save "`data2006'", replace

* di c(k)
* 1468




* -------------------------------------------------------
* DHS 2001 ----------------------------------------------

** Fixed throughout 2001
global yearFolder "${countryFolder}/NP_2001_DHS" // change the year folder accordingly


*** (1) MERGE: HH Member Record (PR) and Children's Record (KR) ----

** Open HH Member Record file (PR) 
filelist, dir("${yearFolder}/NPPR41DT") pattern("*.DTA")
use "${yearFolder}/NPPR41DT/`=filename'", clear

** Rename (and sort by) IDs (uniquely identify a case)
rename (hv001 hv002 hvidx) (v001 v002 b16)
sort v001 v002 b16

** Save temporary data file
tempfile PR2001
save "`PR2001'", replace


** Open Children's Record file (KR)
filelist, dir("${yearFolder}/NPKR41DT") pattern("*.DTA")
use "${yearFolder}/NPKR41DT/`=filename'", clear

* distinct v001 // 248 distinct clusters

** Drop children who died or are not listed in the household 
drop if b16 == 0 | b16 == . | b5 == 0 
sort v001 v002 b16

** Merge Children's (KR) and HH Member (PR) file 
merge 1:1 v001 v002 b16 using "`PR2001'"
sort v001
keep if _merge == 3
drop _merge

** Save temporary data file 
tempfile KRPR2001
save "`KRPR2001'", replace



*** (2) MERGE: Combined HR-PR and Geospatial covariate (GC) ----

** Open Geospatial covariate file (GC)
filelist, dir("${yearFolder}/NPGC42FL") pattern("*.csv")
insheet using "${yearFolder}/NPGC42FL/`=filename'", clear
distinct dhsclust // 251 distinct clusters

rename dhsclust v001
sort v001

** Save temporary data file
tempfile GC2001
save "`GC2001'", replace

** Open combined and temporary saved KR & PR data
use "`KRPR2001'", clear

** Merge (KR & PR) with Geospatial covariate (GC)
merge m:1 v001 using "`GC2001'"
keep if _merge == 3
drop _merge

** Save the list of variable names
unab name2001: *

** Save combined 2001 data (done by (1)-(2))  as temporary data file
tempfile data2001
save "`data2001'", replace

* di c(k)
* 1140




* -------------------------------------------------------
* Append All Waves --------------------------------------


*** (3) APPEND ----

* use tempfile of: data2014 data2011 data2007 data2004 data2000
foreach DHSyear in "`data2001'" "`data2006'" "`data2011'" "`data2016'" {
	append using "`DHSyear'"
}


** Remove unnecessary variables 
** Make a list of common variables
local common_01_06: list name2001 & name2006
local common_11_16: list name2011 & name2016

local common_var `common_01_06' `common_11_16'

local common_var_uniq: list uniq common_var
dis "`common_var_uniq'"

** Keep the common variables across 2001-2016 (approx. 2,524 --> 1,245)
keep `common_var_uniq'

** ---------------------------------------------------------------------------------------------
** ---------------------------------------------------------------------------------------------
** In Nepal DHS, year and month are used the "Nepali calendar". Here I convert to the "global calendar".
**** Current status: waiting answers from DHS users
a ----------------------------------------------------------------------------------------------
** Year
replace v007 = 
** ---------------------------------------------------------------------------------------------
** ---------------------------------------------------------------------------------------------

** Make a `country' and `end_year' variable as a key to merge with region name data
gen country = "Nepal"
gen end_year = v007
replace end_year = 2000 if inlist(v007, 1999, 2000)

** Save temporary data file
tempfile original_dhs
save "`original_dhs'", replace




* -------------------------------------------------------
* Including the admin region names ----------------------


*** (4) MARGE: PR, KR, GC (1999-00 to 2014) and the administrative region names ----

** Noted that the region names were extracted by using survey GPS 
** from the GE (shp file) file of original DHS and data of administrative boundary data 

insheet using "${projectFolder}/out/data/administrative_division/name_nepal.csv", clear
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

merge m:1 country end_year v001 using "${projectFolder}/out/data/AReNA_DHS/AReNA_DHS_merged.dta"

* ta country _merge
keep if _merge == 3
drop _merge // in case keep those no-region-name observations (_merge == 1)




* -------------------------------------------------------
* Save --------------------------------------------------

save "${projectFolder}/out/data/analysis/nepal.dta", replace
