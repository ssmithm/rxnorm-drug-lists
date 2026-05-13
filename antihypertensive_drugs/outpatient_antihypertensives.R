library(tidyverse)
library(rxref)
library(steveR)

# Antihypertensives and classes -------------------------------------------

# edit/add/remove drugs as needed for use case

antihypertensives <- tribble(
  ~class, ~drug,

  # Thiazide and thiazide-like diuretics
  "THIAZIDE_DIURETIC", "bendroflumethiazide",
  "THIAZIDE_DIURETIC", "chlorothiazide",
  "THIAZIDE_DIURETIC", "chlorthalidone",
  "THIAZIDE_DIURETIC", "hydrochlorothiazide",
  "THIAZIDE_DIURETIC", "indapamide",
  "THIAZIDE_DIURETIC", "methyclothiazide",
  "THIAZIDE_DIURETIC", "metolazone",
  "THIAZIDE_DIURETIC", "polythiazide",
  "THIAZIDE_DIURETIC", "trichlormethiazide",

  # LOOP_DIURETICs
  "LOOP_DIURETIC", "bumetanide",
  "LOOP_DIURETIC", "ethacrynate",   # ethacrynic acid
  "LOOP_DIURETIC", "furosemide",
  "LOOP_DIURETIC", "torsemide",

  # Potassium-sparing diuretics: ENaC blockers
  "K_SPARING_DIURETIC", "amiloride",
  "K_SPARING_DIURETIC", "triamterene",

  # Aldosterone Antagonists
  "ALDO_ANTAGONIST", "eplerenone",
  "ALDO_ANTAGONIST", "spironolactone",

  # ACE inhibitors
  "ACEI", "benazepril",
  "ACEI", "captopril",
  "ACEI", "enalapril",
  "ACEI", "fosinopril",
  "ACEI", "lisinopril",
  "ACEI", "moexipril",
  "ACEI", "perindopril",
  "ACEI", "quinapril",
  "ACEI", "ramipril",
  "ACEI", "trandolapril",

  # Angiotensin II receptor blockers
  "ARB", "azilsartan",
  "ARB", "candesartan",
  "ARB", "irbesartan",
  "ARB", "losartan",
  "ARB", "olmesartan",
  "ARB", "telmisartan",
  "ARB", "valsartan",
  "ARB", "eprosartan",

  # Direct renin inhibitor
  "DRI", "aliskiren",

  # Endothelin receptor antagonist
  "ERA", "aprocitentan",

  # Dihydropyridine calcium-channel blockers
  "DHP_CCB", "amlodipine",
  "DHP_CCB", "felodipine",
  "DHP_CCB", "isradipine",
  "DHP_CCB", "nicardipine",
  "DHP_CCB", "nifedipine",
  "DHP_CCB", "nisoldipine",
  "DHP_CCB", "levamlodipine",

  # Non-dihydropyridine calcium-channel blockers
  "NONDHP_CCB", "diltiazem",
  "NONDHP_CCB", "verapamil",

  # Beta-blockers
  "BB", "acebutolol",
  "BB", "atenolol",
  "BB", "betaxolol",
  "BB", "bisoprolol",
  "BB", "carvedilol",
  "BB", "labetalol",
  "BB", "metoprolol",
  "BB", "nadolol",
  "BB", "nebivolol",
  "BB", "penbutolol",
  "BB", "pindolol",
  "BB", "propranolol",
  "BB", "timolol",

  # Alpha-1 blockers
  "ALPHA1_BLOCKER", "doxazosin",
  "ALPHA1_BLOCKER", "prazosin",
  "ALPHA1_BLOCKER", "terazosin",

  # Central alpha-2 agonists / central sympatholytics
  "ALPHA2_AGONIST", "clonidine",
  "ALPHA2_AGONIST", "guanabenz",
  "ALPHA2_AGONIST", "guanfacine",
  "ALPHA2_AGONIST", "methyldopa",

  # Peripheral adrenergic neuron blockers / older antiadrenergic agents
  "OTHER_ANTIHYPERTENSIVE", "guanadrel",
  "OTHER_ANTIHYPERTENSIVE", "guanethidine",
  "OTHER_ANTIHYPERTENSIVE", "reserpine",

  # Direct arterial vasodilators
  "VASODILATOR", "hydralazine",
  "VASODILATOR", "minoxidil"
)



