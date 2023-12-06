# Practica Calificada 5
- - - 
* Franklin Espinoza Pari 20210135D
- - -
## Preguntas (Parte 01):
1. En las actividades relacionados a la Introducción de Rails los métodos actuales del controlador no son muy robustos: si el usuario introduce de manera manual un URI para ver (Show) una película que no existe (por ejemplo /movies/99999), verás un mensaje de excepción horrible. Modifica el método show del controlador para que, si se pide una película que no existe, el usuario sea redirigido a la vista Index con un mensaje más amigable explicando que no existe ninguna película con ese.     En las actividades relacionados a la Introducción de Rails los métodos actuales del controlador no son muy robustos: si el usuario introduce de manera manual un URI para ver (Show) una película que no existe (por ejemplo /movies/99999), verás un mensaje de excepción horrible. Modifica el método show del controlador para que, si se pide una película que no existe, el usuario sea redirigido a la vista Index con un mensaje más amigable explicando que no existe ninguna película con ese. En las actividades relacionados a la Introducción de Rails los métodos actuales del controlador no son muy robustos: si el usuario introduce de manera manual un URI para ver (Show) una película que no existe (por ejemplo /movies/99999), verás un mensaje de excepción horrible. Modifica el método show del controlador para que, si se pide una película que no existe, el usuario sea redirigido a la vista Index con un mensaje más amigable explicando que no existe ninguna película con ese. 


***Respuesta:***
i. Vamos a clonar el repositorio realizado en clase.

ii. Vamos a verificar si existe la pelicula con el id de parametro utilizando `rescue ActiveRecord::RecordNotFound`. Se genera cuando Active Record no puede 
encontrar un registro mediante una `id` dado.

iii. Luego, utilizaremos el `flash[:notice]` para mandar un mensaje mas amigable a la excepcion. De ser este el caso, vamos a redirigir a la vista `index` con `redicrect_to movies_path`.

Al querer ingresar al registro con id `/999`, este al no existir nos manda un error horrible. Sin embargo; ahora nos redigira a la vista `index` y lanzara un mensaje mas amigable.

![f1](img/f1.png)

Podemos observar en la consola lo siguiente:
![f2](img/f2.png)

2. En las actividades relacionados a Rails Avanzado, si tenemos el siguiente ejemplo de código que muestra cómo se integra OmniAuth en una aplicación Rails:

~~~ruby
class SessionsController < ApplicationController
    def create
        @user = User.find_or_create_from_auth_hash(auth_hash)
        self.current_user = @user
        redirect_to '/'
        end
    protected
    def auth_hash
        request.env['omniauth.auth']
        end
    end
~~~

***Respuesta:***

Debido a que sera utilizado varias veces, definimos un metodo con el `request.env['omniauth.auth']` para autorizar a mi aplicacion Rails con `OAuth`. Hacemos uso del metodo para la reutilizacion de codigo, una mejor claridad, y legibilidad. Del mismo modo, si queremos agregar lineas de codigo o modificar la logica pordemos hacerlo solamente cambiando el metodo `auto_hash`.

3. En las actividades relacionados a JavaScript, Siguiendo la estrategia del ejemplo de jQuery utiliza JavaScript para implementar un conjunto de casillas de verificación (checkboxes) para la página que muestra la lista de películas, una por cada calificación (G, PG, etcétera), que permitan que las películas correspondientes permanezcan en la lista cuando están marcadas. Cuando se carga la página por primera vez, deben estar marcadas todas; desmarcar alguna de ellas debe esconder las películas con la clasificación a la que haga referencia la casilla desactivada.

***Respuesta:***

Para esta actividad vamos a clonar la actividad realizada para Javascript. Luego, nos ubicamos a la pagina que muestra la lista de peliculas, es decir la vista `index`. El objetivo es implementar un conjunto de checkboxes para cada calificacion (G, PG, ...) y estas tienen que estar todas marcadas al principio.

Vamos agregar la siguiente linea de codigo en la vista:

![f3](img/f3.png)


Le decimos que para cada calificacion, crearemos un checkbox `check_box_tag`.
~~~erb
<% Movie.all_ratings.each do |rating| %>
      <div class="form-check form-check-inline">
        <%= label_tag "ratings[#{rating}]", rating, class: 'form-check-label' %>
        <%= check_box_tag "ratings[#{rating}]", "1", @ratings_to_show.nil? ? true : @ratings_to_show>
      </div>
    <% end %>
~~~

![f4](img/f4.png)



