/*

	Make Rainfall Variables
	
	--- Absolute Amount ---
	(0) Make Annual Rainfall Variables (sum of 12 months)
	
	Prior to the DHS Survey Period
	(1-1) 12 Months before the Survey (i.e., if survey is conducted in Apr 2010, use rainfall from May 2009 to Apr 2010)
	(1-2) 1-2 Years before the Survey (i.e., 13-24 months)
	(1-3) 2-3 Years before the Survey (i.e., 25-36 months)
	
	During the Pregnancy / Trimester
	(2-1) During Pregnancy (1st to 3rd trimester & sum of them)
	
	--- Relative Change / Long-run Deviation ---
	Prior to the DHS Survey Period
	(3-1) Percentage Deviation from Mean Rainfall (Annual)
	(3-2) Extreme Rainfall (Annual)
	(3-3) Percentage Deviation from Mean Rainfall (Summer, pre-survey)
	(3-4) Percentage Deviation from Mean Rainfall (Rainy Season, pre-survey) 
	(3-5) Percentage Deviation from Mean Rainfall (Autumn, pre-survey) 
		  | Season                           | Period               | Weather Events                        | 
		  | -------------------------------- | -------------------- | ------------------------------------- |
		  | Summer (Pre-monsoon)             | March to May         | Cyclone, Heat Wave                    | 
		  | Rainy Season (Southwest Monsoon) | June to September    | Heavy Rain, Monsoon Depression, Flood |
	      | Autumn (Post-monsoon)            | October to November  | Cyclone, Tornado                      |
		  | Winter (Northeast Monsoon)       | December to February | Drought, Cold Wave                    | <-- Not yet
*/


* -------------------------------------------------------
* (0) Make Annual Rainfall Variables (sum of 12 months) -

forvalues year = 1980/2019 {
	unab rainMonth: p`year'_*
	dis "Sum of: `rainMonth'"
	egen rain`year' = rowtotal(`rainMonth')
}




* -------------------------------------------------------