# rxref pipeline ----------------------------------------------------------

# 1. Get ingredients from list of drug names
# 2. Get products from ingredients
# 3. Get clinical attributes of products (esp. route of admin)
# 4. Filter to relevant routes (oral, transdermal clonidine)
# 5. Filter out handful of combination drugs we don't want (e.g., Entresto, BiDil, etc..)
# 6. Map to NDCs

# 1. Get ingredients
antihtn_ings <- find_ingredients(antihypertensives$drug) |>
  filter(tty == "IN") |>
  distinct(
    input,
    ingredient_rxcui = rxcui,
    ingredient_name = name
  )

# 2. Get products
antihtn_prods <-
  products_for_ingredients(
    antihtn_ings$ingredient_rxcui,
    ttys = product_ttys("extended_product"),
    include_combos = TRUE
  ) |>
  left_join(antihtn_ings, by = "ingredient_rxcui")

# 3. Get clinical attributes
#    (not strictly necessary, but gives a sense of various routes involved in
#     the particular use case)
# antihtn_attrs <- get_clinical_attributes(
#   unique(antihtn_prods$product_rxcui)
# )
#
# antihtn_attrs |> count(route, dose_form_group, sort = TRUE)


# 4. Filter to relevant routes

## transdermal clonidine
antihtn_topical_prods <- antihtn_prods |>
  filter_products_by_route(route = "TOPICAL")

antihtn_transdermal_prods <- antihtn_topical_prods |>
  filter(ingredient_name == "clonidine")

## oral products
antihtn_oral_prods <- antihtn_prods |>
  filter_products_by_route(route = "ORAL")

## recombine
antihtn_prods2 <- bind_rows(antihtn_transdermal_prods, antihtn_oral_prods)

# 5. Exclude unwanted drugs
# antihtn_prods2_name <- get_properties(antihtn_prods2$product_rxcui)
# antihtn_prods2_namer <- resolve(antihtn_prods2$product_rxcui, type = "rxcui")

antihtn_prods2_clin <- get_clinical_attributes(antihtn_prods2$product_rxcui)
antihtn_prods2_clin_ct <- antihtn_prods2_clin |> count(ingredient_name, sort = TRUE)

antihtn_prods2_clin_ded <- antihtn_prods2_clin |>
  select(rxcui, ingredient_rxcui, ingredient_name, is_multi_ingredient) |>
  unique()

antihtn_prods3_clin <- antihtn_prods2_clin_ded |>
  filter(
    !str_detect(
      str_to_lower(ingredient_name),
      "sacubitril; valsartan|hydralazine; isosorbide dinitrate"
    )
  )

antihtn_p3_rxcuis <- antihtn_prods3_clin |> select(rxcui)

antihtn_prods3 <-
  inner_join(
    antihtn_prods2,
    antihtn_p3_rxcuis,
    by = join_by(product_rxcui == rxcui)
    ) |>
  select(product_rxcui, name, tty, n_ingredients, ingredient_name, routes, dose_forms, dose_form_groups) |>
  rename(RXCUI = product_rxcui, STR = name, TTY = tty, n_drugs = n_ingredients) |>
  mutate(FDC = if_else(n_drugs > 1, 1L, 0L),
         ingredient_name = str_to_lower(ingredient_name)) |>
  arrange(RXCUI, ingredient_name)

