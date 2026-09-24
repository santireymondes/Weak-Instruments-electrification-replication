********************************************************************************
* Ejercicio 2: Las dos figuras
*
* Se generan seis binscatters con 20 ventiles de pendiente:
*   - Primera etapa: fracción con proyecto Eskom contra pendiente
*   - Forma reducida (mujeres): cambio en empleo femenino contra pendiente
*   - Forma reducida (varones): cambio en empleo masculino contra pendiente
*
* Cada figura en dos versiones:
*   (a) datos crudos, sin controles
*   (b) residualizada: los controles de la especificación del paper y los
*       efectos fijos de distrito se absorben internamente por binscatter,
*       aplicando Frisch-Waugh-Lovell
********************************************************************************

use "$input/dinkelman2011_comunidades.dta", clear

* Muestra del paper: comunidades con al menos 100 adultos en 1996 y 2001
keep if largeareas == 1

*-------------------------------------------------------------------------------
* Controles de la especificación del paper (columna 8 de Tabla 4)
*-------------------------------------------------------------------------------

global controles "kms_to_subs0 baseline_hhdens0 base_hhpovrate0 prop_head_f_a0 sexratio0_a prop_indianwhite0 kms_to_road0 kms_to_town0 prop_matric_m0 prop_matric_f0 d_prop_waterclose d_prop_flush"

*-------------------------------------------------------------------------------
* Figura 1: Primera etapa
*-------------------------------------------------------------------------------

* (a) Datos crudos
binscatter T mean_grad_new, n(20) ///
    ytitle("Fracción con proyecto Eskom") ///
    xtitle("Pendiente promedio (grados)") ///
    title("Primera etapa: datos crudos") ///
    savegraph("$output/figures/fig1a_primera_etapa_crudo.png") replace

* (b) Residualizada
binscatter T mean_grad_new, n(20) controls($controles) absorb(dccode0) ///
    ytitle("Fracción con proyecto Eskom (residualizada)") ///
    xtitle("Pendiente promedio (residualizada)") ///
    title("Primera etapa: residualizada") ///
    savegraph("$output/figures/fig1b_primera_etapa_resid.png") replace

*-------------------------------------------------------------------------------
* Figura 2: Forma reducida, mujeres
*-------------------------------------------------------------------------------

* (a) Datos crudos
binscatter d_prop_emp_f mean_grad_new, n(20) ///
    ytitle("Cambio en empleo femenino") ///
    xtitle("Pendiente promedio (grados)") ///
    title("Forma reducida (mujeres): datos crudos") ///
    savegraph("$output/figures/fig2a_reducida_mujeres_crudo.png") replace

* (b) Residualizada
binscatter d_prop_emp_f mean_grad_new, n(20) controls($controles) absorb(dccode0) ///
    ytitle("Cambio en empleo femenino (residualizado)") ///
    xtitle("Pendiente promedio (residualizada)") ///
    title("Forma reducida (mujeres): residualizada") ///
    savegraph("$output/figures/fig2b_reducida_mujeres_resid.png") replace

*-------------------------------------------------------------------------------
* Figura 3: Forma reducida, varones
*-------------------------------------------------------------------------------

* (a) Datos crudos
binscatter d_prop_emp_m mean_grad_new, n(20) ///
    ytitle("Cambio en empleo masculino") ///
    xtitle("Pendiente promedio (grados)") ///
    title("Forma reducida (varones): datos crudos") ///
    savegraph("$output/figures/fig3a_reducida_varones_crudo.png") replace

* (b) Residualizada
binscatter d_prop_emp_m mean_grad_new, n(20) controls($controles) absorb(dccode0) ///
    ytitle("Cambio en empleo masculino (residualizado)") ///
    xtitle("Pendiente promedio (residualizada)") ///
    title("Forma reducida (varones): residualizada") ///
    savegraph("$output/figures/fig3b_reducida_varones_resid.png") replace
