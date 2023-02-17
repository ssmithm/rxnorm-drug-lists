# Antihypertensive Drugs

**Last updated:  February 2023**

**Current through RxNorm Release: December 5, 2022**


These SAS datasets contain a curated list of **antihypertensive drugs**, labeled with therapeutic class. They are derived from RxNorm, published by the U.S. National Library of Medicine. The lists include currently-prescribable drugs, as well as historical RXCUIs that are obsolete, or have been depricated. The NDC list in particular, is optimized for use with the PCORnet common data model, which specifies use of 11-digit NDC numbers. NDC numbers of other lengths are not included, even though they may be specified in RxNorm datasets.



### Datasets & Corresponding variables

#### Antihtn_RXCUI_classes

1.  RXCUI: RxNorm concept unique identifier
2.  RXAUI: RxNorm atom unique identifier
3.  SAB: Source of data for RxNorm entry (all "RXNORM" in these files)
4.  STR:  Description of drug/product
5.  TTY:  RxNorm Term Type
6.  medname1:  medication name (all drugs have non-NULL medname1)
7.  medname2:  medication name (single drug entities will have NULL medname2; combination products will contain information in medname2)
8.  medname3:  medication name (single drug entities will have NULL medname3; *only 3-drug combination products* will contain information in medname3, else NULL)
9.  class1:  therapeutic class of corresponding medname (i.e., medname1); all entries have non-NULL class1.
10. class2:  therapeutic class of corresponding medname (i.e., medname2); NULL if corresponding medname is NULL. 
11. class3:  therapeutic class of corresponding medname (i.e., medname3); NULL if corresponding medname is NULL. 
12. n_drugs: # of antihypertensives in product
13. FDC:  indicator variable for fixed-dose combination (1=yes; 0=no);
14. single_medname_var:  equivalent to medname1 for non-combination products; concatenated list of drugs for combination products; concatenated lists are ordered alphabetically for consistency.
15. single_class_var: equivalent to class1 for non-combination products; concatenated list of classes for combination products; concatenated lists are ordered alphabetically for consistency.

#### Antihtn_NDC_classes (derived from antihtn_rxcui_classes)
1. STR:  Description of drug/product
2. medname#:  medication name (all drugs have non-NULL medname1; combination products will contain information in medname2 +/- medname3)
3. medname2:  (as above)
4. medname3:  (as above)
5. class1: therapeutic class of corresponding medname (i.e., class1 refers to medname1; class2 refers to medname2; etc)
6. class2: (as above)
7. class3: (as above) 
8. single_medname_var:  equivalent to medname1 for non-combination products; concatenated list of drugs for combination products
9. single_class_var: equivalent to class1 for non-combination products; concatenated list of classes for combination products
10. FDC:  indicator variable for fixed-dose combination (1=yes; 0=no)
11. n_drugs: # of antihypertensives in product
12. RXCUI: RxNorm concept unique identifier
13. RXAUI: RxNorm atom unique identifier
14. STYPE: (generally ignorable - RxNorm-asserted value)
15. CODE: (generally ignorable - RxNorm-asserted value)
16. SAB_SAT: Source of data for RxNorm entry (generally ignorable)
17. ndcnum:  11-digit NDC number
31. SUPPRESS: (generally ignorable - RxNorm-asserted value)
32. IN:  last RxNorm monthly release file in which the NDC was observed, represented as YYYYMMDD

#### Antihtn_RXCUI_strength (also derived from antihtn_rxcui_classes)

1. RXCUI: RxNorm concept unique identifier
2. STR:  Description of drug/product
3. rxcui_related_scdc: RXCUI of the related (as asserted by RxNorm) Semantic Clinical Drug Component 
4. medname1:  standardized antihypertensive medication name
5. RXN_STRENGTH:  strength of the product
6. RXN_STRENGTH_NUM_VALUE:  (parsed) numerator value of the RXN_STRENGTH
7. RXN_STRENGTH_NUM_UNIT: (parsed) numerator unit of the RXN_STRENGTH
8. RXN_STRENGTH_DENOM_VALUE: (parsed) denominator value of the RXN_STRENGTH (for pills = 1)
9. RXN_STRENGTH_DENOM_UNIT: (parsed) denominator unit of the RXN_STRENGTH (for pills = 1)


