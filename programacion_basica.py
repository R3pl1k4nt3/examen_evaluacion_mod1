# =============================================================================
# EVALUACIÓN - MÓDULO 1
# PROGRAMACIÓN BÁSICA EN PYTHON (ejercicio opcional - 2 puntos) - 5 A ELEGIR
# Cuestiones seleccionadas: 1, 4, 7, 9, 10
# =============================================================================


# =============================================================================
# HELPERS DE VALIDACIÓN (reutilizados en todas las funciones)
# =============================================================================

def input_check_str(data):
    if not isinstance(data, list):
        raise TypeError("La entrada de la función debe ser una lista")

    if len(data) == 0:
        raise ValueError("La lista de entrada no puede estar vacía")

    for i, elem in enumerate(data):
        if not isinstance(elem, str):
            raise TypeError(f"Todos los elementos deben ser strings. Fallo en índices: {i + 1}")
        if elem == "":
            raise ValueError(f"La lista no puede contener strings vacíos. Fallo en índices: {i + 1}")


def input_check_num(data):
    if not isinstance(data, list):
        raise TypeError("La entrada de la función debe ser una lista")

    if len(data) == 0:
        raise ValueError("La lista de entrada no puede estar vacía")

    for i, elem in enumerate(data):
        if not isinstance(elem, (int, float)):
            raise TypeError(f"Todos los elementos deben ser números. Fallo en índices: {i + 1}")


# =============================================================================
# Cuestión 1: Diseñe una función que reciba un carácter como argumento y
# determine si es una vocal. La función debe devolver un valor booleano.
# =============================================================================

def es_vocal(caracter):

    if not isinstance(caracter, str):
        raise TypeError("La entrada de la función debe ser un string")

    if len(caracter) == 0:
        raise ValueError("La entrada no puede ser un string vacío")

    if len(caracter) != 1:
        raise ValueError(f"La entrada debe ser un único carácter. Se recibieron {len(caracter)} caracteres")

    vocales = "aeiouáéíóú"

    # normalizo a minúscula para comparar
    return caracter.lower() in vocales


# =============================================================================
# Cuestión 4: Defina una función de conversión térmica que transforme grados
# Celsius a Fahrenheit y Kelvin.
# Tf = Tc * (9/5) + 32  |  Tk = Tc + 273.15
# Aplique la función a: T = [15.6, 25.2, 36.0, 21.2, 17.9, 28.3, 32.1]
# =============================================================================

def convertir_temperatura(data):

    input_check_num(data)

    fahrenheit = []
    kelvin = []
    for temp in data:
        fahrenheit.append(temp * (9 / 5) + 32)
        kelvin.append(temp + 273.15)

    output = {
        "fahrenheit": fahrenheit,
        "kelvin": kelvin
    }

    return output

# =============================================================================
# Cuestión 7: Desarrolle una función que procese una lista de palabras y
# devuelva un diccionario cuya clave sea la palabra y su valor la longitud.
# =============================================================================

def palabras_y_longitudes(data):

    input_check_str(data)

    output = {}
    for elem in data:
        output[elem] = len(elem)

    return output

# =============================================================================
# Cuestión 9: Implemente una función que reciba una cadena de texto y devuelva
# el recuento total de consonantes presentes en ella.
# =============================================================================

def contar_consonantes(data):

    if not isinstance(data, str):
        raise TypeError("La entrada de la función debe ser un string")

    if data == "":
        raise ValueError("La entrada no puede ser un string vacío")

    data_norm = data.lower()
    vocales = "aeiouáéíóú"

    contador = 0
    for letra in data_norm:
        # una consonante es una letra del alfabeto que NO es vocal
        if letra.isalpha() and letra not in vocales:
            contador += 1

    return contador

# =============================================================================
# Cuestión 10: Desarrolle una función que convierta un número entero en base
# decimal a su representación en sistema binario.
# =============================================================================

def decimal_a_binario(data):

    if not isinstance(data, int):
        raise TypeError("La entrada de la función debe ser un número entero")

    if data < 0:
        raise ValueError(f"El número debe ser un entero no negativo. Se recibió {data}")

    # caso especial: el binario de 0 es "0"
    if data == 0:
        return "0"

    # algoritmo de divisiones sucesivas entre 2
    bits = []
    n = data

    while n > 0:
        bits.append(str(n % 2))  # guardamos el resto
        n = n // 2

    output = "".join(reversed(bits))

    return output