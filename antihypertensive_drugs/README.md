# Antihypertensive Drugs

By: Steve Smith, UF
Last updated:  January 2022
Current through RxNorm Release: January 3 2022

These SAS datasets contain a curated list of antihypertensive drugs, labeled with therapeutic class. 

They are derived from RxNorm, published by the U.S. National Library of Medicine.

The lists include currently-prescribable drugs, as well as historical RXCUIs that are obsolete, or have been depricated.

The NDC list in particular, is optimized for use with the PCORnet common data model, which specifies use of 11-digit NDC numbers. NDC numbers of other lengths are not included, even though they may be specified in RxNorm datasets.


Variables are as follows:

antihtn_rxcui_classes:
1. RXCUI: RxNorm concept unique identifier
2. RXAUI: RxNorm atom unique identifier
3. SAB: Source of data for RxNorm entry (all "RXNORM" in these files)
4. STR:  Description of drug/product
5. TTY:  RxNorm Term Type
6-8. medname#:  medication name (all drugs have non-NULL medname1; combination products will contain information in medname2 +/- medname3)
9-11. class#: therapeutic class of corresponding medname (i.e., class1 refers to medname1; class2 refers to medname2; etc)
12. n_drugs: # of antihypertensives in product
13. FDC:  indicator variable for fixed-dose combination (1=yes; 0=no);
14. single_medname_var:  equivalent to medname1 for non-combination products; concatenated list of drugs for combination products
15. single_class_var: equivalent to class1 for non-combination products; concatenated list of classes for combination products

antihtn_ndc_classes (derived from antihtn_rxcui_classes):
1-13. (same variables as above, except for TTY)
14. ndcnum:  11-digit NDC number  

antihtn_rxcui_strength (also derived from antihtn_rxcui_classes):
1. RXCUI: RxNorm concept unique identifier
2. STR:  Description of drug/product
3. rxcui_related_scdc: RXCUI of the related (as asserted by RxNorm) Semantic Clinical Drug Component 
4. medname1:  standardized antihypertensive medication name
5. RXN_STRENGTH:  strength of the product
6. RXN_BOSS_STRENGTH_NUM_VALUE:  (parsed) numerator value of the RXN_STRENGTH
7. RXN_BOSS_STRENGTH_NUM_UNIT: (parsed) numerator unit of the RXN_STRENGTH
8. RXN_BOSS_STRENGTH_DENOM_VALUE: (parsed) denominator value of the RXN_STRENGTH (for pills = 1)
9. RXN_BOSS_STRENGTH_DENOM_UNIT: (parsed) denominator unit of the RXN_STRENGTH (for pills = 1)


Medications included are:

Angiotensin Receptor Blockers (class=ARB):
LOSARTAN
OLMESARTAN
TELMISARTAN
TELMISARTIN
CANDESARTAN
EPROSARTAN
AZILSARTAN
IRBESARTAN
VALSARTAN

ACE inhibitors (class=ACE):
BENAZEPRIL
CAPTOPRIL
CILAZAPRIL
ENALAPRIL
ENALAPRILAT
FOSINOPRIL
LISINOPRIL
MOEXIPRIL
MOEXIPRILAT
PERINDOPRIL
PERINDOPRILAT
QUINAPRIL
QUINAPRILAT
RAMIPRIL
RAMIPRILAT
TRANDOLAPRIL
TRANDOLAPRILAT

Direct renin inhibitors (class=DRI):
ALISKIREN

Beta Blockers (class=BB):
ACEBUTOLOL
ATENOLOL
NADOLOL
OXPRENOLOL
BETAXOLOL
BISOPROLOL
CARTEOLOL
TIMOLOL
BUCINDOLOL
ESMOLOL
LABETALOL
CARVEDILOL
METOPROLOL
PROPRANOLOL
NEBIVOLOL
PENBUTOLOL
PINDOLOL
SOTALOL
METIPRANOLOL

Non-dihydropyridine Calcium channel blockers (class=NONDHP_CCB):
VERAPAMIL
DILTIAZEM

Dihydropyridine calcium channel blockers (class=DHP_CCB):
NIFEDIPINE
NICARDIPINE
FELODIPINE
BENIDIPINE
ISRADIPINE
NILVADIPINE
NIMODIPINE
NISOLDIPINE
NITRENDIPINE
AMLODIPINE
AZELNIDIPINE
CLEVIDIPINE
EFONIDIPINE
LACIDIPINE
LERCANIDIPINE
MANIDIPINE
LEVAMLODIPINE
CILNIDIPINE

Thiazide Diuretics (class=THIAZIDE_DIURETIC)
BENDROFLUMETHIAZIDE
CHLORTALIDONE
CHLORTHALIDONE
HYDROCHLOROTHIAZIDE
HCTZ
CHLOROTHIAZIDE
METHYCLOTHIAZIDE
POLYTHIAZIDE
BUTHIAZIDE
CYCLOTHIAZIDE
BENZOTHIAZIDE
XIPAMIDE
FLUMETHIAZIDE
CLOPAMIDE
ALTHIAZIDE
INDAPAMIDE
METOLAZONE
TRICHLORMETHIAZIDE
CYCLOPENTHIAZIDE
HYDROFLUMETHIAZIDE

Potassium-sparing Diuretics (class=K_SPARING_DIURETIC):
AMILORIDE
TRIAMTERENE

Aldosterone Antagonists (class=ALDO_ANTAGONIST):
EPLERENONE
SPIRONOLACTONE

Loop Diuretics (class=LOOP):
BUMETANIDE
TORSEMIDE
FUROSEMIDE
ETHACRYNIC
ETHACRYNATE
EDECRIN

Alpha1 blockers (class=ALPHA_BLOCKER):
PRAZOSIN
TERAZOSIN
DOXAZOSIN
PHENOXYBENZAMINE
PHENTOLAMINE

Centrally-acting agents (class=CENTRALLY_ACTING)
CLONIDINE
METHYLDOPA
METHYLDOPATE
GUANABENZ
GUANFACINE
GUANADREL
GUANETHIDINE
MOXONIDINE
RILMENIDINE

Vasodilators (class=VASODILATOR):
MINOXIDIL
HYDRALAZINE
NITROPRUSSIDE

Others (class=OTHER):
RESERPINE
DESERPIDINE
RAUWOLFIA
SERPENTINA


