# Antidiabetic Drugs
These SAS datasets contain a curated list of antidiabetic drugs, labeled with therapeutic class.

They are derived from RxNorm, published by the U.S. National Library of Medicine.

The lists include currently-prescribable drugs, as well as historical RXCUIs that are obsolete, or have been depricated.

The NDC list in particular, is optimized for use with the PCORnet common data model, which specifies use of 11-digit NDC numbers. NDC numbers of other lengths are not included, even though they may be specified in RxNorm datasets.


Variables are as follows:

antidm_rxcui_classes:
1. RXCUI: RxNorm concept unique identifier
2. RXAUI: RxNorm atom unique identifier
3. SAB: Source of data for RxNorm entry (all "RXNORM" in these files)
4. STR:  Description of drug/product
5. TTY:  RxNorm Term Type
6-8. medname#:  medication name (all drugs have non-NULL medname1; combination products will contain information in medname2 +/- medname3)
9-11. class#: therapeutic class of corresponding medname (i.e., class1 refers to medname1; class2 refers to medname2; etc)
12. n_drugs: # of antidiabetics in product
13. FDC:  indicator variable for fixed-dose combination (1=yes; 0=no);
14. single_medname_var:  equivalent to medname1 for non-combination products; concatenated list of drugs for combination products
15. single_class_var: equivalent to class1 for non-combination products; concatenated list of classes for combination products

antidm_ndc_classes (derived from antihtn_rxcui_classes):
1-13. (same variables as above, except for TTY)
14. ndcnum:  11-digit NDC number  


Medications included, along with classes, are contained in the CSV file in this same directory.
