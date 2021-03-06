set Classes := {"B-NP","B-PP","I-NP","B-VP","I-VP","B-SBAR","O","B-ADJP","B-ADVP","I-ADVP","I-ADJP","I-SBAR","I-PP","B-PRT","B-LST","B-INTJ","I-INTJ","B-CONJP","I-CONJP","I-PRT","B-UCP","I-UCP","I-LST"};
set lines := {1..33};
set ch := {1..23};




param p[lines*ch] :=
   |1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23|
|1| 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 |
|2| 0,0,0.281,0.719,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|
|3| 0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 |
|4| 0.001,0.999,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 |
|5| 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|
|6| 0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|
|7| 0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|
|8| 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|
|9| 0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|
|10| 0.996,0,0,0.004,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|
|11| 0.004,0,0.996,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|
|12| 0.001,0,0.999,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|
|13| 0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|
|14| 0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|
|15| 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|
|16| 0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|
|17| 0.002,0,0.998,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|
|18| 0,0,0.001,0,0,0,0.999,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|
|19| 0.99,0,0.006,0.003,0,0,0,0,0.001,0,0,0,0,0,0,0,0,0,0,0,0,0,0|
|20| 0.003,0,0.994,0,0,0,0,0,0.002,0,0,0,0,0,0,0,0,0,0,0,0,0,0|
|21| 0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|
|22| 0.126,0.005,0.001,0.866,0,0,0.001,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|
|23| 0.061,0.087,0.316,0.076,0.451,0.001,0,0,0,0,0,0,0,0.005,0,0,0,0,0,0,0,0,0|
|24| 0.056,0,0.943,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|
|25| 0,0.999,0,0,0,0.001,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|
|26| 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|
|27| 0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|
|28| 0,0.004,0,0,0,0,0.996,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|
|29| 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|
|30| 0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|
|31| 0.011,0.001,0.97,0.002,0,0,0,0,0,0.001,0.012,0,0.002,0,0,0,0,0,0,0,0,0,0|
|32| 0.008,0,0.979,0.005,0,0,0,0.003,0.005,0,0.001,0,0,0,0,0,0,0,0,0,0,0,0|
|33| 0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|;



do forall <i,j> in lines*ch do print p[i,j];

var choix[lines*ch] binary;


subto unicitegroupe:
  forall <i> in lines do sum<j> in ch: choix[i,j] == 1; 

subto no_ix_isole_NP:
  forall <i> in lines with i>1 : choix[i,3] - choix[(i-1),3] - choix[(i-1),1] <= 0; 

subto no_ix_isole_VP:
  forall <i> in lines with i>1 : choix[i,5] - choix[(i-1),5] - choix[(i-1),4] <= 0; 

subto no_ix_isole_ADVP:
  forall <i> in lines with i>1 : choix[i,10] - choix[(i-1),10] - choix[(i-1),9] <= 0; 

subto no_ix_isole_ADJP:
  forall <i> in lines with i>1 : choix[i,11] - choix[(i-1),11] - choix[(i-1),8] <= 0; 

subto no_ix_isole_SBAR:
  forall <i> in lines with i>1 : choix[i,12] - choix[(i-1),12] - choix[(i-1),6] <= 0; 

subto no_ix_isole_PP:
  forall <i> in lines with i>1 : choix[i,13] - choix[(i-1),13] - choix[(i-1),2] <= 0; 

subto no_ix_isole_INTJ:
  forall <i> in lines with i>1 : choix[i,17] - choix[(i-1),17] - choix[(i-1),16] <= 0; 

subto no_ix_isole_CONJP:
  forall <i> in lines with i>1 : choix[i,19] - choix[(i-1),19] - choix[(i-1),18] <= 0; 

subto no_ix_isole_PRT:
  forall <i> in lines with i>1 : choix[i,20] - choix[(i-1),20] - choix[(i-1),14] <= 0; 

subto no_ix_isole_UCP:
  forall <i> in lines with i>1 : choix[i,22] - choix[(i-1),22] - choix[(i-1),21] <= 0; 

subto no_ix_isole_LSP:
  forall <i> in lines with i>1 : choix[i,23] - choix[(i-1),23] - choix[(i-1),15] <= 0; 

maximize number:
	sum <i,j> in lines*ch : choix[i,j]*p[i,j];