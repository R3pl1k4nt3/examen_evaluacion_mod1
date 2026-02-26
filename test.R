# =============================================================================
# EVALUACIÓN - MÓDULO 1
# TESTS UNITARIOS - PROGRAMACIÓN BÁSICA EN R
# Librería: testthat
# =============================================================================

library(testthat)

source("programacion_basica.R")


# =============================================================================
# BLOQUE 1: Tests para 'es_vocal'
# =============================================================================

test_that("es_vocal - Happy Path", {
  
  # Vocales minúsculas
  expect_true(es_vocal("a"))
  expect_true(es_vocal("e"))
  expect_true(es_vocal("i"))
  expect_true(es_vocal("o"))
  expect_true(es_vocal("u"))
  
  # Vocales mayúsculas
  expect_true(es_vocal("A"))
  expect_true(es_vocal("E"))
  
  # Vocales con tilde
  expect_true(es_vocal("á"))
  expect_true(es_vocal("é"))
  expect_true(es_vocal("í"))
  
  # Consonantes → FALSE
  expect_false(es_vocal("b"))
  expect_false(es_vocal("Z"))
  expect_false(es_vocal("r"))
  
  # Caracteres no alfabéticos → FALSE
  expect_false(es_vocal("1"))
  expect_false(es_vocal("!"))
})

test_that("es_vocal - Sad Path (errores)", {
  
  # Error: más de un carácter
  expect_error(
    es_vocal("ae"),
    "único carácter"
  )
  
  # Error: string vacío
  expect_error(
    es_vocal(""),
    "no puede estar vacío"
  )
  
  # Error: no es string (número)
  expect_error(
    es_vocal(5),
    "único string"
  )
  
  # Error: NULL
  expect_error(
    es_vocal(NULL),
    "único string"
  )
})


# =============================================================================
# BLOQUE 2: Tests para 'palabra_mas_larga'
# =============================================================================

test_that("palabra_mas_larga - Happy Path", {
  
  # Caso 1: Ganador único
  input_1 <- list("sol", "murciélago", "pez")
  output_1 <- palabra_mas_larga(input_1)
  expect_is(output_1, "list")
  expect_length(output_1, 1)
  expect_equal(output_1[[1]], "murciélago")
  
  # Caso 2: Empate → devuelve ambas
  input_2 <- list("casa", "pato", "sol")
  output_2 <- palabra_mas_larga(input_2)
  expect_length(output_2, 2)
  expect_true("casa" %in% unlist(output_2))
  expect_true("pato" %in% unlist(output_2))
  
  # Caso 3: Un solo elemento
  input_3 <- list("único")
  output_3 <- palabra_mas_larga(input_3)
  expect_length(output_3, 1)
  expect_equal(output_3[[1]], "único")
})

test_that("palabra_mas_larga - Sad Path (errores)", {
  
  # Error: no es lista
  expect_error(
    palabra_mas_larga(c("hola", "mundo")),
    "debe ser una lista"
  )
  
  # Error: lista vacía
  expect_error(
    palabra_mas_larga(list()),
    "no puede estar vacía"
  )
  
  # Error: contiene elemento no string
  expect_error(
    palabra_mas_larga(list("hola", 123)),
    "Fallo en índices: 2"
  )
  
  # Error: contiene string vacío
  expect_error(
    palabra_mas_larga(list("hola", "")),
    "strings vacíos"
  )
})


# =============================================================================
# BLOQUE 3: Tests para 'frecuencia_duplicados'
# =============================================================================

test_that("frecuencia_duplicados - Happy Path", {
  
  # Caso 1: Mezcla de repetidos y únicos
  input_1 <- list(1, 2, 2, 3, 3, 3)
  output_1 <- frecuencia_duplicados(input_1)
  
  expect_is(output_1, "list")
  expect_equal(output_1[["1"]], 1L)
  expect_equal(output_1[["2"]], 2L)
  expect_equal(output_1[["3"]], 3L)
  
  # Caso 2: Todos únicos → frecuencia 1 para cada uno
  input_2 <- list(10, 20, 30)
  output_2 <- frecuencia_duplicados(input_2)
  expect_equal(output_2[["10"]], 1L)
  expect_equal(output_2[["20"]], 1L)
  
  # Caso 3: Un solo elemento repetido
  input_3 <- list(5, 5, 5, 5)
  output_3 <- frecuencia_duplicados(input_3)
  expect_equal(output_3[["5"]], 4L)
})

