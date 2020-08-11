section .text
global _start

_start:
    mov eax,4 ; se guarda en ecx el valor del switch que se desea (1,2,3 son las correctas)

    cmp eax, 1  ;se compara el valor de ecx contra 3
    je uno   ;si el valor de exc = 3, ve a opcionTres, sino, continua

    cmp eax,2  ;se compara el valor de ecx contra 2
    je dos    ;si el valor de exc = 2, ve a opcionDos, sino, continua

    cmp eax,3  ;se compara el valor de ecx contra 1
    je tres ;si el valor de exc = 1, ve a opcionUno, sino, continua
    ; AQUI SE LLEGA AL 'DEFAULT', cuando no encuentra un caso para resolver (ecx != 1|2|3)...
    jmp def
    
uno:
    mov ecx,msgUno    ;se lee el buffer con el mensaje
    mov edx,len ;len contiene la longitud a escribir
    jmp imprimir    ;se va a la función de imprimir


dos:
    mov edx,len ;len contiene la longitud a escribir
    mov ecx,msgDos    ;se lee el buffer con el mensaje
    jmp imprimir    ;se va a la función de imprimir

tres:
    mov edx,len ;len contiene la longitud a escribir
    mov ecx,msgTres    ;se lee el buffer con el mensaje
    jmp imprimir    ;se va a la función de imprimir

def:
    mov edx,len2 ;len2 contiene la longitud a escribir
    mov ecx,msgDefault    ;se lee el buffer con el mensaje
    jmp imprimir    ;se va a la función de imprimir

imprimir:
    mov eax,4        ;llama a imprimir
    mov ebx,1
    int 0x80    ; llamada al sistema para mandar a pantalla el mensaje
    jmp salir
salir:
    mov eax,1   ;se indica que se sys_call = 1 para salir del programa
    mov ebx,0
    int 0x80    ;llamada al kernel para salir 

section .data
    msgUno db 'Op 1',0xa
    msgDos db 'Op 2',0xa
    msgTres db 'Op 3',0xa
    len equ $ - msgTres
    msgDefault db 'Default',0xa
    len2 equ $ - msgDefault