forvalues i = 0/2{
	gen total_rain_`i'year_ago = .
}

* -------------------------------------------------------
* (1-1) 12 Months before the Survey ---------------------

forvalues yearSurvey = 1999/2014 {
	local yearLag = `yearSurvey' - 1
	
	** Define the period of rainfall (during the past 12 months prior to the survey)
	unab jan: p`yearSurvey'_1 p`yearLag'_12 p`yearLag'_11 p`yearLag'_10 p`yearLag'_9 p`yearLag'_8 ///
	          p`yearLag'_7 p`yearLag'_6 p`yearLag'_5 p`yearLag'_4 p`yearLag'_3 p`yearLag'_2
	
	unab feb: p`yearSurvey'_2 p`yearSurvey'_1 p`yearLag'_12 p`yearLag'_11 p`yearLag'_10 p`yearLag'_9 ///
	          p`yearLag'_8 p`yearLag'_7 p`yearLag'_6 p`yearLag'_5 p`yearLag'_4 p`yearLag'_3
	
	unab mar: p`yearSurvey'_3 p`yearSurvey'_2 p`yearSurvey'_1 p`yearLag'_12 p`yearLag'_11 p`yearLag'_10 ///
	          p`yearLag'_9 p`yearLag'_8 p`yearLag'_7 p`yearLag'_6 p`yearLag'_5 p`yearLag'_4 
	
	unab apr: p`yearSurvey'_4 p`yearSurvey'_3 p`yearSurvey'_2 p`yearSurvey'_1 p`yearLag'_12 p`yearLag'_11 ///
	          p`yearLag'_10 p`yearLag'_9 p`yearLag'_8 p`yearLag'_7 p`yearLag'_6 p`yearLag'_5
			  
	unab may: p`yearSurvey'_5 p`yearSurvey'_4 p`yearSurvey'_3 p`yearSurvey'_2 p`yearSurvey'_1 p`yearLag'_12 ///
	          p`yearLag'_11 p`yearLag'_10 p`yearLag'_9 p`yearLag'_8 p`yearLag'_7 p`yearLag'_6
	
	unab jun: p`yearSurvey'_6 p`yearSurvey'_5 p`yearSurvey'_4 p`yearSurvey'_3 p`yearSurvey'_2 p`yearSurvey'_1 ///
	          p`yearLag'_12 p`yearLag'_11 p`yearLag'_10 p`yearLag'_9 p`yearLag'_8 p`yearLag'_7
	
	unab jul: p`yearSurvey'_7 p`yearSurvey'_6 p`yearSurvey'_5 p`yearSurvey'_4 p`yearSurvey'_3 p`yearSurvey'_2 ///
	          p`yearSurvey'_1 p`yearLag'_12 p`yearLag'_11 p`yearLag'_10 p`yearLag'_9 p`yearLag'_8
	
	unab aug: p`yearSurvey'_8 p`yearSurvey'_7 p`yearSurvey'_6 p`yearSurvey'_5 p`yearSurvey'_4 p`yearSurvey'_3 ///
	          p`yearSurvey'_2 p`yearSurvey'_1 p`yearLag'_12 p`yearLag'_11 p`yearLag'_10 p`yearLag'_9
	
	unab sep: p`yearSurvey'_9 p`yearSurvey'_8 p`yearSurvey'_7 p`yearSurvey'_6 p`yearSurvey'_5 p`yearSurvey'_4 ///
	          p`yearSurvey'_3 p`yearSurvey'_2 p`yearSurvey'_1 p`yearLag'_12 p`yearLag'_11 p`yearLag'_10 
			  
	unab oct: p`yearSurvey'_10 p`yearSurvey'_9 p`yearSurvey'_8 p`yearSurvey'_7 p`yearSurvey'_6 p`yearSurvey'_5 ///
	          p`yearSurvey'_4 p`yearSurvey'_3 p`yearSurvey'_2 p`yearSurvey'_1 p`yearLag'_12 p`yearLag'_11
	
	unab nov: p`yearSurvey'_11 p`yearSurvey'_10 p`yearSurvey'_9 p`yearSurvey'_8 p`yearSurvey'_7 p`yearSurvey'_6 ///
	          p`yearSurvey'_5 p`yearSurvey'_4 p`yearSurvey'_3 p`yearSurvey'_2 p`yearSurvey'_1 p`yearLag'_12
	
	unab dec: p`yearSurvey'_12 p`yearSurvey'_11 p`yearSurvey'_10 p`yearSurvey'_9 p`yearSurvey'_8 p`yearSurvey'_7 ///
	          p`yearSurvey'_6 p`yearSurvey'_5 p`yearSurvey'_4 p`yearSurvey'_3 p`yearSurvey'_2 p`yearSurvey'_1
	
	** Calculate the total amount of ranifall
	egen total_rain_0year_ago_`yearSurvey'_1 = rowtotal(`jan') if DHSyear == `yearSurvey' & DHSmonth == 1
	egen total_rain_0year_ago_`yearSurvey'_2 = rowtotal(`feb') if DHSyear == `yearSurvey' & DHSmonth == 2
	egen total_rain_0year_ago_`yearSurvey'_3 = rowtotal(`mar') if DHSyear == `yearSurvey' & DHSmonth == 3
	egen total_rain_0year_ago_`yearSurvey'_4 = rowtotal(`apr') if DHSyear == `yearSurvey' & DHSmonth == 4
	egen total_rain_0year_ago_`yearSurvey'_5 = rowtotal(`may') if DHSyear == `yearSurvey' & DHSmonth == 5
	egen total_rain_0year_ago_`yearSurvey'_6 = rowtotal(`jun') if DHSyear == `yearSurvey' & DHSmonth == 6
	egen total_rain_0year_ago_`yearSurvey'_7 = rowtotal(`jul') if DHSyear == `yearSurvey' & DHSmonth == 7
	egen total_rain_0year_ago_`yearSurvey'_8 = rowtotal(`aug') if DHSyear == `yearSurvey' & DHSmonth == 8
	egen total_rain_0year_ago_`yearSurvey'_9 = rowtotal(`sep') if DHSyear == `yearSurvey' & DHSmonth == 9
	egen total_rain_0year_ago_`yearSurvey'_10 = rowtotal(`oct') if DHSyear == `yearSurvey' & DHSmonth == 10
	egen total_rain_0year_ago_`yearSurvey'_11 = rowtotal(`nov') if DHSyear == `yearSurvey' & DHSmonth == 11
	egen total_rain_0year_ago_`yearSurvey'_12 = rowtotal(`dec') if DHSyear == `yearSurvey' & DHSmonth == 12	
}

forvalues yearSurvey = 1999/2014 {
	forvalues monthSurvey = 1/12 {
		** combine all variables
		replace total_rain_0year_ago = total_rain_0year_ago_`yearSurvey'_`monthSurvey' if DHSyear == `yearSurvey' & DHSmonth == `monthSurvey'
		drop total_rain_0year_ago_`yearSurvey'_`monthSurvey'
	}
}




* -------------------------------------------------------
* (1-2) 1-2 Years before the Survey ---------------------