test_that("frecuencia_duplicados - Sad Path (errores)", {
  
  # Error: no es lista
  expect_error(
    frecuencia_duplicados(c(1, 2, 3)),
    "debe ser una lista"
  )
  
  # Error: lista vacía
  expect_error(
    frecuencia_duplicados(list()),
    "no puede estar vacía"
  )
  
  # Error: contiene string dentro de números
  expect_error(
    frecuencia_duplicados(list(1, "dos", 3)),
    "Fallo en índices: 2"
  )
})


# =============================================================================
# BLOQUE 4: Tests para 'convertir_temperatura'
# =============================================================================

test_that("convertir_temperatura - Happy Path", {
  
  # Caso 1: 0°C → 32°F y 273.15K
  input_1 <- list(0)
  output_1 <- convertir_temperatura(input_1)
  
  expect_is(output_1, "list")
  expect_named(output_1, c("fahrenheit", "kelvin"))
  expect_equal(output_1$fahrenheit[[1]], 32)
  expect_equal(output_1$kelvin[[1]], 273.15)
  
  # Caso 2: 100°C → 212°F y 373.15K
  input_2 <- list(100)
  output_2 <- convertir_temperatura(input_2)
  expect_equal(output_2$fahrenheit[[1]], 212)
  expect_equal(output_2$kelvin[[1]], 373.15)
  
  # Caso 3: Lista del enunciado (múltiples temperaturas)
  T_enunciado <- list(15.6, 25.2, 36.0, 21.2, 17.9, 28.3, 32.1)
  output_3 <- convertir_temperatura(T_enunciado)
  
  expect_length(output_3$fahrenheit, 7)
  expect_length(output_3$kelvin, 7)
  # Verificamos el primer valor manualmente: 15.6 * 9/5 + 32 = 60.08
  expect_equal(output_3$fahrenheit[[1]], 15.6 * (9/5) + 32)
  
  # Caso 4: Temperatura negativa (-40°C = -40°F)
  input_4 <- list(-40)
  output_4 <- convertir_temperatura(input_4)
  expect_equal(output_4$fahrenheit[[1]], -40)
})

test_that("convertir_temperatura - Sad Path (errores)", {
  
  # Error: no es lista
  expect_error(
    convertir_temperatura(25),
    "debe ser una lista"
  )
  
  # Error: lista vacía
  expect_error(
    convertir_temperatura(list()),
    "no puede estar vacía"
  )
  
  # Error: contiene string
  expect_error(
    convertir_temperatura(list(20, "treinta")),
    "Fallo en índices: 2"
  )
})


# =============================================================================
# BLOQUE 5: Tests para 'ordenar_por_longitud'
# =============================================================================

test_that("ordenar_por_longitud - Happy Path", {
  
  # Caso 1: Orden estándar
  input_1 <- list("murciélago", "sol", "casa")
  output_1 <- ordenar_por_longitud(input_1)
  
  expect_is(output_1, "list")
  expect_equal(output_1[[1]], "sol")       # 3 letras → primero
  expect_equal(output_1[[2]], "casa")      # 4 letras → segundo
  expect_equal(output_1[[3]], "murciélago") # 10 letras → último
  
  # Caso 2: Ya estaban ordenadas
  input_2 <- list("a", "ab", "abc")
  output_2 <- ordenar_por_longitud(input_2)
  expect_equal(unlist(output_2), c("a", "ab", "abc"))
  
  # Caso 3: Palabras con igual longitud (mantiene orden relativo)
  input_3 <- list("sol", "mar", "rio")
  output_3 <- ordenar_por_longitud(input_3)
  expect_length(output_3, 3)
  # Todas tienen longitud 3 → orden estable
  expect_true(all(nchar(unlist(output_3)) == 3))
})

