# Rails Avanzado
Alumno: *@Franklin Espinoza Pari*
- - -
## Rutas REST para asociaciones
¿Cómo debemos referirnos, de manera REST, a las acciones asociadas a las críticas de películas? En particular, al menos cuando creamos o modificamos una crítica, necesitamos una manera de enlazarla con un usuario y una película. Presumiblemente, el espectador será el `@current_user`. Pero, ¿qué pasa con la película?

Como sólo tiene sentido crear una reseña cuando tienes una película en mente, la funcionalidad "Create Review" estará accesible a través de un botón o enlace en la página de detalles de una película dada, "Show Movie Details". Por tanto, en el momento en que mostramos este control, sabemos a qué película va a estar asociada la crítica. La cuestión es cómo hacer llegar esta información a los métodos new o create en el controlador `ReviewsController`.

Una forma es, cuando el usuario visita la página de detalles de una película, usar el objeto `session[]`(que persiste entre peticiones) para ***recordar el ID de la película*** cuyos detalles acabamos de ver, pasando a considerarla la película actual (current movie). Cuando se llama a `ReviewsController#new`, recuperaremos el ID del objeto session[] y lo asociaremos con la crítica poblando una campo de formulario escondido en esta reseña, que a su vez estará disponible en `ReviewsController#create` .

**Pregunta**: ¿Este enfoque es de tipo REST? ¿por qué?
Al utilizar un objeto `session[]` este nos ayuda a recordar la pelicula por su ID, esto no es un enfoque de rails completamente, ya que API REST tiene restricciones de arquitectura en una de ellas es el `Desacoplamiento cliente-servidor`. Este nos dice que cada recurso es unico y debe pasarse toda la informacion a usar a la URI. Entonces seria un enfoque API REST si incluimos el ID de la pelicula a la URI al acceder a la pagina para poder crear la reseña.
- - -
La siguiente modificaciòn en las rutas, sigue el principio REST `Arquitectura del sistema en capas`. Este sostiene que las llamadas y respuestas en las API REST deben pasar por diferentes capas. En la modificacion anidamos o asociamos cada critica a una pelicula en especifico. 
```
/movies para las películas.
/movies/:movie_id/reviews para las críticas asociadas a una película específica.
```
***Modificacion*** 
```ruby
# in routes.rb, change the line 'resources :movies' to:
resources :movies do
resources :reviews
end
```
- - -
Ejercicio: El código muestra un pequeño ejemplo de estas rutas anidadas para la creación de vistas y acciones asociadas a una nueva crítica. Explica su funcionamiento.
```ruby
class ReviewsController < ApplicationController
    before_filter :has_moviegoer_and_movie , :only => [:new, :create]
    protected
    def has_moviegoer_and_movie
        unless @current_user
            flash[:warning] = 'You must be logged in to create a review.'
            redirect_to login_path
        end
        unless (@movie = Movie.where(:id => params[:movie_id]))
            flash[:warning] = 'Review must be for an existing movie.'
            redirect_to movies_path
        end
    end

    public
    def new
        @review = @movie.reviews.build
    end

    def create
    # since moviegoer_id is a protected attribute that won't get
    # assigned by the mass-assignment from params[:review], we set it
    # by using the << method on the association. We could also
    # set it manually with review.moviegoer = @current_user.
    @current_user.reviews << @movie.reviews.build(params[:review])
    redirect_to movie_path(@movie)
    end
end
```
Primero tenemos que crear nuestro controlador para las criticas. Para esto ejecutamos el siguiente codigo `rails generate controller reviews`.

**Explicaciòn**: Se crea un controlador para la asignaciòn de criticas a cada pelicula. Observamos que se realiza un filtro que nos dice que ejecutaremos la funcion protegida definida màs abajo `has_moviegoer_and_movie` antes de las acciones `new, create` en este controlador. La funciòn definida `has_moviegoer_and_movie` nos indica que si el usuario no està autenticado o si la pelicula proporcionada por los parametros `params[:movie_id]` de la pelicula id realmente no existe, entonces para ambos casos se mandarà un mensaje de advertencia `flash` y redigirira a `login_path` o `movies_path` respectivamente. Luego se observa el metodo `new`, este se encarga de crear un formulario para crear una nueva reseña y se guarda en una varibale de instancia `@review`. Finalmente tenemos el mètodo `create` que nos crea la critica o reseña.Este toma los parametros que se registro y se obtiene usando `params[:review]`, este se crea asociada a la pelicula `@movie` y se agrega esta nueva reseña al usuario actual.
- - -
Ejercicio: Extiende el código del controlador anterior con los métodos edit y update para las críticas. Usea un filtro de controlador para asegurarse de que un usuario sólo puede editar o actualizar sus propias críticas.

