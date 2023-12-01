***by @Franklin Espinoza Pari***
# Parte 2

## Crearemos una aplicacion en Rails

![imagen_1](/Parte_2/assets/imagen_1.png)

## Creamos la clase todo

![imagen_2](/Parte_2/assets/imagen_2.png)

# Base de datos

## Realizando la migracion
Realizaremos la creacion y la aplicacion de una migracion. que es la migracion? Este es un script en Ruby que describe un conjunto de cambios a realizar en el esquema de la base de datos. El que nos facilita esa tarea viene con el siguiente comando:

![imagen_3](/Parte_2/assets/imagen_3.png)

## Insertando registros en la db

![imagen_4](/Parte_2/assets/imagen_4.png)

Ejecutamos el comando `rails db:seed`
Verificamos en la consola rails

![imagen_5](/Parte_2/assets/imagen_5.png)

Mostramos las rutas generadas por scaffold

![imagen_6](/Parte_2/assets/imagen_6.png)

## Mas migraciones

Con el comando `rails generate migration fecha_vencimiento fecha:date` crearemos la migracion para hacer los cambios de la primera migracion que hicimos, anadiendo la fecha de tipo date.

![imagen_8](/Parte_2/assets/imagen_8.png)

Hacemos las validaciones correspondientes, creando la funcion `fecha_vencida?`

![imagen_7](/Parte_2/assets/imagen_7.png)

Ejecutamos el siguiente comando `rails db:migrate`, y obsevamos que se anadio correctamente

![imagen_9](/Parte_2/assets/imagen_9.png)

s





