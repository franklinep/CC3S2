# Final
## Parte 1
### Pregunta 1
Produce un conflicto de fusión (merge) en algún repositorio de tus actividades realizadas. Establece los pasos y comandos que usas para resolver un conflicto de fusión en Git. Si intentas git push y falla con un mensaje como : Non-fast-forward (error): failed to push some refs esto significa que algún archivo contiene un conflicto de fusión entre la versión de tu repositorio y la versión del repositorio origen. Para este ejercicio debes presentar el conflicto dado, los pasos y comandos para resolver el problema y las solución. 

Primero creamos una nueva rama, pero hay que asegurarnos que nos encontramos en la rama `main`.

![](img/f1.png)

Vamos ahora a crear una nueva rama sobre la principal, en este caso vamos a modificar unas lineas de codigo de la actividad `Ruby On Rails Avanzado`. Utilizamos el comando `git branch roger`. Este nos crear una rama nombrada `roger`.

![](img/f2.png)

Ahora vamos a movernos a esa rama utilizando el comando `git checkout roger`.

![](img/f3.png)

 Para luego realizar los cambios en nuestro local, sobre la actividad mencionada. Lo que vamos a modificar sera la version de la gema ruby sobre el proyecto que se encuentra en el archivo `Gemfile`.
 Una vez hecho los cambios, vamos a realizar un commit a los cambios. Ahora vamos a movernos a la rama `main` y vamos a modificar la misma linea cambiando la version de ruby a `ruby 3.2.2`. Luego volvemos a nuestro branch `roger` y realizamos un merge.

 ![](img/f6.png)

 ![](img/f7.png)
Como podemos observar, existe un merge conflict por lo que nuestro merge falla. Para resolverlos, vamos a editar el archivo `Gemfile` manualmente, donde nos quedaremos con la version `3.2.2`.
 
 ![](img/f8.png)

 En el siguiente paso, realizamos un commit y vamos hacer un push sobre la rama principal `main`.

  ![](img/f10.png)

Finalmente, ahora verificamos los cambios en nuestro github

  ![](img/f11.png)


## Pregunta 2

Digamos que nos dan el modelo de User de la siguiente manera:  