forvalues yearSurvey = 1999/2014 {
	local yearLag1 = `yearSurvey' - 1
	local yearLag2 = `yearSurvey' - 2
	
	** Define the period of rainfall (during the past 12 months prior to the survey)
	unab jan: p`yearLag1'_1 p`yearLag2'_12 p`yearLag2'_11 p`yearLag2'_10 p`yearLag2'_9 p`yearLag2'_8 ///
	          p`yearLag2'_7 p`yearLag2'_6 p`yearLag2'_5 p`yearLag2'_4 p`yearLag2'_3 p`yearLag2'_2
	
	unab feb: p`yearLag1'_2 p`yearLag1'_1 p`yearLag2'_12 p`yearLag2'_11 p`yearLag2'_10 p`yearLag2'_9 ///
	          p`yearLag2'_8 p`yearLag2'_7 p`yearLag2'_6 p`yearLag2'_5 p`yearLag2'_4 p`yearLag2'_3
	
	unab mar: p`yearLag1'_3 p`yearLag1'_2 p`yearLag1'_1 p`yearLag2'_12 p`yearLag2'_11 p`yearLag2'_10 ///
	          p`yearLag2'_9 p`yearLag2'_8 p`yearLag2'_7 p`yearLag2'_6 p`yearLag2'_5 p`yearLag2'_4 
	
	unab apr: p`yearLag1'_4 p`yearLag1'_3 p`yearLag1'_2 p`yearLag1'_1 p`yearLag2'_12 p`yearLag2'_11 ///
	          p`yearLag2'_10 p`yearLag2'_9 p`yearLag2'_8 p`yearLag2'_7 p`yearLag2'_6 p`yearLag2'_5
			  
	unab may: p`yearLag1'_5 p`yearLag1'_4 p`yearLag1'_3 p`yearLag1'_2 p`yearLag1'_1 p`yearLag2'_12 ///
	          p`yearLag2'_11 p`yearLag2'_10 p`yearLag2'_9 p`yearLag2'_8 p`yearLag2'_7 p`yearLag2'_6
	
	unab jun: p`yearLag1'_6 p`yearLag1'_5 p`yearLag1'_4 p`yearLag1'_3 p`yearLag1'_2 p`yearLag1'_1 ///
	          p`yearLag2'_12 p`yearLag2'_11 p`yearLag2'_10 p`yearLag2'_9 p`yearLag2'_8 p`yearLag2'_7
	
	unab jul: p`yearLag1'_7 p`yearLag1'_6 p`yearLag1'_5 p`yearLag1'_4 p`yearLag1'_3 p`yearLag1'_2 ///
	          p`yearLag1'_1 p`yearLag2'_12 p`yearLag2'_11 p`yearLag2'_10 p`yearLag2'_9 p`yearLag2'_8
	
	unab aug: p`yearLag1'_8 p`yearLag1'_7 p`yearLag1'_6 p`yearLag1'_5 p`yearLag1'_4 p`yearLag1'_3 ///
	          p`yearLag1'_2 p`yearLag1'_1 p`yearLag2'_12 p`yearLag2'_11 p`yearLag2'_10 p`yearLag2'_9
	
	unab sep: p`yearLag1'_9 p`yearLag1'_8 p`yearLag1'_7 p`yearLag1'_6 p`yearLag1'_5 p`yearLag1'_4 ///
	          p`yearLag1'_3 p`yearLag1'_2 p`yearLag1'_1 p`yearLag2'_12 p`yearLag2'_11 p`yearLag2'_10 
			  
	unab oct: p`yearLag1'_10 p`yearLag1'_9 p`yearLag1'_8 p`yearLag1'_7 p`yearLag1'_6 p`yearLag1'_5 ///
	          p`yearLag1'_4 p`yearLag1'_3 p`yearLag1'_2 p`yearLag1'_1 p`yearLag2'_12 p`yearLag2'_11
	
	unab nov: p`yearLag1'_11 p`yearLag1'_10 p`yearLag1'_9 p`yearLag1'_8 p`yearLag1'_7 p`yearLag1'_6 ///
	          p`yearLag1'_5 p`yearLag1'_4 p`yearLag1'_3 p`yearLag1'_2 p`yearLag1'_1 p`yearLag2'_12
	
	unab dec: p`yearLag1'_12 p`yearLag1'_11 p`yearLag1'_10 p`yearLag1'_9 p`yearLag1'_8 p`yearLag1'_7 ///
	          p`yearLag1'_6 p`yearLag1'_5 p`yearLag1'_4 p`yearLag1'_3 p`yearLag1'_2 p`yearLag1'_1
	
	** Calculate the total amount of ranifall
	egen total_rain_1year_ago_`yearSurvey'_1 = rowtotal(`jan') if DHSyear == `yearSurvey' & DHSmonth == 1
	egen total_rain_1year_ago_`yearSurvey'_2 = rowtotal(`feb') if DHSyear == `yearSurvey' & DHSmonth == 2
	egen total_rain_1year_ago_`yearSurvey'_3 = rowtotal(`mar') if DHSyear == `yearSurvey' & DHSmonth == 3
	egen total_rain_1year_ago_`yearSurvey'_4 = rowtotal(`apr') if DHSyear == `yearSurvey' & DHSmonth == 4
	egen total_rain_1year_ago_`yearSurvey'_5 = rowtotal(`may') if DHSyear == `yearSurvey' & DHSmonth == 5
	egen total_rain_1year_ago_`yearSurvey'_6 = rowtotal(`jun') if DHSyear == `yearSurvey' & DHSmonth == 6
	egen total_rain_1year_ago_`yearSurvey'_7 = rowtotal(`jul') if DHSyear == `yearSurvey' & DHSmonth == 7
	egen total_rain_1year_ago_`yearSurvey'_8 = rowtotal(`aug') if DHSyear == `yearSurvey' & DHSmonth == 8
	egen total_rain_1year_ago_`yearSurvey'_9 = rowtotal(`sep') if DHSyear == `yearSurvey' & DHSmonth == 9
	egen total_rain_1year_ago_`yearSurvey'_10 = rowtotal(`oct') if DHSyear == `yearSurvey' & DHSmonth == 10
	egen total_rain_1year_ago_`yearSurvey'_11 = rowtotal(`nov') if DHSyear == `yearSurvey' & DHSmonth == 11
	egen total_rain_1year_ago_`yearSurvey'_12 = rowtotal(`dec') if DHSyear == `yearSurvey' & DHSmonth == 12	
}

