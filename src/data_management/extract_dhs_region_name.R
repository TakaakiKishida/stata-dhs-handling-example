# Packages ----------------------------------------------------------------

pacman::p_load(tidyverse, sf)



# Read Data ---------------------------------------------------------------

# DHS survey cluster
df <- readr::read_csv("~/Dropbox/Agri_Food_DHS/data-raw/AReNA_DHS/csv/003_DHS_main.csv")
# BD 2017-18
shp_bd18 <- sf::read_sf("~/Dropbox/Agri_Food_DHS/data-raw/Original_DHS/Bangladesh/BD_2017-18_DHS/BDGE7SFL/BDGE7SFL.shp")

# Bangladesh
shp_bgd_2 <- sf::read_sf("~/Dropbox/Agri_Food_DHS/data-raw/administrative_boundary/gadm36_BGD_shp/gadm36_BGD_2.shp")
shp_bgd_3 <- sf::read_sf("~/Dropbox/Agri_Food_DHS/data-raw/administrative_boundary/gadm36_BGD_shp/gadm36_BGD_3.shp")
# Cambodia
shp_khm_2 <- sf::read_sf("~/Dropbox/Agri_Food_DHS/data-raw/administrative_boundary/gadm36_KHM_shp/gadm36_KHM_2.shp")
shp_khm_3 <- sf::read_sf("~/Dropbox/Agri_Food_DHS/data-raw/administrative_boundary/gadm36_KHM_shp/gadm36_KHM_3.shp")
# Nepal
shp_npl_2 <- sf::read_sf("~//Dropbox/Agri_Food_DHS/data-raw/administrative_boundary/gadm36_NPL_shp/gadm36_NPL_2.shp")
shp_npl_3 <- sf::read_sf("~//Dropbox/Agri_Food_DHS/data-raw/administrative_boundary/gadm36_NPL_shp/gadm36_NPL_3.shp")



# Subset ------------------------------------------------------------------
# filter target countries, remove missing clusters in lon and lat vars, and define/set geographic CRS (投影法)

# Reference: https://epsg.io/3106
## Bangladesh (3 clusters with missing in longitude and latitude) ----
# -> need to check which years are missing
df %>% dplyr::filter(country == "Bangladesh") %>% count(is.na(longnum)) 
df %>% dplyr::filter(country == "Bangladesh") %>% count(is.na(latnum))

sf_bgd <- df %>% 
  dplyr::filter(country == "Bangladesh",
                longnum != "NA") %>% 
  sf::st_as_sf(coords = c("longnum", "latnum")) %>% 
  sf::st_set_crs(sf::st_crs(shp_bgd_2))

# class(df)
# class(sf_bgd)
# sf::st_crs(shp_bgd_2)
# sf::st_crs(df)
# sf::st_crs(sf_bgd)


## Cambodia (14 clusters with missing in longitude and latitude) ----
df %>% dplyr::filter(country == "Cambodia") %>% count(is.na(longnum)) 
df %>% dplyr::filter(country == "Cambodia") %>% count(is.na(latnum))

sf_khm <- df %>% 
  dplyr::filter(country == "Cambodia",
                longnum != "NA") %>% 
  sf::st_as_sf(coords = c("longnum", "latnum")) %>% 
  sf::st_set_crs(sf::st_crs(shp_khm_2))
# sf::st_crs(shp_khm_2)
# sf::st_crs(sf_khm)


## Nepal (xyz clusters with missing in longitude and latitude) ----
sf_npl <- df %>% 
  dplyr::filter(country == "Nepal",
                longnum != "NA") %>% 
  sf::st_as_sf(coords = c("longnum", "latnum")) %>% 
  sf::st_set_crs(sf::st_crs(shp_npl_2))
# sf::st_crs(shp_npl_2)
# sf::st_crs(sf_npl)



# Extract/Give a Name of Administrative Division --------------------------
# Add the attribute of administrative divisions' polygon that includes each DHS cluster point to the point data

# shp_bgd_2 %>% glimpse()
# sf_bgd %>% glimpse()
# sf_bgd_names %>% glimpse()

## Bangladesh: Level 2 and 3 ----
sf_bgd_names <- sf::st_join(x = sf_bgd, y = shp_bgd_2, join = st_intersects)
sf_bgd_names <- sf::st_join(x = sf_bgd_names, y = shp_bgd_3, join = st_intersects)

shp_bd18_names <- sf::st_join(x = shp_bd18, y = shp_bgd_2, join = st_intersects)
shp_bd18_names <- sf::st_join(x = shp_bd18, y = shp_bgd_3, join = st_intersects)

