# AJAX: Asynchronous JavaScript y XML
***by Franklin Espinoza P. 20210135D***
Parte 1
El paso 1 necesita que identifiquemos o creemos una nueva acción de controlador que será la encargada de gestionar la petición. Usaremos la acción ya existente MoviesController#show, por lo que no necesitaremos definir una nueva ruta. Esta decisión de diseño es justificable, dado que la versión AJAX de la acción realiza la misma función que la versión original, es decir, la acción REST de mostrar (show).

Modifica la acción show de forma que, si está respondiendo a una petición AJAX, procesará la sencilla vista parcial el código siguiente en lugar de la vista completa.