forvalues yearSurvey = 1999/2014 {
	forvalues monthSurvey = 1/12 {
		** combine all variables
		replace total_rain_1year_ago = total_rain_1year_ago_`yearSurvey'_`monthSurvey' if DHSyear == `yearSurvey' & DHSmonth == `monthSurvey'
		drop total_rain_1year_ago_`yearSurvey'_`monthSurvey'
	}
}




* -------------------------------------------------------
* (1-3) 2-3 Years before the Survey ---------------------

forvalues yearSurvey = 1999/2014 {
	local yearLag2 = `yearSurvey' - 2
	local yearLag3 = `yearSurvey' - 3
	
	** Define the period of rainfall (during the past 12 months prior to the survey)
	unab jan: p`yearLag2'_1 p`yearLag3'_12 p`yearLag3'_11 p`yearLag3'_10 p`yearLag3'_9 p`yearLag3'_8 ///
	          p`yearLag3'_7 p`yearLag3'_6 p`yearLag3'_5 p`yearLag3'_4 p`yearLag3'_3 p`yearLag3'_2
	
	unab feb: p`yearLag2'_2 p`yearLag2'_1 p`yearLag3'_12 p`yearLag3'_11 p`yearLag3'_10 p`yearLag3'_9 ///
	          p`yearLag3'_8 p`yearLag3'_7 p`yearLag3'_6 p`yearLag3'_5 p`yearLag3'_4 p`yearLag3'_3
	
	unab mar: p`yearLag2'_3 p`yearLag2'_2 p`yearLag2'_1 p`yearLag3'_12 p`yearLag3'_11 p`yearLag3'_10 ///
	          p`yearLag3'_9 p`yearLag3'_8 p`yearLag3'_7 p`yearLag3'_6 p`yearLag3'_5 p`yearLag3'_4 
	
	unab apr: p`yearLag2'_4 p`yearLag2'_3 p`yearLag2'_2 p`yearLag2'_1 p`yearLag3'_12 p`yearLag3'_11 ///
	          p`yearLag3'_10 p`yearLag3'_9 p`yearLag3'_8 p`yearLag3'_7 p`yearLag3'_6 p`yearLag3'_5
			  
	unab may: p`yearLag2'_5 p`yearLag2'_4 p`yearLag2'_3 p`yearLag2'_2 p`yearLag2'_1 p`yearLag3'_12 ///
	          p`yearLag3'_11 p`yearLag3'_10 p`yearLag3'_9 p`yearLag3'_8 p`yearLag3'_7 p`yearLag3'_6
	
	unab jun: p`yearLag2'_6 p`yearLag2'_5 p`yearLag2'_4 p`yearLag2'_3 p`yearLag2'_2 p`yearLag2'_1 ///
	          p`yearLag3'_12 p`yearLag3'_11 p`yearLag3'_10 p`yearLag3'_9 p`yearLag3'_8 p`yearLag3'_7
	
	unab jul: p`yearLag2'_7 p`yearLag2'_6 p`yearLag2'_5 p`yearLag2'_4 p`yearLag2'_3 p`yearLag2'_2 ///
	          p`yearLag2'_1 p`yearLag3'_12 p`yearLag3'_11 p`yearLag3'_10 p`yearLag3'_9 p`yearLag3'_8
	
	unab aug: p`yearLag2'_8 p`yearLag2'_7 p`yearLag2'_6 p`yearLag2'_5 p`yearLag2'_4 p`yearLag2'_3 ///
	          p`yearLag2'_2 p`yearLag2'_1 p`yearLag3'_12 p`yearLag3'_11 p`yearLag3'_10 p`yearLag3'_9
	
	unab sep: p`yearLag2'_9 p`yearLag2'_8 p`yearLag2'_7 p`yearLag2'_6 p`yearLag2'_5 p`yearLag2'_4 ///
	          p`yearLag2'_3 p`yearLag2'_2 p`yearLag2'_1 p`yearLag3'_12 p`yearLag3'_11 p`yearLag3'_10 
			  
	unab oct: p`yearLag2'_10 p`yearLag2'_9 p`yearLag2'_8 p`yearLag2'_7 p`yearLag2'_6 p`yearLag2'_5 ///
	          p`yearLag2'_4 p`yearLag2'_3 p`yearLag2'_2 p`yearLag2'_1 p`yearLag3'_12 p`yearLag3'_11
	
	unab nov: p`yearLag2'_11 p`yearLag2'_10 p`yearLag2'_9 p`yearLag2'_8 p`yearLag2'_7 p`yearLag2'_6 ///
	          p`yearLag2'_5 p`yearLag2'_4 p`yearLag2'_3 p`yearLag2'_2 p`yearLag2'_1 p`yearLag3'_12
	
	unab dec: p`yearLag2'_12 p`yearLag2'_11 p`yearLag2'_10 p`yearLag2'_9 p`yearLag2'_8 p`yearLag2'_7 ///
	          p`yearLag2'_6 p`yearLag2'_5 p`yearLag2'_4 p`yearLag2'_3 p`yearLag2'_2 p`yearLag2'_1
			  
	** Calculate the total amount of ranifall
	egen total_rain_2year_ago_`yearSurvey'_1 = rowtotal(`jan') if DHSyear == `yearSurvey' & DHSmonth == 1
	egen total_rain_2year_ago_`yearSurvey'_2 = rowtotal(`feb') if DHSyear == `yearSurvey' & DHSmonth == 2
	egen total_rain_2year_ago_`yearSurvey'_3 = rowtotal(`mar') if DHSyear == `yearSurvey' & DHSmonth == 3
	egen total_rain_2year_ago_`yearSurvey'_4 = rowtotal(`apr') if DHSyear == `yearSurvey' & DHSmonth == 4
	egen total_rain_2year_ago_`yearSurvey'_5 = rowtotal(`may') if DHSyear == `yearSurvey' & DHSmonth == 5
	egen total_rain_2year_ago_`yearSurvey'_6 = rowtotal(`jun') if DHSyear == `yearSurvey' & DHSmonth == 6
	egen total_rain_2year_ago_`yearSurvey'_7 = rowtotal(`jul') if DHSyear == `yearSurvey' & DHSmonth == 7
	egen total_rain_2year_ago_`yearSurvey'_8 = rowtotal(`aug') if DHSyear == `yearSurvey' & DHSmonth == 8
	egen total_rain_2year_ago_`yearSurvey'_9 = rowtotal(`sep') if DHSyear == `yearSurvey' & DHSmonth == 9
	egen total_rain_2year_ago_`yearSurvey'_10 = rowtotal(`oct') if DHSyear == `yearSurvey' & DHSmonth == 10
	egen total_rain_2year_ago_`yearSurvey'_11 = rowtotal(`nov') if DHSyear == `yearSurvey' & DHSmonth == 11
	egen total_rain_2year_ago_`yearSurvey'_12 = rowtotal(`dec') if DHSyear == `yearSurvey' & DHSmonth == 12		
}

