import unittest
from programacion_basica import (
    es_vocal, 
    convertir_temperatura, 
    palabras_y_longitudes, 
    contar_consonantes, 
    decimal_a_binario
)

class TestProgramacionBasica(unittest.TestCase):

    # Cuestión 1: Vocal o no
    def test_es_vocal_exito(self):
        self.assertTrue(es_vocal("a"))
        self.assertFalse(es_vocal("b"))
        self.assertTrue(es_vocal("E"))
        self.assertTrue(es_vocal("á")) # Probamos también con tildes, ya que tu código las soporta

    def test_es_vocal_error(self):
        with self.assertRaises(TypeError):
            es_vocal(123)
        with self.assertRaises(ValueError):
            es_vocal("ab")

    # Cuestión 4: Conversión térmica
    def test_convertir_temperatura_exito(self):
        # Test con 0°C -> 32°F, 273.15K
        resultado = convertir_temperatura([0.0])
        # Accedemos a las listas por su clave (en minúsculas como en tu función) 
        # y cogemos el primer elemento [0]
        self.assertEqual(resultado["fahrenheit"][0], 32.0)
        self.assertEqual(resultado["kelvin"][0], 273.15)

    def test_convertir_temperatura_error(self):
        with self.assertRaises(ValueError):
            convertir_temperatura([])
        with self.assertRaises(TypeError):
            convertir_temperatura(["25"])

    # Cuestión 7: Longitud de palabras (Diccionario)
    def test_palabras_y_longitudes_exito(self):
        entrada = ["hola", "mundo"]
        esperado = {"hola": 4, "mundo": 5}
        self.assertEqual(palabras_y_longitudes(entrada), esperado)

    def test_longitud_palabras_error(self):
        with self.assertRaises(TypeError):
            palabras_y_longitudes([1, "dos"])

    # Cuestión 9: Contar consonantes
    def test_contar_consonantes_exito(self):
        self.assertEqual(contar_consonantes("Hola"), 2)
        self.assertEqual(contar_consonantes("Python!"), 5)

    def test_contar_consonantes_error(self):
        with self.assertRaises(TypeError):
            contar_consonantes(None)

    # Cuestión 10: Decimal a Binario
    def test_decimal_a_binario_exito(self):
        self.assertEqual(decimal_a_binario(10), "1010")
        self.assertEqual(decimal_a_binario(0), "0")
        self.assertEqual(decimal_a_binario(255), "11111111")

    def test_decimal_a_binario_error(self):
        with self.assertRaises(TypeError):
            decimal_a_binario("10")
        with self.assertRaises(ValueError):
            decimal_a_binario(-5)

if __name__ == "__main__":
    unittest.main()