# Variables needed:
# * RXCUI	                  ✓
# * STR	                    ✓
# * TTY	                    ✓
# * loop_diuretic
# * thiazide_diuretic
# * Ksparing_diuretic
# * ACE_inhibitor
# * ARB
# * aldo_antagonist
# * alpha_blocker
# * beta_blocker
# * calcium_channel_blocker
# * centrally_acting
# * renin_antagonist
# * vasodilator
# * ERA**
# * other
# * any_diuretic
# * FDC                     ✓

antihtn_rxcuis_new <-
  left_join(
    antihtn_prods3,
    antihypertensives,
    by = join_by(ingredient_name == drug)
  )

antihtn_rxcuis_new1 <- antihtn_rxcuis_new |>
  mutate(
    ERA = if_else(str_to_lower(class) == "era", 1L, 0L),
    vasodilator = if_else(str_to_lower(class) == "vasodilator", 1L, 0L),
    renin_antagonist = if_else(str_to_lower(class) == "dri", 1L, 0L),
    centrally_acting = if_else(str_to_lower(class) == "alpha2_agonist", 1L, 0L),
    calcium_channel_blocker = if_else(str_to_lower(class) %in% c("dhp_ccb", "nondhp_ccb"), 1L, 0L),
    beta_blocker = if_else(str_to_lower(class) == "bb", 1L, 0L),
    alpha_blocker = if_else(str_to_lower(class) == "alpha1_blocker", 1L, 0L),
    ARB = if_else(str_to_lower(class) == "arb", 1L, 0L),
    ACE_inhibitor = if_else(str_to_lower(class) == "acei", 1L, 0L),
    Ksparing_diuretic = if_else(str_to_lower(class) == "k_sparing_diuretic", 1L, 0L),
    thiazide_diuretic = if_else(str_to_lower(class) == "thiazide_diuretic", 1L, 0L),
    loop_diuretic = if_else(str_to_lower(class) == "loop_diuretic", 1L, 0L),
    aldo_antagonist = if_else(str_to_lower(class) == "aldo_antagonist", 1L, 0L),
    other = if_else(str_to_lower(class) == "other_antihypertensive", 1L, 0L),
    any_diuretic = if_else(str_to_lower(class) %in% c("loop_diuretic", "thiazide_diuretic", "k_sparing_diuretic"), 1L, 0L)
  ) |>
  select(RXCUI, STR, TTY, n_drugs, loop_diuretic, thiazide_diuretic,
         Ksparing_diuretic, ACE_inhibitor, ARB, aldo_antagonist, alpha_blocker,
         beta_blocker, calcium_channel_blocker, centrally_acting,
         renin_antagonist, vasodilator, other, any_diuretic, FDC)

class_vars <- c(
  "loop_diuretic",
  "thiazide_diuretic",
  "Ksparing_diuretic",
  "ACE_inhibitor",
  "ARB",
  "aldo_antagonist",
  "alpha_blocker",
  "beta_blocker",
  "calcium_channel_blocker",
  "centrally_acting",
  "renin_antagonist",
  "vasodilator",
  "other",
  "any_diuretic"
)

antihtn_rxcuis_new_collapsed <- antihtn_rxcuis_new1 |>
  group_by(RXCUI) |>
  summarise(
    STR = first(STR),
    TTY = first(TTY),
    n_drugs = max(n_drugs, na.rm = TRUE),
    across(
      all_of(class_vars),
      ~ as.integer(any(.x == 1, na.rm = TRUE))
    ),
    FDC = as.integer(any(FDC == 1, na.rm = TRUE)),
    .groups = "drop"
  )

## NDCs
ahp3_ndcs_direct <-
  map_rxcui_to_ndc(
    antihtn_rxcuis_new_collapsed$RXCUI,
    status = NULL,
    history = "direct")


antihtn_ndcs_new <-
  inner_join(
    ahp3_ndcs_direct,
    antihtn_rxcuis_new,
    by = join_by(rxcui == RXCUI),
    relationship = "many-to-many"
  )