forvalues yearSurvey = 1999/2014 {
	forvalues monthSurvey = 1/12 {
		** combine all variables
		replace total_rain_2year_ago = total_rain_2year_ago_`yearSurvey'_`monthSurvey' if DHSyear == `yearSurvey' & DHSmonth == `monthSurvey'
		drop total_rain_2year_ago_`yearSurvey'_`monthSurvey'
	}
}


* -------------------------------------------------------
* Replace as . for obs with missing weather variables ---

forvalues i = 0/2{
	replace total_rain_`i'year_ago = . if p2000_1 == .
}




* -------------------------------------------------------
* (2-1) During Pregnancy (9 months prior to the birth month)

* Make Empty Trimester Variables ------------------------

forvalues i = 1/3 {
	gen rain_total_tr`i' = .
}


* Trimester (months within the birth year) --------------

forvalues yearBirth = 1994/2014 {
	* Make 3rd Trimester: for observations with birth_month = 3-12
	forvalues monthRain = 3/12 {
		local monthLag1 = `monthRain'
		local monthLag2 = `monthRain' - 1
		local monthLag3 = `monthRain' - 2
		* dis "Birth Month = `monthLag1'"
		* dis "Birth Month - 1 = `monthLag2'"
		* dis "Birth Month - 2 = `monthLag3'"
		replace rain_total_tr3 = p`yearBirth'_`monthLag1' + p`yearBirth'_`monthLag2' + p`yearBirth'_`monthLag3' if birth_year == `yearBirth' & birth_month == `monthRain'
		replace rain_total_tr3 = p`yearBirth'_`monthLag1' + p`yearBirth'_`monthLag2' + p`yearBirth'_`monthLag3' if birth_year == `yearBirth' & birth_month == `monthRain'
	}
		
	* Make 2nd Trimester: for observations with birth_month = 6-12
	forvalues monthRain = 6/12 {
		local monthLag1 = `monthRain' - 3
		local monthLag2 = `monthRain' - 4
		local monthLag3 = `monthRain' - 5
		replace rain_total_tr2 = p`yearBirth'_`monthLag1' + p`yearBirth'_`monthLag2' + p`yearBirth'_`monthLag3' if birth_year == `yearBirth' & birth_month == `monthRain'
		replace rain_total_tr2 = p`yearBirth'_`monthLag1' + p`yearBirth'_`monthLag2' + p`yearBirth'_`monthLag3' if birth_year == `yearBirth' & birth_month == `monthRain'
	}
	* Make 1st Trimester: for observations with birth_month = 9-12
	forvalues monthRain = 9/12 {
		local monthLag1 = `monthRain' - 6
		local monthLag2 = `monthRain' - 7
		local monthLag3 = `monthRain' - 8
		replace rain_total_tr1 = p`yearBirth'_`monthLag1' + p`yearBirth'_`monthLag2' + p`yearBirth'_`monthLag3' if birth_year == `yearBirth' & birth_month == `monthRain'
		replace rain_total_tr1 = p`yearBirth'_`monthLag1' + p`yearBirth'_`monthLag2' + p`yearBirth'_`monthLag3' if birth_year == `yearBirth' & birth_month == `monthRain'
	}
}



