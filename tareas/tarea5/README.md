# Funciones vulnerables a Buffer Overflow

Los overflows ocurren en lenguajes en los que se puede acceder a funcionalidades de bajo nivel dentro de la memoria, como es el caso de C o C++.

## ¿Cómo se produce un overflow?

Un overflow es generado, cuando en una estructura definida con un tamaño concreto, se intenta alojar en ella algo que requiera un mayor tamaño del que le fue asignado, lo que provoca la sobrescritura de espacios adyacentes en la memoria, como por ejemplo, 

## ¿Cómo evitar que suceda un overflow?

Para evitar que suceda un overflow, podemos tener en mente los siguientes puntos:

* Establecer un tamaño máximo para los datos de entrada
* Garantizar que la entrada, no supere ese valor máximo establecido.
* No usar funciones que estén deprecated o las funciones del legado.

Algunas funciones que han presentado problemas son:

* gets() -> Sive para leer caracteres
* strcpy() -> Copia el contenido del buffer a un string
* strcat() -> Hace una concatenación de un string con otro string
* sprintf() -> llenar el buffer con diferentes tipos de datos
* (f)scanf() -> leer desde la entrada estandar
* getwd() -> regresa el directorio actual de trabajo
* realpath() -> regresa el path completo del directorio actual de trabajo (tipo pwd)

Se han creado funciones equivalentes a las funciones que se han demostrado que pueden generar overflows, por lo que se pueden usar las siguientes funciones como substituto:

*  fgets() 
*  strncpy() 
*  strncat() 
*  snprintf() 

Los que no tengan una versión "segura", deben de ser reescritos y nunca está demás hacer checks para revisar lo que el usuarios está ingresando. 