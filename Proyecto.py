#Para que el programa funcione correctamente, es mejor que el programa se corra en consola
import math
import random
import os
#Borrar pantalla de la consola
def clr():
    os.system("clear") if os.name == 'posix' else os.system("cls")
#La función crea la primer fila de la tabla, tomando el primer número que se pide y sacando sus múltiplos.
def encabezado(num1):
    multiplos = []
    for i in range (1,11):
        multiplos.append(i*num1)
    multiplos.insert(0,'')
    return multiplos
#Esta función crea una matriz que contiene las filas de las tabla, de la segunda fila hasta el final.
#Recibe el 2do número introducido, genera sus múltiplos y los va insertando uno a uno al inicio de cada fila.
#Los demás números son los resultados de las operacioners.
def listas_resultados(num2):
    renglones = []
    for i in range (1,11):
        fila = []
        multiplo = i*num2
        fila.append(multiplo)
        for columna in range (10):
            num_columna = lista1[columna+1]
            if simbolo == '+':
                fila.append(num_columna + multiplo)
            elif simbolo == '-':
                fila.append(num_columna - multiplo)
            elif simbolo == '*':
                fila.append(num_columna * multiplo)
            else:
                fila.append(math.trunc(num_columna / multiplo))
        renglones.append(fila)
    return(renglones)
#Esta función hace algo similar a la función 'listas_resultados', la única diferencia es que en vez de guardar los resultados
#de las operaciones en las filas, guarda "|". Para que estos símbolos sean reemplazados cuando el usuario ingrese su resultado.
def listas_blanco(num2):
    renglones = []
    for i in range (1,11):
        fila = []
        multiplo = i*num2
        fila.append(multiplo)
        for columna in range (10):
            num_columna = lista1[columna+1]
            fila.append('|')
        renglones.append(fila)
    return(renglones)
#La función crea una matriz llena con los resultados de las operaciones.
#Los resultados que el usuario ingrese se compararán con los de esta matriz para determinar si es correcto o incorrecto.
#La función recibe la lista de 'encabezados' y la matriz que contiene los resultados de las operaciones. 
def matriz(lista1, lista2):
    matriz = [lista1, lista2]
    return matriz
#Esta funcion crea una matriz con la lista de 'encabezados' y la matriz en blanco.
#Esta matriz es la que se mostrará en pantalla, donde irán apareciendo los resultados que ingrese el usuario.
def matriz_blanco(lista1, lista2):
    matriz = [lista1, lista2]
    return matriz
#La función recibe la matriz en blanco y la imprime elemento por elemento, dándole formato de tabla.
def imprimir_tabla(matriz):
    for elemento in matriz[0]:
        print(str(elemento).ljust(6), end = '')
    print()
    for fila in matriz[1]:
        print()
        for columna in fila:
            print(str(columna).ljust(6), end ='')
        print()
#La función imprime el encabezado del tipo de operación que se haya escogido.
#Toma como parámetro el signo que el usuario haya ingresado.
def operaciones(operacion):
    if operacion.strip() == '+':
        print('''------------------------------- Suma --------------------------- ''')
    elif operacion.strip() == '-':
        print('''------------------------------ Resta --------------------------- ''')
    elif operacion.strip() == '*':
        print('''-------------------------- Multiplicación ---------------------- ''')
    else:
        print('''----------------------------- División ------------------------- ''')
