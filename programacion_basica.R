# =============================================================================
# EVALUACIÓN - MÓDULO 1
# PROGRAMACIÓN BÁSICA EN R (5 puntos)
# =============================================================================




  # =============================================================================
  # Cuestión 1
  # Diseñe una función que reciba un carácter como argumento y determine
  # si es una vocal. La función debe devolver un valor booleano (TRUE o FALSE)
  #
  # Output: booleano (TRUE / FALSE)
  # =============================================================================

es_vocal <- function(caracter) {
  
  #input_check_single_str(caracter)
  
  if (nchar(caracter) != 1) {
    stop("La entrada debe ser un único carácter, no una cadena de texto")
  }
  
  vocales <- c("a", "e", "i", "o", "u", "á", "é", "í", "ó", "ú")
  
  # Normalizo a minúscula para comparar
  caracter_norm <- tolower(caracter)
  
  return(caracter_norm %in% vocales)
}


# =============================================================================
# Cuestión 2
# A partir de una lista de palabras, programe una función que identifique
# y devuelva la palabra con mayor longitud.
#
# Output: lista de strings (puede haber empate)
# =============================================================================

palabra_mas_larga <- function(value_list) {
  
  #input_check_str(value_list)
  
  palabras <- unlist(value_list)
  
  longitudes <- nchar(palabras)
  max_longitud <- max(longitudes)
  
  # Devuelvo todas las que tienen la longitud máxima (manejo de empates)
  resultado <- palabras[longitudes == max_longitud]
  
  return(as.list(resultado))
}



# =============================================================================
# Cuestión 3
# Implemente una función que analice una lista de números para identificar
# duplicados. El resultado debe ser un diccionario donde las claves sean los
# números y los valores representen su frecuencia de aparición.
#
# Output: lista nombrada (equivalente a diccionario Python)
# =============================================================================

frecuencia_duplicados <- function(value_list) {
  
  #input_check_num(value_list)
  
  vector_numeros <- unlist(value_list)
  
  frecuencias <- table(vector_numeros)
  
  # Convierto a lista nombrada (diccionario)
  resultado <- as.list(as.integer(frecuencias))
  names(resultado) <- names(frecuencias)
  
  return(resultado)
}


# =============================================================================
# Cuestión 4
# Defina una función de conversión térmica que transforme grados Celsius
# a Fahrenheit y Kelvin.
# Tf = Tc * (9/5) + 32
# Tk = Tc + 273.15
#
# Output: lista nombrada con dos claves: "fahrenheit" y "kelvin"
#         cada una con una lista de valores convertidos
# =============================================================================

convertir_temperatura <- function(value_list) {
  
  #input_check_num(value_list)
  
  celsius <- unlist(value_list)
  
  fahrenheit <- celsius * (9 / 5) + 32
  kelvin     <- celsius + 273.15
  
  resultado <- list(
    fahrenheit = as.list(fahrenheit),
    kelvin     = as.list(kelvin)
  )
  
  return(resultado)
}

# =============================================================================
# Cuestión 5
# Defina una función que reciba una lista de palabras y las devuelva
# ordenadas de menor a mayor longitud.
#
# Output: lista de strings ordenada por longitud ascendente
# =============================================================================

ordenar_por_longitud <- function(value_list) {
  
  #input_check_str(value_list)
  
  palabras <- unlist(value_list)
  
  indices_ordenados <- order(nchar(palabras))
  
  resultado <- palabras[indices_ordenados]
  
  return(as.list(resultado))
}


# =============================================================================
# Cuestión 6
# Cree una función que reciba dos listas distintas y genere una nueva lista
# que contenga los elementos únicos (sin duplicados) presentes en ambas.
#
# Output: lista con los elementos únicos de la unión de ambas listas
# =============================================================================

elementos_unicos <- function(lista_a, lista_b) {
  
  # Valido ambas listas por separado
  # Se acepta tanto strings como números, así que valido que sean listas no vacías - NO USO HELPERS DE VALIDACION
  if (!is.list(lista_a) || !is.list(lista_b)) {
    stop("Ambas entradas deben ser listas")
  }
  if (length(lista_a) == 0 || length(lista_b) == 0) {
    stop("Las listas de entrada no pueden estar vacías")
  }
  
  # Unimos y eliminamos duplicados
  union_total  <- c(unlist(lista_a), unlist(lista_b))
  resultado    <- unique(union_total)
  
  return(as.list(resultado))
}

# =============================================================================
# Cuestión 7
# Desarrolle una función que procese una lista de palabras y devuelva un
# diccionario cuya clave sea la palabra y su valor la longitud de la misma.
#
# Output: lista nombrada {palabra: longitud}
# =============================================================================

palabras_y_longitudes <- function(value_list) {
  
  #input_check_str(value_list)
  
  palabras <- unlist(value_list)
  
  longitudes <- nchar(palabras)
  
  resultado        <- as.list(longitudes)
  names(resultado) <- palabras
  
  return(resultado)
}


# =============================================================================
# Cuestión 8
# Escriba una función que filtre los números impares de una lista y calcule
# sus cuadrados. El resultado debe ser un diccionario {número_impar: cuadrado}
#
# Output: lista nombrada {numero_impar: cuadrado}
# =============================================================================

impares_y_cuadrados <- function(value_list) {
  
  #input_check_num(value_list)
  
  vector_numeros <- unlist(value_list)
  
  # Filtro los impares (resto de división entre 2 distinto de 0)
  impares <- vector_numeros[vector_numeros %% 2 != 0]
  
  if (length(impares) == 0) {
    return(list())  # Lista vacía si no hay impares
  }
  
  cuadrados        <- as.list(impares^2)
  names(cuadrados) <- as.character(impares)
  
  return(cuadrados)
}




# =============================================================================
# Cuestión 9
# Implemente una función que reciba una cadena de texto y devuelva el
# recuento total de consonantes presentes en ella.
#
# Output: entero (número de consonantes)
# =============================================================================

contar_consonantes <- function(cadena) {
  
  #input_check_single_str(cadena)
  
  # Normalizo: paso a minúsculas y elimino acentos para cubrir más casos
  cadena_norm <- tolower(cadena)
  cadena_norm <- chartr("áéíóúàèìòùâêîôû",
                        "aeiouaeiouaeiou",
                        cadena_norm)
  
  letras <- strsplit(cadena_norm, split = "")[[1]]
  
  vocales     <- c("a", "e", "i", "o", "u")
  es_letra    <- grepl("[a-z]", letras)
  es_vocal    <- letras %in% vocales
  es_consonante <- es_letra & !es_vocal
  
  return(sum(es_consonante))
}

# =============================================================================
# Cuestión 10
# Desarrolle una función que convierta un número entero en base decimal
# a su representación en sistema binario.
#
# Output: string con la representación binaria
# =============================================================================

decimal_a_binario <- function(numero) {
  
  input_check_single_int(numero)
  
  if (numero < 0) {
    stop("El número debe ser un entero no negativo")
  }
  
  # Caso especial: el binario de 0 es "0"
  if (numero == 0) {
    return("0")
  }
  
  # Algoritmo de divisiones sucesivas entre 2
  bits <- character(0)
  n    <- numero
  
  while (n > 0) {
    bits <- c(as.character(n %% 2), bits)  # el resto va al frente
    n    <- n %/% 2
  }
  
  return(paste(bits, collapse = ""))
}
