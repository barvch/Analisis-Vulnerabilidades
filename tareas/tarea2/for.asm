section .text
global _start

_start:
    mov ecx, 10 ; se guarda en ecx el no. de iteraciones

ciclo:  ;se crea la función ciclo

    push ecx   ;manda el inicio del stack el valor actual de ecx

    mov edx,len ;len cotiene es longitud a escribir
    mov ecx,msg    ;se lee el buffer
    mov eax,4   ;llama a imprimir
    int 0x80    ; llamada al sistema para mandar a pantalla el mensaje

    pop ecx    ;se retoma el valor de exc de la pila
    dec ecx ;se decrementa en 1 el valor de ecx
    cmp ecx, 0  ;se compara el valor de ecx contra 0
    jg ciclo    ;si ecx  es más grande que 0, regresa al inicio del ciclo, sino, continua.

    mov eax,1   ;se indica que se sys_call = 1 para salir del programa
    int 0x80    ;llamada al kernel para salir 

section .data
    msg: db ':)',0xa
    len: equ $ - msg