#Esta función imprime la pantalla principal, donde se presenta el nombre del juego, el logo del Tec y el nombre del autor.
#Después pide un enter para cambiar de pantalla, en la cual se muestran las intrucciones del juego.
def pantalla_principal():
    print('''
 
    @@@@   @@@@            /@&   @@#           @@@   #@&  #@@#
    @@&@% @@%@@  .%@@@&/  %@@@%  @@##@@/       @@@  %@@@% *@@*
    @@*@@,@@*@@       @@&  @@&   @@@ %@@       @@@   @@@   @@ 
    @@ *@@@/ @@  @@@/.@@&  @@&   @@# *@@       @@@   @@&   ,, 
    @@  @@&  @@  @@@@@@@&  @@@@  @@# *@@       @@@   @@@@  @@ 

 --------------------- Bienvenido a Math It! ---------------------

                           %&&&&,&&&&&%         
                       %&&&&&&&&  &&( &&&&%      
                     &&&&&&&&&,  (&   &&&&&&%    
                   %&&&&&&&&,   &,   & %&&&&&&%  
                  &&&&&&&&   .&.   &/  &&, &&&&% 
                 %&&&&&&   .&    &*   &%  ,&&&&&%
                %&&&&&&  ,&    &*   &%   &&&&&&&&%
                %&&&&&&  &(  .&    %   %& ,&&&&&&%
                %&&&&&& %#  &*   &*  %&%   &&&&&&%
                %&&&&&&&(% &   &&   &%   &&&&&&&&%
                 %&&&&&&&&&&  &&  &&.  &&&&&&&&&%
                  %&&&&&&&&& %&& &&& *&&&&&&&&&%
                   %&&&&&&&&&&&&&%&&&&&&&&&&&&%  
                     %&&&*               #&&&%    
                       %&&&%.        .%&&&&%
                          %&&&&$,  &&&&%$
 
 ----------------- Created by: Leonardo Galindo ------------------
''')
    input(''' ----------------- Preiona Enter para continuar ------------------''')
    clr()
    print('''           
 ------------------------ ¿Cómo se juega? ------------------------

    El objetivo de este juego es que te diviertas mientras
    practicas operaciones aritméticas básicas.

    Las instrucciones son simples:

    1. Ingresa 2 números y el tipo de operación que quieras
    practicar.

    2. Deberás ingresar el resultado del lugar que se indica
    (aparecerá el símbolo de la operación).

    3. Si te equivocas en el resultado podrás volver a
    intentarlo.

    *Todos los resultados son enteros. Ejemplo: 20 / 7 = 2.85.
    El resultado es "2".

    *Tendrás 5 vidas. Si te equivocas podrás volver a intentarlo,
    pero perderás una vida por cada respuesta incorrecta.
    
    *Se gana al llegar a los 20 puntos

''')
    input(''' ----------------- Preiona Enter para continuar ------------------''')   

#Programa principal

#Lo primero que realiza el programa, es limpiar la pantalla y llamar la función que muestra la pantalla de inicio
#y las intrucciones
clr()
pantalla_principal()
#El programa pide los 2 números para generar las matrices. Además tienen un ciclo while, que sirve para validar que los
#números estén dentro del rango de 1 a 10, sino se volverán a pedir.
clr()
num_multiplo1 = int(input('''
 --------------- Introduce un número del 1 al 10 ---------------
                                  '''))
num_multiplo2 = int(input('''
 -------------- Introduce otra número del 1 al 10 -------------- 
                                  '''))
while num_multiplo1 < 1 or num_multiplo1 > 10 or num_multiplo2 < 1 or num_multiplo2 > 10:
    clr()
    print('''
------------------ Introduce números válidos -------------------
''')
    num_multiplo1 = int(input('''
 --------------- Introduce un número del 1 al 10 ---------------
                                  '''))
    num_multiplo2 = int(input('''
 -------------- Introduce otra número del 1 al 10 --------------
                                  '''))
#Se pide el tipo de operación con el que se va a jugar. Si el signo es diferente a (+,-,*,/), el ciclo while se encarga
# de volverlo a pedir
simbolo = input('''
 ------- ¿Qué operación quieres practicar? (+, -, *, /) --------
                                  ''')
while simbolo != '+' and simbolo != '-' and simbolo != '*' and simbolo != '/':
    simbolo = input('''
 ------- ¿Qué operación quieres practicar? (+, -, *, /) --------
                                  ''')
