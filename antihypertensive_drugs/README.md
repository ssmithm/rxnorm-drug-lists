# Antihypertensive Drugs

**Last updated:  May 12, 2026**

**Current through RxNorm Release: May, 2026**


These CSV datasets in this folder contain a curated list of **antihypertensive drugs**, labeled with therapeutic classes. They are derived from RxNorm, published by the U.S. National Library of Medicine, using the R package [rxref](https://www.stevenmsmith.org/rxref/). The lists include currently-prescribable drugs, as well as historical RXCUIs that are obsolete, or have been depricated. The NDC list, is optimized for use with the PCORnet common data model, which specifies use of 11-digit NDC numbers. NDC numbers of other lengths are not included, even though they may be specified in RxNorm datasets.

Note the list of drugs included below. **This list is specifically formulated to include typical outpatient antihypertensives used in chronic hypertension management; it does not include, for example, injectable only antihypertensives used in the inpatient setting.** However, the accompanying R script could be modified to include such antinypertensives. 

Separate files, contained in the `bpcl` folder, contain the same list, but with class indicator variables.



### Datasets & Corresponding variables

#### antihtn_rxcuis.csv

1.  RXCUI: RxNorm concept unique identifier
2.  STR:  Description of drug/product
3.  TTY:  RxNorm Term Type
4.  n_drugs: # of antihypertensives in product
5.  ingredient_name: primary ingredient of RxCUI (may be one of several for fixed-dose combinations)
6.  routes: route of administration
7.  dose_forms: dosage formulation
8.  dose_form_groups: dosage formulation grouping (curated)
9.  FDC: fixed-dose combination; logical (1=FDC; 0=non-FDC)
10. class = antihypertensive class

#### antihtn_ndcs.csv (derived from antihtn_rxcuis)
1. rxcui: RxNorm concept unique identifier
2. related_rxcui
3. ndc11: 11-digit NDC 
4. ndc_start_date: date of first representation of NDC in RxNorm
5. ndc_end_date: date of last representation of NDC in RxNorm
6. ndc_status: NDC status (active or obsolete)
7. STR:  Description of drug/product
8. TTY:  RxNorm Term Type
9. n_drugs: # of antihypertensives in product
10. ingredient_name: primary ingredient of RxCUI (may be one of several for fixed-dose combinations)
11. routes: route of administration
12. dose_forms: dosage formulation
13. dose_form_groups: dosage formulation grouping (curated)
14. FDC: fixed-dose combination; logical (1=FDC; 0=non-FDC)
15. class = antihypertensive class


### Medications included

#### Angiotensin Receptor Blockers (class=ARB)
- azilsartan
- candesartan
- irbesartan
- losartan
- olmesartan
- telmisartan
- valsartan
- eprosartan

#### ACE inhibitors (class=ACE)
- benazepril
- captopril
- enalapril
- fosinopril
- lisinopril
- moexipril
- perindopril
- quinapril
- ramipril
- trandolapril

#### Direct renin inhibitors (class=DRI)
- aliskiren

#### Beta Blockers (class=BB)
- acebutolol
- atenolol
- betaxolol
- bisoprolol
- carvedilol
- labetalol
- metoprolol
- nadolol
- nebivolol
- penbutolol
- pindolol
- propranolol
- timolol

#### Non-dihydropyridine Calcium channel blockers (class=NONDHP_CCB)
- verapamil
- diltiazem

#### Dihydropyridine calcium channel blockers (class=DHP_CCB)
- amlodipine
- felodipine
- isradipine
- nicardipine
- nifedipine
- nisoldipine
- levamlodipine

#### Thiazide Diuretics (class=THIAZIDE_DIURETIC)
- bendroflumethiazide
- chlorothiazide
- chlorthalidone
- hydrochlorothiazide
- indapamide
- methyclothiazide
- metolazone
- polythiazide
- trichlormethiazide

#### Potassium-sparing Diuretics (class=K_SPARING_DIURETIC) 
- amiloride
- triamterene

#### Aldosterone Antagonists (class=ALDO_ANTAGONIST) 
- eplerenone
- spironolactone

#### Loop Diuretics (class=LOOP)
- bumetanide
- torsemide
- furosemide
- ethacrynate

#### Alpha1 blockers (class=ALPHA_BLOCKER)
- doxazosin
- prazosin
- terazosin

#### Centrally-acting agents (class=CENTRALLY_ACTING)
- clonidine
- guanabenz
- guanfacine
- methyldopa

#### Vasodilators (class=VASODILATOR)
- hydralazine
- minoxidil

#### Others (class=OTHER)
- guanadrel
- guanethidine
- reserpine

