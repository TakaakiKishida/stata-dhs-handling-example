/*

	Read the Main Dataset Created by `src/data_management/0_5_make_main.do`

*/


* Setup -------------------------------------------------

** Fixed throughout the do-file
global projectFolder "~/Dropbox/Agri_Food_DHS"
global dataFolder "${projectFolder}/out/data/analysis"



* Read Data ---------------------------------------------

use "${dataFolder}/main_dataset_raw.dta", clear
