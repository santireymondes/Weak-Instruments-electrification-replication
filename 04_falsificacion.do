********************************************************************************
* Ejercicio 5: La falsificación
* (a) Canal de las rutas: reestimar con count_roads == 0
* (b) Placebo: forma reducida en áreas ya electrificadas antes de 1996
********************************************************************************

*-------------------------------------------------------------------------------
* (a) Canal de las rutas
*-------------------------------------------------------------------------------

use "$input/dinkelman2011_comunidades.dta", clear
keep if largeareas == 1
keep if count_roads == 0

capture drop grad10
gen grad10 = mean_grad_new / 10

global controles "kms_to_subs0 baseline_hhdens0 base_hhpovrate0 prop_head_f_a0 sexratio0_a prop_indianwhite0 kms_to_road0 kms_to_town0 prop_matric_m0 prop_matric_f0 d_prop_waterclose d_prop_flush"

* Primera etapa
reg T grad10 $controles i.dccode0, cluster(placecode0)

* MC2E con F efectivo
ivregress 2sls d_prop_emp_f $controles i.dccode0 (T = grad10), cluster(placecode0)
weakivtest

* Intervalo de Anderson-Rubin al 95%
ivreg2 d_prop_emp_f $controles i.dccode0 (T = grad10), cluster(placecode0)
weakiv, level(95)

*-------------------------------------------------------------------------------
* (b) Placebo: áreas ya electrificadas antes de 1996
*-------------------------------------------------------------------------------

use "$input/dinkelman2011_placebo.dta", clear
keep if largeareas == 1

capture drop grad10
gen grad10 = mean_grad_new / 10

* Forma reducida: pendiente sobre cambio en empleo femenino
* Debe replicar la columna (1) de la Tabla 6 del paper
reg d_prop_emp_f grad10 $controles i.dccode0, cluster(placecode0)

*-------------------------------------------------------------------------
*Replicación exacta de la columna (1) de la Tabla 6 del paper
* con la pendiente en la escala original (sin dividir por 10).
* Confirma que nuestro -0,010 con grad10 equivale exactamente al -0,001
* que reporta la autora.
*----------------------------------------------------------------------------

reg d_prop_emp_f mean_grad_new $controles i.dccode0, cluster(placecode0)