* Trimester (months within and 1 year before the birth year) 

forvalues yearBirth = 1994/2014 {
	local yearLag = `yearBirth' - 1
	
	* Make 3rd Trimester: for observations with birth_month = 1-2
	replace rain_total_tr3 = p`yearBirth'_2 + p`yearBirth'_1 + p`yearLag'_12 if birth_year == `yearBirth' & birth_month == 2 
	replace rain_total_tr3 = p`yearBirth'_1 + p`yearLag'_12 + p`yearLag'_11 if birth_year == `yearBirth' & birth_month == 1
		
	* Make 2nd Trimester: for observations with birth_month = 1-5
	replace rain_total_tr2 = p`yearBirth'_2 + p`yearBirth'_1 + p`yearLag'_12 if birth_year == `yearBirth' & birth_month == 5
	replace rain_total_tr2 = p`yearBirth'_1 + p`yearLag'_12 + p`yearLag'_11 if birth_year == `yearBirth' & birth_month == 4
	replace rain_total_tr2 = p`yearLag'_12 + p`yearLag'_11 + p`yearLag'_10 if birth_year == `yearBirth' & birth_month == 3
	replace rain_total_tr2 = p`yearLag'_11 + p`yearLag'_10 + p`yearLag'_9 if birth_year == `yearBirth' & birth_month == 2
	replace rain_total_tr2 = p`yearLag'_10 + p`yearLag'_9 + p`yearLag'_8 if birth_year == `yearBirth' & birth_month == 1
	
	* Make 1st Trimester: for observations with birth_month = 1-8 (except for those born in 2000) (months 1-6 use previous year only)
	replace rain_total_tr1 = p`yearBirth'_2 + p`yearBirth'_1 + p`yearLag'_12 if birth_year == `yearBirth' & birth_month == 8
	replace rain_total_tr1 = p`yearBirth'_1 + p`yearLag'_12 + p`yearLag'_11  if birth_year == `yearBirth' & birth_month == 7
	replace rain_total_tr1 = p`yearLag'_12 + p`yearLag'_11 + p`yearLag'_10 if birth_year == `yearBirth' & birth_month == 6
	replace rain_total_tr1 = p`yearLag'_11 + p`yearLag'_10 + p`yearLag'_9 if birth_year == `yearBirth' & birth_month == 5
	replace rain_total_tr1 = p`yearLag'_10 + p`yearLag'_9 + p`yearLag'_8 if birth_year == `yearBirth' & birth_month == 4
	replace rain_total_tr1 = p`yearLag'_9 + p`yearLag'_8 + p`yearLag'_7 if birth_year == `yearBirth' & birth_month == 3
	replace rain_total_tr1 = p`yearLag'_8 + p`yearLag'_7 + p`yearLag'_6 if birth_year == `yearBirth' & birth_month == 2
	replace rain_total_tr1 = p`yearLag'_7 + p`yearLag'_6 + p`yearLag'_5 if birth_year == `yearBirth' & birth_month == 1	
}