## Cambodia: Level 2 and 3 ----
sf_khm_names <- sf::st_join(x = sf_khm, y = shp_khm_2, join = st_intersects)
sf_khm_names <- sf::st_join(x = sf_khm_names, y = shp_khm_3, join = st_intersects)

## Nepal: Level 2 and 3 ----
sf_npl_names <- sf::st_join(x = sf_npl, y = shp_npl_2, join = st_intersects)
sf_npl_names <- sf::st_join(x = sf_npl_names, y = shp_npl_3, join = st_intersects)



# Rename & Drop -----------------------------------------------------------

# better to merge 3 countries' data and export in one file? -> consider later
# rename some variables and drop unnecessary variables

# identical(names(sf_bgd_names), names(sf_khm_names))
# identical(names(sf_bgd_names), names(sf_npl_names))

dropvars <- c("GID_0.x", "NAME_0.x", "GID_1.x", "NL_NAME_1.x", "GID_2.x", "VARNAME_2", "NL_NAME_2.x", 
              "HASC_2", "GID_0.y", "NAME_0.y", "GID_1.y", "NAME_1.y", "NL_NAME_1.y", 
              "GID_2.y", "NAME_2.y", "NL_NAME_2.y", "GID_3", "VARNAME_3", "NL_NAME_3", "HASC_3")

# Function that renames variables and removes unwanted variables
rename_drop <- function(df) {
  df %>% 
    dplyr::rename(REGION_NAME_1 = NAME_1.x,
                REGION_NAME_2 = NAME_2.x,
                REGION_TYPE_2 = TYPE_2,
                REGION_TYPE_2_EN = ENGTYPE_2,
                REGION_NAME_3 = NAME_3,
                REGION_TYPE_3 = TYPE_3,
                REGION_TYPE_3_EN = ENGTYPE_3) %>% 
    dplyr::select(-dropvars)
}

# make a list of dataframes and execute in a loop?
sf_bgd_names <- rename_drop(sf_bgd_names) # Bangladesh
sf_khm_names <- rename_drop(sf_khm_names) # Cambodia
sf_npl_names <- rename_drop(sf_npl_names) # Nepal


## Extract 2017-18 only ----
name_list <- sf_bgd_names %>% names()

df_bd18 <- shp_bd18_names %>%
  # sf::st_set_geometry(value = NULL)
  dplyr::mutate(geom = sf::st_as_text(sf::st_geometry(.)))

df_bd18 <- df_bd18 %>% 
  mutate(country = "Bangladesh",
         # v001 = NA,
         dhsyear = 2018,
         REGION_TYPE_2 = "Zila",
         REGION_TYPE_2_EN = "Distict"
         # REGION_NAME_2 = NA,
         ) %>% 
  select(-SOURCE, -geom, -GID_1, -NL_NAME_2, -HASC_3, -VARNAME_3) %>% 
  rename(country_code = DHSCC,
         v001 = DHSCLUST,
         end_year = DHSYEAR,
         dhsid = DHSID,
         dhsregco = DHSREGCO,
         dhsregna = DHSREGNA,
         REGION_NAME_1 = NAME_1,
         REGION_NAME_2 = NAME_2, 
         REGION_NAME_3 = NAME_3,
         REGION_TYPE_3 = TYPE_3,
         REGION_TYPE_3_EN = ENGTYPE_3
         )

df_bd18 %>% glimpse()
sf_bgd_names %>% glimpse()

# bind_rows(sf_bgd_names, df_bd18) %>% 
#   count(end_year, REGION_NAME_1) %>% 
#   # count(end_year, REGION_NAME_2) %>% 
#   view()

sf_bgd_names_all <- 
  bind_rows(sf_bgd_names, df_bd18) %>% 
  select(-ALT_GPS,
         -c(alt, gmia_ha, lgp, popden_rur, popden_ur, slope, tree),
         -CCFIPS:-NL_NAME_3)
# sf_bgd_names_all %>%
#   # count(end_year, REGION_NAME_2) %>%
#   count(end_year, v001) %>%
#   view()
sf_bgd_names_all %>% view()  


# Export ------------------------------------------------------------------

path_d <- "~/Dropbox/Agri_Food_DHS/out/data/administrative_division"

# Bangladesh
path2csv = file.path(path_d, "name_bangladesh.csv") 
readr::write_csv(sf_bgd_names_all, file = path2csv)

# Cambodia
path2csv = file.path(path_d, "name_cambodia.csv") 
readr::write_csv(sf_khm_names, path = path2csv)

# Nepal
path2csv = file.path(path_d, "name_nepal.csv") 
readr::write_csv(sf_npl_names, path = path2csv)

