## Rutas REST para asociaciones
- - -
¿Cómo debemos referirnos, de manera REST, a las acciones asociadas a las críticas de películas? En particular, al menos cuando creamos o modificamos una crítica, necesitamos una manera de enlazarla con un usuario y una película. Presumiblemente, el espectador será el `@current_user`. Pero, ¿qué pasa con la película?

Como sólo tiene sentido crear una reseña cuando tienes una película en mente, la funcionalidad "Create Review" estará accesible a través de un botón o enlace en la página de detalles de una película dada, "Show Movie Details". Por tanto, en el momento en que mostramos este control, sabemos a qué película va a estar asociada la crítica. La cuestión es cómo hacer llegar esta información a los métodos new o create en el controlador `ReviewsController`.

Una forma es, cuando el usuario visita la página de detalles de una película, usar el objeto `session[]`(que persiste entre peticiones) para ***recordar el ID de la película*** cuyos detalles acabamos de ver, pasando a considerarla la película actual (current movie). Cuando se llama a `ReviewsController#new`, recuperaremos el ID del objeto session[] y lo asociaremos con la crítica poblando una campo de formulario escondido en esta reseña, que a su vez estará disponible en `ReviewsController#create` .

**Pregunta**: ¿Este enfoque es de tipo REST? ¿por qué?

Al utilizar un objeto `session[]` este nos ayuda a recordar la pelicula por su ID, esto no es un enfoque de rails completamente, ya que API REST tiene restricciones de arquitectura en una de ellas es el `sin estado`, este dice que la API REST no requiere ninguna sesion del lado del servidor. Este nos dice que cada recurso es unico y debe pasarse toda la informacion a usar a la URI. Entonces seria un enfoque API REST si incluimos el ID de la pelicula a la URI al acceder a la pagina para poder crear la reseña.