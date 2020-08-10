section .text
global _start

_start:
    mov ecx,0   ;ecx será el índice para la letra que se esté operando dentro de la cadena 
encode:
    mov eax,0   ;eax será un contador para los ciclos de shr y shl
    shiftderecha:                          
        shr byte[cadena + ecx], 1      ;Se corre el caracter actaul a la derecha una vez 
        jc huboCarry                     ;Ve a huboCarry si se perdió un '1' en el shift
        push 0                      ;Si no hay pérdida, sólo se mete un 0 al stack
        jmp cont                    ;Continua el flujo del ciclo
        huboCarry:
            push 1                  ;Se hace un push al stack de 1 para indicar que hubo pérdida
        cont:                       
        inc eax                     ;Se suma a eax la iteración de shr que se hizo sobre el caracter
        cmp eax, 3                  ;Si eax < 3, faltan hacer al menos un shr más
        jne shiftderecha                   ;Por lo que se vuelve a iniciar el ciclo para hacer otro shr
    ;Una vez que se acaba el ciclo de los shr sobre el caracter actual, se pueden realizar las demás operaciones
    rol byte [cadena + ecx],1   ;se hace un rol de 1 para el catacter acutal de la cadena
    add byte [cadena + ecx],2   ;se le suman 2 al caracter actual de la cadena
    ror byte [cadena + ecx],2   ;se hace un ror de 2 para el caracter actual de la cadena
    not byte [cadena + ecx]     ;se aplica el operador NOT al caracter actual de la cadena

    inc ecx ;se incrementa en 1 el contador
    cmp ecx, len-1  ;se compara si el contador es igual al tamaño del string pasado. El -1 es para evitar el salto de linea
    jne encode  ;si no son iguales, regresa al ciclo, si sí, continúa
    ;sale del ciclo cuando acaba el proceso con todas las letras de la cadena

    ;Se imprime el valor de la cadena después de hacer el proceso de encoding
    push ecx
    mov edx,len 
    mov ecx,cadena 
    call imprimir2
    pop ecx

;El proceso de encode, lo hace de izquierda a derecha, pero todo lo que fue registrado dentro del stack, está
;invertido, por lo que si empezamos a hacer pop's del stack, obtendremos el valor del último caracter que fue 
;ingresado al stack y no del primero. El proceso de decode empezará desde el último caracter hasta el primero
;(de derecha a izquierda)para no tener problemas con los pops que se hagan al stack.

decode:
    dec ecx ;se decrementa en 1 el valor de exc
    ;Para hacer el decode, es importante aplicar las operaciones inversas aplicadas en encode
    not byte [cadena + ecx] ;se hace un not del catacter acutal
    rol byte [cadena + ecx],2   ;se hace un rol de 2 al catacter actual
    sub byte [cadena + ecx],2   ;se hace substrae 1 al caracter actual
    ror byte [cadena + ecx],1   ;se hace un ror de 1 al caracter actual
    mov eax,0   ;se hace eax = 0 para reiniciar el valor dentro de las iteraciones en shiftizquierda
    shiftizquierda:                   
        shl byte[cadena + ecx], 1      ;Se corre el caracter actaul a la izquierda una vez
        pop ebx                     ;Se hace un pop del stack y se almacena el valor en ebx
        cmp ebx, 1                  ;Se revisa si el valor popeado es 1
        je esuno                      ;Si sí, ve a esuno
        jmp continuar                   ;Sino, ve a continuar
        esuno:                        
            add byte[cadena + ecx], 1  ;Se suma el bit que fue perdido durante el shr
        continuar:                      ;Etiqueta "continuar 2"
        inc eax                     ;Se suma a eax la iteración de shl que se hizo sobre el caracter
        cmp eax, 3                  ;Si eax < 3, faltan hacer al menos un shl más
        jne shiftizquierda            ;Por lo que se vuelve a iniciar el ciclo para hacer otro shr

    ;Una vez que llegue aquí, ha acabado de hacer todas las operaciones para el caracter actual

    cmp ecx, 0 ; Se compara ecx con 0, si es cero, significa que hemos llegado al inicio de la cadena y que hemos terminado
    jne decode  ;Si aun no es 0, regresa a decode para hacer el proceso con la siguiente letra

    mov edx,len ;Se mueve a edx la longitud del mensaje que será enviado a pantalla
    mov ecx,cadena  ;Se mueve a ecx la cadena que vamos a imprimir 
    jmp imprimir 

imprimir:
    mov eax,4        ;llama a imprimir
    mov ebx,1
    int 0x80    ; llamada al sistema para mandar a pantalla el mensaje
    jmp salir
imprimir2:
    mov eax,4        ;llama a imprimir
    mov ebx,1
    int 0x80    ; llamada al sistema para mandar a pantalla el mensaje
    ret 
salir:
    mov eax,1   ;se indica que se sys_call = 1 para salir del programa
    mov ebx,0
    int 0x80    ;llamada al kernel para salir 

section .data
    cadena db 'Nanapancha de la vuelo a la hilacha', 10
    len equ $- cadena