gen rain_total_preg = rain_total_tr1 + rain_total_tr2 + rain_total_tr3

* -------------------------------------------------------
* Replace as . for obs with missing weather variables ---

forvalues i = 1/3{
	replace rain_total_tr`i' = . if p2000_1 == .
}




* -------------------------------------------------------
* (3-1) Percentage Deviation from Mean Rainfall ---------

gen ln_rain_0year_ago = ln(total_rain_0year_ago)
gen ln_rain_1year_ago = ln(total_rain_1year_ago)
gen ln_rain_2year_ago = ln(total_rain_2year_ago)

gen ln_rain_a = ln(rainfall_a)   // log of historical annual mean rainfall (Average annual rainfal from 1950-2000)

gen ln_rain_0year_dev = ln_rain_0year_ago - ln_rain_a
gen ln_rain_1year_dev = ln_rain_1year_ago - ln_rain_a
gen ln_rain_2year_dev = ln_rain_2year_ago - ln_rain_a

* corr ln_rain_0year_dev ln_rain_1year_dev ln_rain_2year_dev
* corr rain_0year_ext rain_1year_ext rain_2year_ext




* -------------------------------------------------------
* (3-2) Extreme Rainfall --------------------------------

centile ln_rain_0year_dev, centile(20)   // -.1002698
centile ln_rain_0year_dev, centile(80)   // .2522377

centile ln_rain_1year_dev, centile(20)   // -.0974036
centile ln_rain_1year_dev, centile(80)   // .2282133

centile ln_rain_2year_dev, centile(20)   // -.1667604
centile ln_rain_2year_dev, centile(80)   // .1111898

centile ln_rain_0year_dev, centile(90)   // .3471732
centile ln_rain_1year_dev, centile(90)   // .3197889
centile ln_rain_2year_dev, centile(90)   // .2209377 

* Above 80 percentile
gen rain_0year_ext80 = 1 if ln_rain_0year_dev > 0.2522377
replace rain_0year_ext80 = 0 if rain_0year_ext80 == .

gen rain_1year_ext80 = 1 if ln_rain_1year_dev > 0.2282133
replace rain_1year_ext80 = 0 if rain_1year_ext80 == .

gen rain_2year_ext80 = 1 if ln_rain_1year_dev > 0.1111898
replace rain_2year_ext80 = 0 if rain_2year_ext80 == .

* Above 90 percentile
gen rain_0year_ext90 = 1 if ln_rain_0year_dev > 0.3471732
replace rain_0year_ext90 = 0 if rain_0year_ext90 == .

gen rain_1year_ext90 = 1 if ln_rain_1year_dev > 0.3197889
replace rain_1year_ext90 = 0 if rain_1year_ext90 == .

gen rain_2year_ext90 = 1 if ln_rain_1year_dev > 0.2209377
replace rain_2year_ext90 = 0 if rain_2year_ext90 == .




* -------------------------------------------------------
* (3-3) Percentage Deviation from Mean Rainfall (Summer). Period: March to May

* Monthly Mean Rainfall from 1980-2000
forvalues monthRain = 1/12 {
	
	unab month: p1980_`monthRain' p1981_`monthRain' p1982_`monthRain' p1983_`monthRain' p1984_`monthRain' ///
				p1985_`monthRain' p1986_`monthRain' p1987_`monthRain' p1988_`monthRain' p1989_`monthRain' ///
				p1990_`monthRain' p1991_`monthRain' p1992_`monthRain' p1993_`monthRain' p1994_`monthRain' ///
				p1995_`monthRain' p1996_`monthRain' p1997_`monthRain' p1998_`monthRain' p1999_`monthRain' p2000_`monthRain' ///
				
	** Calculate the monthly total ranifall during the rainy season
	dis "Target year-months are `month'"
	egen rain_month_mean_`monthRain' = rowmean(`month') 
}

gen rain_longmean_summer_3_5 = rain_month_mean_3 + rain_month_mean_4 + rain_month_mean_5
replace rain_longmean_summer_3_5 = . if rain_longmean_summer_3_5 == 0

gen rain_summer_3_5 = .

