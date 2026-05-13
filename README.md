# rxnorm-drug-lists
Curated lists of medications (RXCUIs and NDCs) by therapeutic indication, with drug class labels, derived from RxNorm, 2005-present. 

These lists, particularly NDCs, are intended primarily for use querying medication data, for example from the PCORnet Common Data Model.

Pre-2026 lists are hand-curated from monthly release files. Lists from 2026 and beyond use the [rxref](https://www.stevenmsmith.org/rxref) package to query the RxNorm API. R scripts are included for reproducing said lists.