#Con los datos ingresados, se genera la matriz que contiene los resultados y la matriz en blanco.
lista1 = encabezado(num_multiplo1)
lista2 = listas_resultados(num_multiplo2)
lista3 = listas_blanco(num_multiplo2)
tabla_resultados = matriz(lista1, lista2)
tabla_blanco = matriz_blanco(lista1, lista3)
#Se declaran el puntaje en 0, 5 vidas, la variable jugar = 'si', para que entre al ciclo principal del juego.
#El ciclo genera un posición en la tabla y pregunta sobre ese resultado. 
jugar = 'si'
puntaje = 0
vidas = 5
fin = 0
posiciones = []
while jugar.lower() == 'si' or jugar.lower() == 'sí':  
    #Se genera una posición aleatoria de la tabla en blanco, y se le asigna el signo de la operación de se está utiliando.
    posicion = []
    renglon = random.randint(0,9)
    columna = random.randint(1,9)
    #Las posiciones que se van generando, se guardan en un lista
    #para revisar que las nuevas posiciones generadas no se repitan
    posicion.append(renglon)
    posicion.append(columna)
    while posicion not in posiciones:
        posiciones.append(posicion)
        tabla_blanco[1][renglon][columna] = simbolo
        #Se limpia la pantalla  y se imprime el nombre de la operación, la tabla en blanco con el signo, el puntaje,
        #las vidas restantes del jugador, y la pregunta de la operación.
        clr()
        operaciones(simbolo)
        print(f'''
---------------------------- Puntaje: {puntaje} ------------------------

------------------------ Vidas restantes: {vidas} --------------------

''')
        imprimir_tabla(tabla_blanco)
    
        print()
        resultado = int(input(f'''
----------------------- ¿Cuánto es {tabla_blanco[0][columna]} {simbolo} {tabla_blanco[1][renglon][0]}? ---------------------
                                 '''))
        #Si el resultado es incorrecto, se resta una vida, se muetra un mensaje de error, y se vuelve a preguntar el resultado.
        while resultado != tabla_resultados[1][renglon][columna]:
            clr()
            vidas -= 1
            #Si el contador de vidas llega a 0, se produce un 'break' y la variable fin se iguala a 1, para que
            # al momento de que esto suceda, también suceda un break en el ciclo principal; mostrando la pantalla final
            # y termiando el juego.
            if vidas == 0:
                fin = 1
                break
            else:
                operaciones(simbolo)
                print(f'''
---------------------------- Puntaje: {puntaje} ------------------------

------------------------ Vidas restantes: {vidas} --------------------
''')
                imprimir_tabla(tabla_blanco)
                print(f'''
----------------------- Inténtalo de nuevo ----------------------
                         
                         %%           %%  
                        %%%%%%       %%%%%%
                         %%%%%%%   %%%%%%% 
                           %%%%%%%%%%%%%   
                             %%%%%%%%%     
                             %%%%%%%%%     
                           %%%%%%%%%%%%%   
                         %%%%%%%   %%%%%%% 
                        %%%%%%       %%%%%%
                          %%            %%
''')
                resultado = int(input(f'''
----------------------- ¿Cuánto es {tabla_blanco[0][columna]} {simbolo} {tabla_blanco[1][renglon][0]}? ----------------------
                                 '''))
        #Esta variable 'fin' indica si el juego terminó. Si el juego continua, se suma 1 al puntaje y se muestra el resultado
        # en la tabla. Poniendo también un mensaje de retroalimentación y preguntando si se quiere seguir jugando.
        if fin == 1:
            break
        else:
            clr()
            puntaje += 1
            tabla_blanco[1][renglon][columna] = resultado
            #Si el jugador obtiene 20 puntos, el ciclo termina y el usuario gana.
            if puntaje == 20:
                fin = 1
                break
            else:
                operaciones(simbolo)
                print(f'''
---------------------------- Puntaje: {puntaje} ------------------------

----------------------- Vidas restantes: {vidas} ---------------------
''')
                imprimir_tabla(tabla_blanco)
                print()
                print(f''' 
 --------------------------- ¡Muy bien! -------------------------
                                           @@  
                                         @@    
                                       @@.     
                                     @@@       
                            &@@@   (@@         
                              @@@ @@@          
                               @@@@@           
                                @@
''')
                #Si el usuario escirbe 'no', el ciclo termina, dando fin al juego.
                jugar = input('''
----------------- ¿Quieres seguir jugando? (si/no) --------------
                                 ''')
                clr()
    if fin == 1:
        break

#Finalmente se limpia la pantalla y se muestra la pantalla final.
#Se muestra el nombre del juego 'Math It!', el puntaje final y las vidas restantes, la tabla con los resultados
#que el usuario ingrasó, y un pequeño mensaje de retroalimentación.
clr()
print(f'''

    @@@@   @@@@            /@&   @@#           @@@   #@&  #@@#
    @@&@% @@%@@  .%@@@&/  %@@@%  @@##@@/       @@@  %@@@% *@@*
    @@*@@,@@*@@       @@&  @@&   @@@ %@@       @@@   @@@   @@ 
    @@ *@@@/ @@  @@@/.@@&  @@&   @@# *@@       @@@   @@&   ,, 
    @@  @@&  @@  @@@@@@@&  @@@@  @@# *@@       @@@   @@@@  @@
''')
if puntaje == 20:
    print('''
 ------------------------ ¡Felicidades! -------------------------

''')
print(f'''  
 ----------------------- Puntaje final: {puntaje} -----------------------
 
 ---------------------- Vidas restantes: {vidas} ----------------------
 
''')
imprimir_tabla(tabla_blanco)
print(f'''

 ------------------ ¡Espero te hayas divertido! ------------------
 
 ''')
