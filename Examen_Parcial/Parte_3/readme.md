***by @Franklin Espinoza Pari***
# Parte 3 : Ruby on Rails
## Clonar el repositorio en Rails
Clonaremos el repositorio que fue creado en base a Rails con el siguiente comando `git clone https://github.com/saasbook/hw-rails-wordguesser.git`
## Preguntas N1
* Cual es el objetivo de ejecutar bundle install?
Lo que se busca al ejecutar el comando `bundle install` es instalar las gemas necesarias para nuestra aplicacion. Estas gemas pueden ser dependientes una de otras por lo que vera en la instalacion mas gemas instalandose.
* Por que es una buena practica especificar `-without production` al ejecutarlo en su computadora de desarrollo?
Este comando `-without production` lo usamos en la calificada N2 del curso. Por que? Como sabemos existen 3 entornos `Production`, `Test` y `Development`, y nosotros podemos especificar las gemas a usar en el archivo `Gemfile`. Este comando se utiliza con el objetivo de evitar las instalaciones de las gemas que se utilizaran en el entorno `Production`, ya que recordemos que nosotros trabajamos el desarrollo de nuestra aplicacion en el entorno `Development`.
* asidagnasfaskn

Podemos observar la aplicacion corriendo en el servidor, localhost. Ejecutamos con el mando `rails server`.

## Preguntas N2
* ¿En que parte de la estructura del directorio de la aplicacion Rails esta el codigo correspondiente al modelo WordGuesserGame?

El modelo wordGuesserGame en la aplicacion Rails se encuentra en el directorio `/app/models/word_guesser_game.rb`. En la aplicacion en Sinatra que realizamos el modelo se manejo en `/lib/wordguesser_game.rb`. En el modelo se encuentran funciones como `guess(letter)`, etc.. que definen la logica de la aplicacion.

* ¿En qué archivo está el código que más se corresponde con la lógica del archivo `app.rb` de las aplicaciones Sinatra que maneja las acciones entrantes del usuario?

En el archivo `/config/aplication.rb` 

* ¿Qué clase contiene ese código?
La clase que contiene el codigo es `Class Application`, este se especifica en el archivo `/config.ru`. 

* ¿De qué otra clase (que es parte del framework Rails) hereda esa clase?
La clase `Class Application` hereda de la clase `Rails::Application`.

* ¿En qué directorio está el código correspondiente a las vistas de la aplicación Sinatra (new.erb, show.erb, etc.)?

El directorio donde estan las vistas en la aplicacion Rails es el siguiente `/app/views/game/`, dentro de este directorio podemos hallar los siguientes templates: `lose.html.erb`, `new.html.erb`, `show.html.erb` y `win.html.erb`.

* Los sufijos de nombre de archivo para estas vistas son diferentes en Rails que en la aplicación Sinatra. ¿Qué información proporciona el sufijo situado más a la derecha del nombre del archivo (por ejemplo: en foobar.abc.xyz, el sufijo .xyz) sobre el contenido del archivo?

Como se puede observar en las vistas anteriores mencionadas, luego de la extensión `.html` aparece la extensión `.erb`, esta extensión hace referencia al formato del template engine que se está usando. Basicamente el template engine `ERB` permite mezclar codigo ruby con codigo `HTML`.

* ¿Qué información te brinda el otro sufijo sobre lo que se le pide a Rails que haga con el archivo?

El otro sufijo `.html` es el formato `HTML` que son generalmente usadas para las vistas, este nos permite hacer uso de la sintaxis del lenguaje de marcado `html`.

* ¿En qué archivo está la información de la aplicación Rails que asigna rutas (por ejemplo, GET/new) a las acciones del controlador?

El archivo `/config/routes.rb`, es el que define las rutas con los distintos metodos CRUDI en rails. Podras observar el metodo `get` y `post` en el archivo. Esta son las rutas que los controladores haran uso. 
 
* ¿Cuál es el papel de la opción :as => 'name' en las declaraciones de ruta de config/routes.rb?

Es una forma de nombrar en el URI las funciones del servidor para el cliente.

# Preguntas N3
* En la versión de Sinatra, los bloques before do...end y after do...end se utilizan para la gestión de sesiones. ¿Cuál es el equivalente más cercano en esta aplicación Rails y en qué archivo encontramos el código que lo hace?

Estos bloques se utilizaron para poder hacer gestion de las sesiones. El equivalente en la aplicacion Rails es el siguiente `before_action :get_game_from_session` y `after_action  :store_game_in_session`. Estos se encuentran en el archivo del directorio `/app/controllers/game_controller.rb`.

Observamos a continuacion el codigo en ambas aplicaciones Rails y Sinatra

**Rails**
 
 ~~~ruby
def get_game_from_session
    @game = WordGuesserGame.new('')
    if !session[:game].blank?
        @game = YAML.load(session[:game])
    end
    end

  def store_game_in_session
    session[:game] = @game.to_yaml
  end
~~~

**Sinatra**

~~~ruby
before do
    @game = session[:game] || WordGuesserGame.new('')
end
  
after do
    session[:game] = @game
end
~~~

* Un formato de serialización popular para intercambiar datos entre aplicaciones web es JSON. ¿Por qué no funcionaría utilizar JSON en lugar de YAML? (Reemplaza YAML.load() con JSON.parse() y .to_yaml con .to_json para realizar esta prueba. Tendrás que borrar las cookies asociadas con localhost:3000 o reiniciar tu navegador con un nuevo Incognito/ Ventana de navegación privada, para borrar la sesión[]. Según los mensajes de error que recibe al intentar utilizar la serialización JSON, debería poder explicar por qué la serialización YAML funciona en este caso pero JSON no).

# Preguntas N4

* En la versión de Sinatra, cada acción del controlador termina con redirect (que, como puedes ver, se convierte en redirección_to en Rails) para redirigir al jugador a otra acción, o con erb para representar una vista. ¿Por qué no hay llamadas explícitas correspondientes a erb en la versión Rails?

En Rails existen convenciones, y son gracias a estas que las llamadas explicitas a `erb` no son necesarias.

* En la versión de Sinatra, codificamos directamente un formulario HTML usando la etiqueta <form>, mientras que en la versión de Rails usamos un método Rails form_tag, aunque sería perfectamente legal usar etiquetas HTML <form> sin formato en Rails. ¿Se te ocurre alguna razón por la que Rails podría introducir este "nivel de direccionamiento indirecto"?


* ¿Cómo se manejan los elementos del formulario, como campos de texto y botones, en Rails? (Nuevamente, el HTML sin formato sería legal, pero ¿cuál es la motivación detrás de la forma en que Rails lo hace?)

Los campos de texto se manejan con `text_field_tag` y los botones se manejan con `submit_tag`, el uso de estos y mas, se debe a la mejora de productividad,seguridad, etc. ademas de mejorar la coherencia de la estrucutra del codigo.

* En la versión de Sinatra, las vistas de show, win y lose reutilizan el código en la vista new que ofrece un botón para iniciar un nuevo juego. ¿Qué mecanismo de Rails permite reutilizar esas vistas en la versión de Rails?