test_that("ordenar_por_longitud - Sad Path (errores)", {
  
  # Error: no es lista
  expect_error(
    ordenar_por_longitud(c("hola", "mundo")),
    "debe ser una lista"
  )
  
  # Error: lista vacía
  expect_error(
    ordenar_por_longitud(list()),
    "no puede estar vacía"
  )
  
  # Error: contiene número
  expect_error(
    ordenar_por_longitud(list("hola", 99)),
    "Fallo en índices: 2"
  )
})


# =============================================================================
# BLOQUE 6: Tests para 'elementos_unicos'
# =============================================================================

test_that("elementos_unicos - Happy Path", {
  
  # Caso 1: Números con solapamiento
  output_1 <- elementos_unicos(list(1, 2, 3), list(2, 3, 4, 5))
  expect_is(output_1, "list")
  # Debe contener exactamente 1,2,3,4,5 (sin duplicados)
  expect_length(output_1, 5)
  expect_true(all(c(1, 2, 3, 4, 5) %in% unlist(output_1)))
  
  # Caso 2: Strings con solapamiento
  output_2 <- elementos_unicos(list("a", "b"), list("b", "c"))
  expect_length(output_2, 3)
  expect_true("a" %in% unlist(output_2))
  expect_true("b" %in% unlist(output_2))
  expect_true("c" %in% unlist(output_2))
  
  # Caso 3: Sin solapamiento → unión completa
  output_3 <- elementos_unicos(list(1, 2), list(3, 4))
  expect_length(output_3, 4)
  
  # Caso 4: Completamente iguales → solo los únicos
  output_4 <- elementos_unicos(list(1, 2), list(1, 2))
  expect_length(output_4, 2)
})

test_that("elementos_unicos - Sad Path (errores)", {
  
  # Error: primera entrada no es lista
  expect_error(
    elementos_unicos(c(1, 2), list(3, 4)),
    "deben ser listas"
  )
  
  # Error: segunda entrada no es lista
  expect_error(
    elementos_unicos(list(1, 2), c(3, 4)),
    "deben ser listas"
  )
  
  # Error: lista vacía
  expect_error(
    elementos_unicos(list(), list(1, 2)),
    "no pueden estar vacías"
  )
})


# =============================================================================
# BLOQUE 7: Tests para 'palabras_y_longitudes'
# =============================================================================

test_that("palabras_y_longitudes - Happy Path", {
  
  # Caso 1: Lista estándar
  input_1 <- list("sol", "casa", "murciélago")
  output_1 <- palabras_y_longitudes(input_1)
  
  expect_is(output_1, "list")
  expect_named(output_1, c("sol", "casa", "murciélago"))
  expect_equal(output_1$sol, 3)
  expect_equal(output_1$casa, 4)
  expect_equal(output_1$murciélago, 10)
  
  # Caso 2: Un solo elemento
  input_2 <- list("hola")
  output_2 <- palabras_y_longitudes(input_2)
  expect_equal(output_2$hola, 4)
  
  # Caso 3: Palabras con acentos (nchar cuenta correctamente)
  input_3 <- list("corazón")
  output_3 <- palabras_y_longitudes(input_3)
  expect_equal(output_3$corazón, 7)
})

test_that("palabras_y_longitudes - Sad Path (errores)", {
  
  # Error: no es lista
  expect_error(
    palabras_y_longitudes(c("hola", "mundo")),
    "debe ser una lista"
  )
  
  # Error: lista vacía
  expect_error(
    palabras_y_longitudes(list()),
    "no puede estar vacía"
  )
  
  # Error: contiene número
  expect_error(
    palabras_y_longitudes(list("hola", 5, "mundo")),
    "Fallo en índices: 2"
  )
})


# =============================================================================
# BLOQUE 8: Tests para 'impares_y_cuadrados'
# =============================================================================