### Medications included

#### Angiotensin Receptor Blockers (class=ARB)
- LOSARTAN
- OLMESARTAN
- TELMISARTAN
- TELMISARTIN
- CANDESARTAN
- EPROSARTAN
- AZILSARTAN
- IRBESARTAN
- VALSARTAN

#### ACE inhibitors (class=ACE)
- BENAZEPRIL
- CAPTOPRIL
- CILAZAPRIL
- ENALAPRIL
- ENALAPRILAT
- FOSINOPRIL
- LISINOPRIL
- MOEXIPRIL
- MOEXIPRILAT
- PERINDOPRIL
- PERINDOPRILAT
- QUINAPRIL
- QUINAPRILAT
- RAMIPRIL
- RAMIPRILAT
- TRANDOLAPRIL
- TRANDOLAPRILAT

#### Direct renin inhibitors (class=DRI)
- ALISKIREN

#### Beta Blockers (class=BB)
- ACEBUTOLOL
- ATENOLOL
- NADOLOL
- OXPRENOLOL
- BETAXOLOL
- BISOPROLOL
- CARTEOLOL
- TIMOLOL
- BUCINDOLOL
- ESMOLOL
- LABETALOL
- CARVEDILOL
- METOPROLOL
- PROPRANOLOL
- NEBIVOLOL
- PENBUTOLOL
- PINDOLOL
- SOTALOL
- METIPRANOLOL

#### Non-dihydropyridine Calcium channel blockers (class=NONDHP_CCB)
- VERAPAMIL
- DILTIAZEM

#### Dihydropyridine calcium channel blockers (class=DHP_CCB)
- NIFEDIPINE
- NICARDIPINE
- FELODIPINE
- BENIDIPINE
- ISRADIPINE
- NILVADIPINE
- NIMODIPINE
- NISOLDIPINE
- NITRENDIPINE
- AMLODIPINE
- AZELNIDIPINE
- CLEVIDIPINE
- EFONIDIPINE
- LACIDIPINE
- LERCANIDIPINE
- MANIDIPINE
- LEVAMLODIPINE
- CILNIDIPINE

#### Thiazide Diuretics (class=THIAZIDE_DIURETIC)
- BENDROFLUMETHIAZIDE
- CHLORTALIDONE
- CHLORTHALIDONE
- HYDROCHLOROTHIAZIDE
- HCTZ
- CHLOROTHIAZIDE
- METHYCLOTHIAZIDE
- POLYTHIAZIDE
- BUTHIAZIDE
- CYCLOTHIAZIDE
- BENZOTHIAZIDE
- XIPAMIDE
- FLUMETHIAZIDE
- CLOPAMIDE
- ALTHIAZIDE
- INDAPAMIDE
- METOLAZONE
- TRICHLORMETHIAZIDE
- CYCLOPENTHIAZIDE
- HYDROFLUMETHIAZIDE

#### Potassium-sparing Diuretics (class=K_SPARING_DIURETIC) 
- AMILORIDE
- TRIAMTERENE

#### Aldosterone Antagonists (class=ALDO_ANTAGONIST) 
- EPLERENONE
- SPIRONOLACTONE

#### Loop Diuretics (class=LOOP)
- BUMETANIDE
- TORSEMIDE
- FUROSEMIDE
- ETHACRYNIC (ACID)
- ETHACRYNATE
- EDECRIN

#### Alpha1 blockers (class=ALPHA_BLOCKER)
- PRAZOSIN
- TERAZOSIN
- DOXAZOSIN
- PHENOXYBENZAMINE
- PHENTOLAMINE

#### Centrally-acting agents (class=CENTRALLY_ACTING)
- CLONIDINE
- METHYLDOPA
- METHYLDOPATE
- GUANABENZ
- GUANFACINE
- GUANADREL
- GUANETHIDINE
- MOXONIDINE
- RILMENIDINE

#### Vasodilators (class=VASODILATOR)
- MINOXIDIL
- HYDRALAZINE
- NITROPRUSSIDE

#### Others (class=OTHER)
- RESERPINE
- DESERPIDINE
- RAUWOLFIA
- SERPENTINA


