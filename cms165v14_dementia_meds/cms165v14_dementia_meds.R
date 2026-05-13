

# Libraries ---------------------------------------------------------------

library(tidyverse)
library(openxlsx)
library(readr)
library(janitor)
library(rxref)

# Raw data ----------------------------------------------------------------

# Dementia med list downloaded from CMS165v14 specification value set
# dmeds <- read.xlsx("/Users/ssmithm/Downloads/DementiaMeds1.xlsx")       # MBP
dmeds <- read.xlsx("/Users/stevensmith/Downloads/DementiaMeds1.xlsx")   # iMac
dmeds <- read.xlsx("C:\\Users\\ssmithm\\UFL Dropbox\\Steven Smith\\R Projects\\rxref_code_lists\\cms165v14_dementia_meds\\SOURCE_DementiaMeds1.xlsx")   # Office desktop



# Analysis ----------------------------------------------------------------

# get ingredient RxCUIs
ings <- ingredients_for_rxcui(dmeds$Code)

# get all prescribable products for ingredients
products <- products_for_ingredients(
  unique(ings$ingredient_rxcui),
  include_combos = TRUE
)

# products |> get_dupes(product_rxcui)

# map RxCUIs to NDC numbers
dem.ndc.map <- map_rxcui_to_ndc(unique(products$product_rxcui))

# recombine with ingredient RxCUI and name (corresponding TTY='IN' or 'PIN')
dem_ndcs <- dem.ndc.map |>
  dplyr::left_join(products, by = c("rxcui" = "product_rxcui"), relationship = "many-to-many") |>
  dplyr::distinct(rxcui, ingredient_rxcui, ndc11, name, tty) |>
  dplyr::arrange(ingredient_rxcui, rxcui, ndc11, name)

dem.ndcs <- dplyr::left_join(
  x = dem_ndcs,
  y = ings |> dplyr::select(ingredient_rxcui, ingredient_name) |> unique(),
  by = "ingredient_rxcui",
  relationship = "many-to-many"
)

# export
write_csv(dem.ndcs, "C:\\Users\\ssmithm\\UFL Dropbox\\Steven Smith\\R Projects\\rxref_code_lists\\cms165v14_dementia_meds\\OUTPUT-dementia_meds_04.27.2026.csv")

