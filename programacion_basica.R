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

