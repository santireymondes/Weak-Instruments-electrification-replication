********************************************************************************
* Ejercicio 3: La tabla
* MCO, primera etapa, forma reducida y MC2E para empleo femenino y masculino,
* con F efectivo de Montiel-Olea y Pflueger al pie del MC2E.
********************************************************************************

use "$input/dinkelman2011_comunidades.dta", clear
keep if largeareas == 1

* Gradiente escalado por 10 para replicar la unidad del paper (Tabla 3 col 4)
capture drop grad10
gen grad10 = mean_grad_new / 10

global controles "kms_to_subs0 baseline_hhdens0 base_hhpovrate0 prop_head_f_a0 sexratio0_a prop_indianwhite0 kms_to_road0 kms_to_town0 prop_matric_m0 prop_matric_f0 d_prop_waterclose d_prop_flush"

*-------------------------------------------------------------------------------
* MUJERES
*-------------------------------------------------------------------------------

eststo clear

* MCO
eststo MCO_f: reg d_prop_emp_f T $controles i.dccode0, cluster(placecode0)

* Primera etapa
eststo FS_f: reg T grad10 $controles i.dccode0, cluster(placecode0)

* Forma reducida
eststo RF_f: reg d_prop_emp_f grad10 $controles i.dccode0, cluster(placecode0)

* MC2E con F efectivo
eststo IV_f: ivregress 2sls d_prop_emp_f $controles i.dccode0 (T = grad10), cluster(placecode0)
weakivtest
estadd scalar F_eff = r(F_eff): IV_f

esttab MCO_f FS_f RF_f IV_f using "$output/tables/tabla_mujeres.tex", ///
    replace booktabs ///
    keep(T grad10) ///
    b(3) se(3) ///
    star(* 0.10 ** 0.05 *** 0.01) ///
    mtitles("MCO" "Primera etapa" "Forma reducida" "MC2E") ///
    stats(N F_eff, labels("N" "F efectivo (MOP)") fmt(0 2)) ///
    label nonotes

*-------------------------------------------------------------------------------
* VARONES
*-------------------------------------------------------------------------------

eststo clear

eststo MCO_m: reg d_prop_emp_m T $controles i.dccode0, cluster(placecode0)
eststo FS_m: reg T grad10 $controles i.dccode0, cluster(placecode0)
eststo RF_m: reg d_prop_emp_m grad10 $controles i.dccode0, cluster(placecode0)
eststo IV_m: ivregress 2sls d_prop_emp_m $controles i.dccode0 (T = grad10), cluster(placecode0)
weakivtest
estadd scalar F_eff = r(F_eff): IV_m

esttab MCO_m FS_m RF_m IV_m using "$output/tables/tabla_varones.tex", ///
    replace booktabs ///
    keep(T grad10) ///
    b(3) se(3) ///
    star(* 0.10 ** 0.05 *** 0.01) ///
    mtitles("MCO" "Primera etapa" "Forma reducida" "MC2E") ///
    stats(N F_eff, labels("N" "F efectivo (MOP)") fmt(0 2)) ///
    label nonotes