# EVALUACIÓN - MÓDULO 1 - PREPROCESADO DE DATOS

**Autores:** Pablo Sánchez y Juanjo García

## CONSIDERACIONES

* La puntuación máxima que se puede obtener es de **13 puntos** (10 ejercicios obligatorios + 3 puntos con ejercicios opcionales).
* El ejercicio obligatorio de **PROGRAMACIÓN BÁSICA**, a realizar en **R**, debe hacerse en un entorno local y utilizando test unitarios.
* El ejercicio opcional de **PROGRAMACIÓN BÁSICA**, a realizar en **Python**, debe hacerse en un entorno local y utilizando test unitarios. Debe elegir cinco cuestiones del total (**2 puntos**).
* El ejercicio obligatorio, **PREPROCESADO DE DATOS**, deberá ser realizado usando R o Python. Podrá usarse tanto el entorno local como un cluster de databricks.
* El ejercicio opcional, **MANEJO DE DATOS**, deben realizarse utilizando el lenguaje SQL. Será realizado exclusivamente en el cluster de databricks.
* Para acceder a databricks (versión gratuita) utilizar este enlace: [https://www.databricks.com/learn/free-edition](https://www.databricks.com/learn/free-edition)

---

## EJERCICIOS OBLIGATORIOS

### PROGRAMACIÓN BÁSICA (5 puntos)

**Cuestión 1**
Diseñe una función que reciba un carácter como argumento y determine si es una vocal. La función debe devolver un valor booleano (`True` o `False`).

**Cuestión 2**
A partir de una lista de palabras, programe una función que identifique y devuelva la palabra con mayor longitud.

**Cuestión 3**
Implemente una función que analice una lista de números para identificar duplicados. El resultado debe ser un diccionario donde las claves sean los números y los valores representen su frecuencia de aparición.

**Cuestión 4**
Defina una función de conversión térmica que transforme grados Celsius a Fahrenheit y Kelvin. Aplique dicha función a la siguiente lista de temperaturas: `T=[15.6,25.2,36.0,21.2,17.9,28.3,32.1]`.
Las fórmulas matemáticas que permiten relacionar las escalas de temperaturas son:
* $T_f = T_c \times (9/5) + 32$
* $T_k = T_c + 273.15$

**Cuestión 5**
Defina una función que reciba una lista de palabras y las devuelva ordenadas de menor a mayor longitud.

**Cuestión 6**
Cree una función que reciba dos listas distintas y genere una nueva lista que contenga los elementos únicos (sin duplicados) presentes en ambas.

**Cuestión 7**
Desarrolle una función que procese una lista de palabras y devuelva un diccionario cuya clave sea la palabra y su valor la longitud de la misma.

**Cuestión 8**
Escriba una función que filtre los números impares de una lista y calcule sus cuadrados. El resultado debe ser un diccionario con la estructura `{número_impar: cuadrado}`.

**Cuestión 9**
Implemente una función que reciba una cadena de texto y devuelva el recuento total de consonantes presentes en ella.

**Cuestión 10**
Desarrolle una función que convierta un número entero en base decimal a su representación en sistema binario.

> **Nota:** Para todas cuestiones anteriores, deben realizarse test unitarios haciendo uso de la librería `testthat`. Si se realiza la parte opcional de Python, puede usarse indistintamente tanto `unittest` como `pytest`.
>
> En el lenguaje R no existe el tipo de dato “diccionario” como en Python. En aquellos ejercicios donde se indique como salida un diccionario, se entenderá que la función debe devolver una lista nombrada (`list`), donde:
> - las `keys` corresponden a los nombres de los elementos de la lista, y
> - los `values` corresponden a los valores almacenados en cada elemento.
>
> Es decir, el comportamiento será equivalente a un diccionario de Python, pero implementado mediante una lista con nombres en R.

---

### PREPROCESADO DE DATOS (5 puntos)

A partir del conjunto de datos `parkinsons_disease_data.parquet` que contiene información sobre 2,105 pacientes diagnosticados con la enfermedad de Parkinson, será necesario realizar un análisis de los factores asociados con la enfermedad. El conjunto de datos incluye información demográfica, antecedentes médicos, mediciones clínicas, evaluaciones cognitivas y funcionales, síntomas y un indicador de diagnóstico.

#### Variables

| Variable | Descripción |
| :--- | :--- |
| **PatientID** | Identificador único asignado a cada paciente |
| **Age** | Edad de los pacientes (rango de 50 a 90 años) |
| **Gender** | Género de los pacientes (0: Masculino, 1: Femenino) |
| **Ethnicity** | Etnicidad de los pacientes (0: Caucásico, 1: Afroamericano, 2: Asiático, 3: Otro) |
| **EducationLevel** | Nivel educativo de los pacientes (0: Ninguno, 1: Secundaria, 2: Licenciatura, 3: Superior) |
| **BMI** | Índice de masa corporal de los pacientes (rango de 15 a 40) |
| **Smoking** | Estado de fumador (0: No, 1: Sí) |
| **AlcoholConsumption** | Consumo semanal de alcohol en unidades (rango de 0 a 20) |
| **PhysicalActivity** | Actividad física semanal en horas (rango de 0 a 10) |
| **DietQuality** | Puntaje de calidad de la dieta (rango de 0 a 10) |
| **SleepQuality** | Puntaje de calidad del sueño (rango de 4 a 10) |
| **FamilyHistoryParkinsons** | Historia familiar de la enfermedad de Parkinson (0: No, 1: Sí) |
| **TraumaticBrainInjury** | Historia de lesiones cerebrales traumáticas (0: No, 1: Sí) |
| **Hypertension** | Presencia de hipertensión (0: No, 1: Sí) |
| **Diabetes** | Presencia de diabetes (0: No, 1: Sí) |
| **Depression** | Presencia de depresión (0: No, 1: Sí) |
| **Stroke** | Historia de accidente cerebrovascular (0: No, 1: Sí) |
| **SystolicBP** | Presión arterial sistólica (rango de 90 a 180 mmHg) |
| **DiastolicBP** | Presión arterial diastólica (rango de 60 a 120 mmHg) |
| **CholesterolTotal** | Niveles de colesterol total (rango de 150 a 300 mg/dL) |
| **CholesterolLDL** | Niveles de colesterol LDL (rango de 50 a 200 mg/dL) |
| **CholesterolHDL** | Niveles de colesterol HDL (rango de 20 a 100 mg/dL) |
| **CholesterolTriglycerides** | Niveles de triglicéridos (rango de 50 a 400 mg/dL) |
| **MoCA** | Puntuación de la evaluación cognitiva de Montreal (rango de 0 a 30) |
| **FunctionalAssessment** | Puntuación de la evaluación funcional (rango de 0 a 10) |
| **Tremor** | Presencia de temblores (0: No, 1: Sí) |
| **Rigidity** | Presencia de rigidez muscular (0: No, 1: Sí) |
| **Bradykinesia** | Presencia de bradicinesia (lentitud en los movimientos) (0: No, 1: Sí) |
| **PosturalInstability** | Presencia de inestabilidad postural (0: No, 1: Sí) |
| **SpeechProblems** | Presencia de problemas de habla (0: No, 1: Sí) |
| **SleepDisorders** | Presencia de trastornos del sueño (0: No, 1: Sí) |
| **Constipation** | Presencia de estreñimiento (0: No, 1: Sí) |
| **Diagnosis** | Estado del diagnóstico de la enfermedad de Parkinson (0: No, 1: Sí) |

**Se solicita que se realicen los siguientes análisis:**

1.  Análisis descriptivo y gráfico de las variables (univariante y bivariante).
2.  Revisión de posibles valores atípicos siguiendo tanto métodos univariantes como multivariantes.
3.  Imputación de datos ausentes en las variables correspondientes.
4.  Equilibrado de la muestra sobre la variable `Diagnosis`: Reducción de la clase mayoritaria hasta igualar el número de instancias de la clase minoritaria. Utilice la técnica estadística que mejor considere explicando el uso de la misma.

**A la hora de realizar el análisis descriptivo se busca que el alumno:**

* Analice la relación entre las variables demográficas, el estilo de vida, el historial médico y los síntomas con el diagnóstico de la enfermedad de Parkinson.
* Realiza un análisis de correlación entre los factores de riesgo como el índice de masa corporal (BMI), el consumo de alcohol y el historial médico (hipertensión, diabetes, etc.) con la presencia de la enfermedad.

**Así, a modo de ejemplo, se proponen una serie de cuestiones a analizar:**

* ¿Cuáles son los factores más influyentes en el diagnóstico de la enfermedad de Parkinson?
* ¿Cómo afecta la calidad del sueño, la dieta y el nivel de actividad física al desarrollo de la enfermedad?

**Ayuda:** usar la función `read_parquet` del paquete arrow para leer el fichero `parkinsons_disease_data.parquet` en R. En caso de utilizar python puede usar directamente la librería pandas junto con pyarrow.

El código a usar sería:

* Si utiliza R:
    ```r
    library(arrow)
    df <- read_parquet("parkinsons_disease_data.parquet")
    ```

* Si utiliza python:
    ```python
    import pandas as pd
    df = pd.read_parquet('parkinsons_disease_data.parquet', engine='pyarrow')
    ```

---

## EJERCICIO OPCIONAL

### MANEJO DE BASES DE DATOS (1 punto)

El presente dataset contiene registros detallados sobre la actividad, demografía y niveles de compromiso de una comunidad de jugadores. El objetivo de este análisis es extraer información estratégica sobre los hábitos de consumo, el rendimiento de los usuarios y la segmentación geográfica, permitiendo así optimizar la experiencia de juego y las estrategias de monetización.

#### Variables

| Variable | Descripción |
| :--- | :--- |
| **PlayerID** | Identificador único alfanumérico para cada jugador. |
| **Age** | Edad del jugador en años. |
| **Gender** | Género del jugador (Male, Female, Other). |
| **Location** | Región geográfica de residencia (USA, Europe, Asia, Other). |
| **GameGenre** | Género principal del videojuego (Action, Strategy, RPG, Sports, Simulation). |
| **PlayTimeHours** | Tiempo total acumulado de juego medido en horas. |
| **InGamePurchases** | Variable binaria de compras integradas (1: Sí, 0: No). |
| **GameDifficulty** | Nivel de dificultad seleccionado (Easy, Medium, Hard). |
| **SessionsPerWeek** | Promedio de veces que el jugador inicia sesión en una semana. |
| **AvgSessionDurationMinutes** | Duración media de cada sesión de juego en minutos. |
| **PlayerLevel** | Nivel actual de progresión alcanzado por el jugador. |
| **AchievementsUnlocked** | Número total de logros o trofeos desbloqueados. |
| **EngagementLevel** | Nivel de compromiso basado en actividad (Low, Medium, High). |

**Se pide responder a las siguientes cuestiones:**

1.  ¿Cuántos jugadores hay registrados según su género?
2.  ¿Cuántos jugadores hay por cada ubicación geográfica?
3.  Muestra el número total de jugadores desglosado por género y por género de videojuego.
4.  ¿Cuántos jugadores tienen un nivel de compromiso igual a ‘High’?
5.  Calcula el promedio de horas de juego para cada nivel de dificultad.
6.  ¿Cuál es la media de sesiones por semana para los jugadores con más de 30 años?
7.  Filtra los jugadores que han realizado compras integradas (`InGamePurchases = 1`). Selecciona su `PlayerID`, `Age` y la columna `AchievementsUnlocked`.
8.  Filtra las jugadoras de la ubicación ‘Asia’ que tengan un nivel de jugador superior a 50. Selecciona exclusivamente los campos `PlayerID` y `AvgSessionDurationMinutes`.
9.  Agrupa a los jugadores por género y muestra solo aquellos cuya media de duración de sesión sea superior a 100 minutos.
10. ¿Cuál es el valor máximo y mínimo de logros desbloqueados según cada género de videojuego?
11. Crea una consulta que devuelva el `PlayerID` junto a una nueva columna llamada `Experience_Status` que clasifique el nivel del jugador como:
    * ‘Novato’ si es menor a 30,
    * ‘Veterano’ entre 30 y 70, y
    * ‘Leyenda’ si es mayor a 70.
12. Genera una tabla con el `PlayerID` y una nueva columna categórica `PlayTime_Bucket`. Esta columna será:
    * ‘Ocasional’ si `PlayTimeHours` es menor de 5,
    * ‘Regular’ entre 5 y 15, e
    * ‘Intensivo’ en cualquier otro caso.