# antihtn_ndcs_new <-
#   inner_join(
#     ahp3_ndcs_direct,
#     antihtn_rxcuis_new_collapsed,
#     by = join_by(rxcui == RXCUI)
#   )

antihtn_ndcs_new1 <- antihtn_ndcs_new |>
  mutate(
    ERA = if_else(str_to_lower(class) == "era", 1L, 0L),
    vasodilator = if_else(str_to_lower(class) == "vasodilator", 1L, 0L),
    renin_antagonist = if_else(str_to_lower(class) == "dri", 1L, 0L),
    centrally_acting = if_else(str_to_lower(class) == "alpha2_agonist", 1L, 0L),
    calcium_channel_blocker = if_else(str_to_lower(class) %in% c("dhp_ccb", "nondhp_ccb"), 1L, 0L),
    beta_blocker = if_else(str_to_lower(class) == "bb", 1L, 0L),
    alpha_blocker = if_else(str_to_lower(class) == "alpha1_blocker", 1L, 0L),
    ARB = if_else(str_to_lower(class) == "arb", 1L, 0L),
    ACE_inhibitor = if_else(str_to_lower(class) == "acei", 1L, 0L),
    Ksparing_diuretic = if_else(str_to_lower(class) == "k_sparing_diuretic", 1L, 0L),
    thiazide_diuretic = if_else(str_to_lower(class) == "thiazide_diuretic", 1L, 0L),
    loop_diuretic = if_else(str_to_lower(class) == "loop_diuretic", 1L, 0L),
    aldo_antagonist = if_else(str_to_lower(class) == "aldo_antagonist", 1L, 0L),
    other = if_else(str_to_lower(class) == "other_antihypertensive", 1L, 0L),
    any_diuretic = if_else(str_to_lower(class) %in% c("loop_diuretic", "thiazide_diuretic", "k_sparing_diuretic"), 1L, 0L)
  ) |>
  select(ndc11, rxcui, STR, TTY, n_drugs, loop_diuretic, thiazide_diuretic,
    Ksparing_diuretic, ACE_inhibitor, ARB, aldo_antagonist, alpha_blocker,
    beta_blocker, calcium_channel_blocker, centrally_acting, renin_antagonist,
    vasodilator, other, any_diuretic, FDC, ndc_start_date, ndc_end_date, ndc_status) |>
  rename(ndc = ndc11) |>
  filter(!is.na(ndc))

antihtn_ndcs_collapsed <- antihtn_ndcs_new1 |>
  group_by(ndc, rxcui) |>
  summarise(
    STR = first(STR),
    TTY = first(TTY),
    n_drugs = max(n_drugs, na.rm = TRUE),

    across(
      all_of(class_vars),
      ~ as.integer(any(.x == 1, na.rm = TRUE))
    ),

    FDC = as.integer(any(FDC == 1, na.rm = TRUE)),

    ndc_start_date = first(ndc_start_date),
    ndc_end_date = first(ndc_end_date),
    ndc_status = first(ndc_status),

    .groups = "drop"
  )

# Export data -------------------------------------------------------------

write_csv(antihtn_rxcuis_new, dropbox_path("rxnorm-drug-lists", "antihypertensive_drugs", "antihtn_rxcuis.csv"))
write_csv(antihtn_ndcs_new, dropbox_path("rxnorm-drug-lists", "antihypertensive_drugs", "antihtn_ndcs.csv"))

# bpcl data
write_csv(antihtn_rxcuis_new_collapsed, dropbox_path("rxnorm-drug-lists", "antihypertensive_drugs", "bpcl", "antihtn_rxcuis_bpcl.csv"))
write_csv(antihtn_ndcs_collapsed, dropbox_path("rxnorm-drug-lists", "antihypertensive_drugs", "bpcl", "antihtn_ndcs_bpcl.csv"))
