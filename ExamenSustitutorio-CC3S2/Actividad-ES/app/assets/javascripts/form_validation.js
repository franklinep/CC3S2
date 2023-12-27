$(function() {
  // Adjuntar evento submit al formulario
  $('#new_movie').submit(function(event) {
    // Obtener el valor del campo de título
    var title = $('#movie_title').val();

    // Validar el campo de título
    if (title === '') {
      // Mostrar mensaje de error
      $('#movie_title').addClass('is-invalid');
      $('#title-error').text('El título es obligatorio.');
      
      // Detener el envío del formulario
      event.preventDefault();
    }
  });
});