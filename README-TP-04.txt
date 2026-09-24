README-TP-04

# TP4 - Economía Aplicada (UdeSA 2026)

Replicación parcial de Dinkelman (2011, AER), "The Effects of Rural Electrification on Employment: New Evidence from South Africa". Instrumento: pendiente promedio del terreno (`mean_grad_new`). Muestra principal: 1.816 comunidades con `largeareas == 1`. Muestra placebo: 373 comunidades ya electrificadas antes de 1996.

## Estructura
TP_04_REYMONDES/
├── input/
│ ├── dinkelman2011_comunidades.dta
│ └── dinkelman2011_placebo.dta
├── programs/
│ ├── 00_master.do
│ ├── 01_figuras.do
│ ├── 02_tablas.do
│ ├── 03_inferencia.do
│ └── 04_falsificacion.do
└── output/
├── figures/
└── tables/


## Cómo correr

Abrir `00_master.do`, editar `global root` con la ruta local del paquete, y correr entero. El master instala los paquetes necesarios (`binscatter`, `ivreg2`, `ranktest`, `avar`, `weakivtest`, `weakiv`, `estout`, `tf`), crea las subcarpetas de `output/` y ejecuta los cuatro scripts en orden.

## Qué hace cada script

- **`01_figuras.do`** — Ejercicio 2. Seis binscatters con 20 ventiles: primera etapa (crudo y residualizado) y forma reducida para mujeres y varones (crudo y residualizado). La residualización aplica Frisch-Waugh-Lovell absorbiendo controles y efectos fijos de distrito. Salidas en `output/figures/`.

- **`02_tablas.do`** — Ejercicio 3. MCO, primera etapa, forma reducida y MC2E para empleo femenino y masculino, con F efectivo de Montiel-Pflueger al pie. Errores agrupados por subdistrito. Salidas: `tabla_mujeres.tex` y `tabla_varones.tex` en `output/tables/`.

- **`03_inferencia.do`** — Ejercicio 4. Intervalo de Anderson-Rubin al 95% (comando `weakiv`) y corrección $t_F$ de Lee et al. (2022) (comando `tf`) para el MC2E de mujeres.

- **`04_falsificacion.do`** — Ejercicio 5. (a) Reestimación restringiendo a `count_roads == 0` (1.792 obs) para chequear el canal de las rutas: primera etapa, MC2E, F efectivo y AR. (b) Forma reducida en la muestra placebo, corrida dos veces: con `grad10` para comparar con nuestra Tabla del ejercicio 3, y con `mean_grad_new` para replicar exactamente la columna (1) de la Tabla 6 del paper.

## Nota sobre la escala del gradiente

En las tablas 3 y 4 el paper usa `Gradient × 10`, así que trabajamos con `grad10 = mean_grad_new / 10`. En la Tabla 6 (columna 1) usa la pendiente sin escalar, por eso el 5(b) incluye la regresión con `mean_grad_new` para replicar el $-0{,}001$ exacto de la autora. Los dos números son idénticos, solo cambia la unidad.

## Resultados centrales

| Concepto                       | Valor                    |
|--------------------------------|--------------------------|
| MC2E mujeres                   | 0,095                    |
| F efectivo (muestra completa)  | 8,26                     |
| Intervalo Wald                 | [-0,012; 0,203]          |
| Intervalo AR                   | [0,010; +∞)              |
| Intervalo $t_F$                | [-0,114; 0,304]          |
| F efectivo (sin rutas)         | 10,43                    |
| MC2E sin rutas                 | 0,069                    |
| Placebo (escala paper)         | -0,001                   |

## Requisitos

Stata 17 o superior
## Autor

Santiago Reymondes — Maestría en Economía, UdeSA 