# Testing Java Script y Ajax
Vamos agregar la gema `gem 'jasmine-rails'` a nuestro gemfile, ejecutaremos `bundle install`.

![0](img/0.png)

Luego vamos a ejecutar el siguiente comando generador de rails `rails generate jasmine:install`.

![1](img/1.png)

El generador creara el archivo de configuracion llamado `jasmine.yml`, en `spec/javascript/support`. El archivo `jasmine.yml` tiene configuraciones sobre que archivos deberian ser cargados a la hora de cargar la pagina que ejecuta las pruebas. A continuacion, se muestra el contenido del archivo `jasmine.yml`.
~~~yml
# src_files
#
# Return an array of filepaths relative to src_dir to include before jasmine specs.
# Default: []
#
# EXAMPLE:
#
# src_files:
#   - lib/source1.js
#   - lib/source2.js
#   - 'dist/**/*.js'
#
src_files:
  - assets/application.js

# stylesheets
#
# Return an array of stylesheet filepaths relative to src_dir to include before jasmine specs.
# Default: []
#
# EXAMPLE:
#
# stylesheets:
#   - css/style.css
#   - 'stylesheets/*.css'
#
stylesheets:
  - assets/application.css

# helpers
#
# Return an array of filepaths relative to spec_dir to include before jasmine specs.
# Default: ["helpers/**/*.js"]
#
# EXAMPLE:
#
# helpers:
#   - 'helpers/**/*.js'
#
helpers:
  - 'helpers/**/*.js'

# spec_files
#
# Return an array of filepaths relative to spec_dir to include.
# Default: ["**/*[sS]pec.js"]
#
# EXAMPLE:
#
# spec_files:
#   - '**/*[sS]pec.js'
#
spec_files:
  - '**/*[sS]pec.js'

# src_dir
#
# Source directory path. Your src_files must be returned relative to this path. Will use root if left blank.
# Default: project root
#
# EXAMPLE:
#
# src_dir: public
#
src_dir:

# spec_dir
#
# Spec directory path. Your spec_files must be returned relative to this path.
# Default: spec/javascripts
#
# EXAMPLE:
#
# spec_dir: spec/javascripts
#
spec_dir:

# spec_helper
#
# Ruby file that Jasmine server will require before starting.
# Returned relative to your root path
# Default spec/javascripts/support/jasmine_helper.rb
#
# EXAMPLE:
#
# spec_helper: spec/javascripts/support/jasmine_helper.rb
#
spec_helper: spec/javascripts/support/jasmine_helper.rb

# boot_dir
#
# Boot directory path. Your boot_files must be returned relative to this path.
# Default: Built in boot file
#
# EXAMPLE:
#
# boot_dir: spec/javascripts/support/boot
#
boot_dir:

# boot_files
#
# Return an array of filepaths relative to boot_dir to include in order to boot Jasmine
# Default: Built in boot file
#
# EXAMPLE
#
# boot_files:
#   - '**/*.js'
#
boot_files:

# rack_options
#
# Extra options to be passed to the rack server
# by default, Port and AccessLog are passed.
#
# This is an advanced options, and left empty by default
#
# EXAMPLE
#
# rack_options:
#   server: 'thin'

# phantom_cli_options
#
# Extra options to be passed to the phantomjs cli,
# e.g. to enable localStorage in PhantomJs 2.5
#
# EXAMPLE
#
# phantom_cli_options:
#   local-storage-quota: 5000

# random
#
# Run specs in semi-random order.
# Default: true
#
# EXAMPLE:
#
# random: false
#
random:


~~~

Vamos a crear un archivo de prueba simple `spec/javascripts/basic_check_spec.js` con el codigo proporcionado.

![3](img/3.png)

y luego ejecutaremos el comando `rake jasmine` para iniciar un servidor que continua ejecutandose para que podamos visualizarlo con un navegador.

![2](img/2.png)

***Pregunta:*** ¿Cuáles son los problemas que se tiene cuando se debe probar Ajax?. Explica tu respuesta.

Cuando queremos realizar pruebas utilizando el framework de unidad de testeo, `Jasmine`, para nuestro codigo `AJAX`, existe el problema de asincronia. Este se debe a que como sabemos las llamadas `AJAX` son operaciones asincronas, lo que significa que el ejecutador de pruebas de `Jasmine` puede continuar ejecutandose antes que la llamada `AJAX` se complete. Del mismo modo, como sabemos las pruebas `Jasmine` son generalmente de manera sincronica, por lo que necesitamos asegurar que las pruebas esperen el tiempo suficiente para que las llamadas `AJAX` se completen.

