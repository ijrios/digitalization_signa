# Muestreo práctico
•	Se requiere un script que reciba los parámetros muestreo y cuantización (fs y q) para una señal de audio/voz capturada a través del micrófono o de un archivo. El script debe recibir la señal de audio (del micrófono o del archivo) y realizar los procesos de muestreo y cuantización, graficando las señales (original, PAM y PAM cuantizada), el error de cuantización y el ruido de cuantización. Utilice varias combinaciones de parámetros y la reproducción del audio original y el recuperado para comparar.

# Conclusiones 
•	Mientras más alta sea la frecuencia de muestreo (El periodo debe ser pequeño) más separados van a estar los impulsos de la función en el dominio de la frecuencia, se podrá estudiar mejor la señal.
 
•	Si la frecuencia de muestreo es mucho menor al ancho de banda de la señal, se toman pocos datos de la señal, por lo tanto, no se podrá recuperar completamente la señal y se genera aliasing.

•	Si ingresamos muy pocos bits, no se generarán los suficientes niveles de cuantización, por lo tanto, no se podrán aproximar los valores necesarios para discretizar la señal.

•	La distorsión producida por la aproximación de cada muestra se denomina ruido de cuantización, mientras más niveles se tomen, el error será menor, pues entre más niveles hayan, la precisión de los datos será mayor y se reduce la incertidumbre.