forvalues yearSurvey = 1999/2014 {
	local yearLag = `yearSurvey' - 1
	
	unab month: p`yearLag'_3 p`yearLag'_4 p`yearLag'_5
	
	dis "Use: `month' if DHSyear == `yearSurvey'"
	** Calculate the total amount of ranifall during the last completed summer (for each survey year)
	replace rain_summer_3_5 = p`yearLag'_3 + p`yearLag'_4 + p`yearLag'_5 if DHSyear == `yearSurvey'
}

* mdesc rain_summer_3_5

gen ln_rain_summer_3_5 = ln(rain_summer_3_5)
gen ln_rain_longmean_summer_3_5 = ln(rain_longmean_summer_3_5)

gen ln_rain_last_summer_dev = ln_rain_summer_3_5 - ln_rain_longmean_summer_3_5  // long-run deviation in rainfall during the last completed summer

* su rain_summer_3_5 rain_longmean_summer_3_5 ln_rain_summer_3_5 ln_rain_longmean_summer_3_5 ln_rain_last_summer_dev




* -------------------------------------------------------
* (3-4) Percentage Deviation from Mean Rainfall (Rainy Season). Period: June to September

* Monthly Mean Rainfall from 1980-2000
gen rain_longmean_rainy_season_6_9 = rain_month_mean_6 + rain_month_mean_7 + rain_month_mean_8 + rain_month_mean_9
replace rain_longmean_rainy_season_6_9 = . if rain_longmean_rainy_season_6_9 == 0

/*
* Confirmation
gen jan = p1980_1 + p1981_1 + p1982_1 + p1983_1 + p1984_1 + p1985_1 + p1986_1 + p1987_1 + p1988_1 + p1989_1 + p1990_1 + p1991_1 + p1992_1 + p1993_1 + p1994_1 + p1995_1 + p1996_1 + p1997_1 + p1998_1 + p1999_1 + p2000_1

gen feb = p1980_2 + p1981_2 + p1982_2 + p1983_2 + p1984_2 + p1985_2 + p1986_2 + p1987_2 + p1988_2 + p1989_2 + p1990_2 + p1991_2 + p1992_2 + p1993_2 + p1994_2 + p1995_2 + p1996_2 + p1997_2 + p1998_2 + p1999_2 + p2000_2

gen janmean = jan / 21
gen febmean = feb / 21
*/

gen rain_rainy_season_6_9 = .

forvalues yearSurvey = 1999/2014 {
	local yearLag = `yearSurvey' - 1
	
	unab month: p`yearLag'_6 p`yearLag'_7 p`yearLag'_8 p`yearLag'_9
	
	dis "Use: `month' if DHSyear == `yearSurvey'"
	** Calculate the total amount of ranifall during the last completed rainy season (for each survey year)
	replace rain_rainy_season_6_9 = p`yearLag'_6 + p`yearLag'_7 + p`yearLag'_8 + p`yearLag'_9 if DHSyear == `yearSurvey'
}

* mdesc rain_rainy_season_6_9

gen ln_rain_rainy_season_6_9 = ln(rain_rainy_season_6_9)
gen ln_rain_longm_rainy_season_6_9 = ln(rain_longmean_rainy_season_6_9)

gen ln_rain_last_rainy_season_dev = ln_rain_rainy_season_6_9 - ln_rain_longm_rainy_season_6_9  // long-run deviation in rainfall during the last completed rainy season

* su rain_rainy_season_6_9 rain_longmean_rainy_season_6_9 ln_rain_rainy_season_6_9 ln_rain_longm_rainy_season_6_9 ln_rain_last_rainy_season_dev




* -------------------------------------------------------
* (3-5) Percentage Deviation from Mean Rainfall (Autumn). Period: October to November

* Monthly Mean Rainfall from 1980-2000
gen rain_longmean_autumn_10_11 = rain_month_mean_10 + rain_month_mean_11
replace rain_longmean_autumn_10_11 = . if rain_longmean_autumn_10_11 == 0

/*
forvalues monthRain = 1/12 {
	** Drop
	dis "Drop: rain_month_mean_`monthRain'"
	drop rain_month_mean_`monthRain'
}
*/

gen rain_autumn_10_11 = .

forvalues yearSurvey = 1999/2014 {
	local yearLag = `yearSurvey' - 1
	
	unab month: p`yearLag'_10 p`yearLag'_11
	
	dis "Use: `month' if DHSyear == `yearSurvey'"
	** Calculate the total amount of ranifall during the last completed autumn (for each survey year)
	replace rain_autumn_10_11 = p`yearLag'_10 + p`yearLag'_11 if DHSyear == `yearSurvey'
}

gen ln_rain_autumn_10_11 = ln(rain_autumn_10_11)
gen ln_rain_longmean_autumn_10_11 = ln(rain_longmean_autumn_10_11)

gen ln_rain_last_autumn_dev = ln_rain_autumn_10_11 - ln_rain_longmean_autumn_10_11  // long-run deviation in rainfall during the last completed autumn

* su rain_longmean_autumn_10_11 rain_autumn_10_11 ln_rain_autumn_10_11 ln_rain_longmean_autumn_10_11 ln_rain_last_autumn_dev

