*;
* IMPUTE VARIABLE: GeographicLiving;
*;
format IMP_GeographicLiving BEST12.0;
label IMP_GeographicLiving = 'Imputed GeographicLiving';
IMP_GeographicLiving = GeographicLiving;
if IMP_GeographicLiving eq . then do;
****************************************************************;
****** DECISION TREE SCORING CODE ******;
****************************************************************;
****** LENGTHS OF NEW CHARACTER VARIABLES ******;
LENGTH I_GeographicLiving $ 12;
LENGTH _WARN_ $ 4;
****** LABELS FOR NEW VARIABLES ******;
LABEL P_GeographicLiving1 = 'Predicted: GeographicLiving=1';
LABEL P_GeographicLiving4 = 'Predicted: GeographicLiving=4';
LABEL P_GeographicLiving3 = 'Predicted: GeographicLiving=3';
LABEL P_GeographicLiving2 = 'Predicted: GeographicLiving=2';
LABEL Q_GeographicLiving1 = 'Unadjusted P: GeographicLiving=1';
LABEL Q_GeographicLiving4 = 'Unadjusted P: GeographicLiving=4';
LABEL Q_GeographicLiving3 = 'Unadjusted P: GeographicLiving=3';
LABEL Q_GeographicLiving2 = 'Unadjusted P: GeographicLiving=2';
LABEL I_GeographicLiving = 'Into: GeographicLiving';
LABEL U_GeographicLiving = 'Unnormalized Into: GeographicLiving';
LABEL _WARN_ = 'Warnings';
****** TEMPORARY VARIABLES FOR FORMATTED VALUES ******;
LENGTH _ARBFMT_12 $ 12;
DROP _ARBFMT_12;
_ARBFMT_12 = ' ';
/* Initialize to avoid warning. */
****** ASSIGN OBSERVATION TO NODE ******;
_ARBFMT_12 = PUT( HasChildren , BEST12.);
%DMNORMIP( _ARBFMT_12);
IF _ARBFMT_12 IN ('1' ,'0' ) THEN DO;
P_GeographicLiving1 = 0.29667867926366;
P_GeographicLiving4 = 0.40333106067984;
P_GeographicLiving3 = 0.20103243401188;
P_GeographicLiving2 = 0.0989578260446;
Q_GeographicLiving1 = 0.29667867926366;
Q_GeographicLiving4 = 0.40333106067984;
Q_GeographicLiving3 = 0.20103243401188;
Q_GeographicLiving2 = 0.0989578260446;
I_GeographicLiving = '4';
U_GeographicLiving = 4;
END;
ELSE DO;
P_GeographicLiving1 = 0;
P_GeographicLiving4 = 0;
P_GeographicLiving3 = 0;
P_GeographicLiving2 = 1;
Q_GeographicLiving1 = 0;
Q_GeographicLiving4 = 0;
Q_GeographicLiving3 = 0;
Q_GeographicLiving2 = 1;
I_GeographicLiving = '2';
U_GeographicLiving = 2;
END;
****************************************************************;
****** END OF DECISION TREE SCORING CODE ******;
****************************************************************;
*;
* ASSIGN VALUE TO: GeographicLiving;
*;
length _format200 $200;
drop _format200;
_format200 = strip(I_GeographicLiving);
if _format200="4" then IMP_GeographicLiving = 4;
else
if _format200="3" then IMP_GeographicLiving = 3;
else
if _format200="2" then IMP_GeographicLiving = 2;
else
if _format200="1" then IMP_GeographicLiving = 1;
END;
