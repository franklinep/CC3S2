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
Digamos que nos dan el modelo de `User` de la siguiente manera:  

```
class User < ActiveRecord::Base 

    validates :username, :presence => true 

    validate :username_format 

end 
```
1. Qué pasa si tenemos `@user` sin nombre de usuario y llamamos a `@user.valid`?? ¿Qué guardará `@user.save`?

Si `@user` no tiene un nombre de usuario y llamamos a @user.valid?, nos va retornar `false` porque la validación de presencia para username no se cumple. Si luego llamamos a `@user.save`, no guardará el objeto en la base de datos porque el objeto no es válido.

2. Implementa `username_format`. Para los propósitos, un nombre de usuario comienza con una letra y tiene como máximo 10 caracteres de largo. Recuerda, las validaciones personalizadas agregan un mensaje a la colección de errores. 

Se muestra a continuacion la implementacion.
```
class User < ActiveRecord::Base
    validates :username, presence: true
    validate :username_format

    private

    def username_format
        unless username =~ /\A[a-zA-Z][a-zA-Z0-9_]{,9}\z/
            errors.add(:username, 'debe comenzar con una letra y tener máximo 10 caracteres de largo')
        end
    end

end
```
Creamos una funcion privada `username_format`. Usaremos la palabra clave `unless` para validar que si es que se ingresa un usuario el cual no se ajusta con que comienze con una letra y que tenga como maximo 10 caracteres, entonces nos enviara un mensaje de error.

## Pregunta 3
Recuerda, los filtros nos ayudan a verificar si ciertas condiciones se cumplen antes de permitir que se ejecute una acción del controlador. Para el modelo de User, digamos que queremos verificar si @user era administrador de todos los métodos en AdminController. Completa el método before_filter:check_admin a continuación que verifica si el campo de administrador en @user es verdadero. De lo contrario, redirija a la página admin_login con un mensaje que indica acceso restringido. 

```
class AdminController < ApplicationController 

  	    before_filter :check_admin 

      # Completa el codigo 
```

Solucion, vamos a completar el codigo anterior de la siguiente manera.
```
class AdminController < ApplicationController
    before_action :check_admin

    private

    def check_admin
        unless @user&.admin?
            redirect_to admin_login_path, alert: 'Acceso restringido.'
        end
    end

end
```

Definimos un metodo privado `check_admin`, este quiere decir que no se puede hacer uso del mismo fuera de la clase. Luego vamos a volver a utilizar la palabra clave `unless` donde vamos a verificar que el usuario exsita y ademas que tenga un metodo `admin`. Si estas condiciones no se cumplen, el usuario se redirige a la página de inicio (`redirect_to admin_login_path`) de sesión del administrador con un mensaje de alerta (`alert: 'Acceso restringido.'`).

4.  AJAX (JavaScript y XML asíncronos) es un grupo de herramientas y técnicas para el desarrollo de aplicaciones web asíncronas. El objetivo de AJAX es que la comunicación entre una aplicación y el servidor de datos (es decir, solicitudes HTTP) no interfiera con la experiencia, la visualización y el comportamiento de la aplicación. A continuación, se te proporciona un formulario que simula el inicio de sesión. Comprueba si la combinación de nombre de usuario y contraseña funciona junto con la cuenta, si la hay. Para hacer eso, queremos que se realice una solicitud HTTP POST cuando se envíe este formulario. Escribe tu solución con jQuery y comenta dónde debe ubicarse la función de devolución de llamada (callback). Comprueba tus resultados. 