test_that("impares_y_cuadrados - Happy Path", {
  
  # Caso 1: Mezcla de pares e impares
  input_1 <- list(1, 2, 3, 4, 5)
  output_1 <- impares_y_cuadrados(input_1)
  
  expect_is(output_1, "list")
  expect_named(output_1, c("1", "3", "5"))
  expect_equal(output_1[["1"]], 1)
  expect_equal(output_1[["3"]], 9)
  expect_equal(output_1[["5"]], 25)
  
  # Caso 2: Solo pares → lista vacía
  input_2 <- list(2, 4, 6, 8)
  output_2 <- impares_y_cuadrados(input_2)
  expect_length(output_2, 0)
  
  # Caso 3: Negativos impares también se incluyen
  input_3 <- list(-3, -2, -1)
  output_3 <- impares_y_cuadrados(input_3)
  expect_equal(output_3[["-3"]], 9)
  expect_equal(output_3[["-1"]], 1)
})

test_that("impares_y_cuadrados - Sad Path (errores)", {
  
  # Error: no es lista
  expect_error(
    impares_y_cuadrados(c(1, 3, 5)),
    "debe ser una lista"
  )
  
  # Error: lista vacía
  expect_error(
    impares_y_cuadrados(list()),
    "no puede estar vacía"
  )
  
  # Error: contiene string
  expect_error(
    impares_y_cuadrados(list(1, "tres", 5)),
    "Fallo en índices: 2"
  )
})


# =============================================================================
# BLOQUE 9: Tests para 'contar_consonantes'
# =============================================================================

test_that("contar_consonantes - Happy Path", {
  
  # Caso 1: Palabra estándar
  # "Hola" → h, l → 2 consonantes
  expect_equal(contar_consonantes("Hola"), 2)
  
  # Caso 2: Solo vocales → 0 consonantes
  expect_equal(contar_consonantes("aeiou"), 0)
  
  # Caso 3: Con espacios y números (solo letras cuentan)
  # "Hola Mundo" → h, l, m, n, d → 5 consonantes
  expect_equal(contar_consonantes("Hola Mundo"), 5)
  
  # Caso 4: Mayúsculas (debe normalizarlas)
  # "BCDF" → 4 consonantes
  expect_equal(contar_consonantes("BCDF"), 4)
  
  # Caso 5: Con acentos
  # "camión" → c, m, n → 3 consonantes (ignoramos tilde de ó)
  expect_equal(contar_consonantes("camión"), 3)
  
  # Caso 6: Solo consonantes
  expect_equal(contar_consonantes("rhythm"), 6)
})

test_that("contar_consonantes - Sad Path (errores)", {
  
  # Error: no es string
  expect_error(
    contar_consonantes(123),
    "único string"
  )
  
  # Error: string vacío
  expect_error(
    contar_consonantes(""),
    "no puede estar vacío"
  )
  
  # Error: vector de strings (más de uno)
  expect_error(
    contar_consonantes(c("hola", "mundo")),
    "único string"
  )
})


# =============================================================================
# BLOQUE 10: Tests para 'decimal_a_binario'
# =============================================================================

test_that("decimal_a_binario - Happy Path", {
  
  # Caso 1: Casos base
  expect_equal(decimal_a_binario(0),   "0")
  expect_equal(decimal_a_binario(1),   "1")
  expect_equal(decimal_a_binario(2),   "10")
  
  # Caso 2: Valores conocidos
  expect_equal(decimal_a_binario(10),  "1010")
  expect_equal(decimal_a_binario(8),   "1000")
  expect_equal(decimal_a_binario(255), "11111111")
  
  # Caso 3: Verificar tipo de output
  expect_is(decimal_a_binario(5), "character")
  
  # Caso 4: Potencias de 2
  expect_equal(decimal_a_binario(4),  "100")
  expect_equal(decimal_a_binario(16), "10000")
})

test_that("decimal_a_binario - Sad Path (errores)", {
  
  # Error: número negativo
  expect_error(
    decimal_a_binario(-1),
    "no negativo"
  )
  
  # Error: número con decimales (no es entero)
  expect_error(
    decimal_a_binario(3.5),
    "entero"
  )
  
  # Error: string
  expect_error(
    decimal_a_binario("10"),
    "único número"
  )
  
  # Error: NULL
  expect_error(
    decimal_a_binario(NULL),
    "único número"
  )
})