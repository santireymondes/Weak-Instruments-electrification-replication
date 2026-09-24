********************************************************************************
* Trabajo Práctico 4 - Economía Aplicada
* Master
* Santiago Reymondes
********************************************************************************

clear all
set more off
version 17

*-------------------------------------------------------------------------------
* Root editable: cambiar solo esta línea
*-------------------------------------------------------------------------------

global root "C:\Users\User\Documents\TP_04_REYMONDES"

*-------------------------------------------------------------------------------
* Rutas
*-------------------------------------------------------------------------------

global input    "$root/input"
global output   "$root/output"
global programs "$root/programs"

*-------------------------------------------------------------------------------
* Reconstrucción de la estructura de output
*-------------------------------------------------------------------------------

capture mkdir "$output"
capture mkdir "$output/figures"
capture mkdir "$output/tables"
capture ssc install binscatter
capture ssc install ivreg2
capture ssc install ranktest
capture ssc install avar
capture ssc install weakivtest
capture ssc install weakiv
capture ssc install estout
capture net install tf, from("https://www.princeton.edu/~davidlee/wp/")

*-------------------------------------------------------------------------------
* Ejecución de scripts
*-------------------------------------------------------------------------------

do "$programs/01_figuras.do"
do "$programs/02_tablas.do"
do "$programs/03_inferencia.do"
do "$programs/04_falsificacion.do"
