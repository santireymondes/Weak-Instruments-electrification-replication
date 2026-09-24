********************************************************************************
* Ejercicio 4: La inferencia honesta
* (a) Intervalo de Anderson-Rubin al 95% para el MC2E de mujeres
* (b) Corrección tF de Lee, McCrary, Moreira y Porter (2022)
********************************************************************************

use "$input/dinkelman2011_comunidades.dta", clear
keep if largeareas == 1

capture drop grad10
gen grad10 = mean_grad_new / 10

global controles "kms_to_subs0 baseline_hhdens0 base_hhpovrate0 prop_head_f_a0 sexratio0_a prop_indianwhite0 kms_to_road0 kms_to_town0 prop_matric_m0 prop_matric_f0 d_prop_waterclose d_prop_flush"

*-------------------------------------------------------------------------------
* MC2E con ivreg2 (necesario para weakiv y tf)
*-------------------------------------------------------------------------------

ivreg2 d_prop_emp_f $controles i.dccode0 (T = grad10), cluster(placecode0)

*-------------------------------------------------------------------------------
* (a) Intervalo de Anderson-Rubin al 95%
*-------------------------------------------------------------------------------

weakiv, level(95)

*-------------------------------------------------------------------------------
* (b) Corrección tF de Lee et al. (2022)
*-------------------------------------------------------------------------------

tf d_prop_emp_f $controles i.dccode0 (T = grad10), cluster(placecode0)