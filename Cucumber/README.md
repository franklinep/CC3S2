# BDD
1. ¿Cuál es la diferencia entre validación y verificación? Proporciona un ejemplo de cada uno. ¿Qué intenta abordar BDD?

La diferencia entre valicacion y verificacion es que la validacion comprueba el cumplimiento de una expectativa establecida. Por ejemplo, en nuestro formulario se puede insertar una validacion para asegurarse que la fecha ingresada esa menor al año 1992. Por otro lado, la verificacion se refiere al cumplimiento de las especificaciones o requisitos en un sistema. Por ejemplo, la verificacion de un codigo limpio, la verificacion de implementaciones. BDD intenta abordar la validacion, creando escenarios segun las caracteristicas añadidas por los usuarios, para asi lograr un comunicacion con estos mismos y responder sus mejoras.

3. Describe la relación entre `Features`, `Scenarios` y `Steps` en Cucumber.
Los escenarios son definidos en archivos de tipo `.Feature`
* Feature: Un feature describira el test script actual donde serà ejecutada. Se recomienda que sea similar al nombre del archivo feature.
* Scenario: Es un escenario, en el cual se ilustra un ejemplo en concreto sobre como el software deberia comportarse.
* Steps: Tenemos los pasos `Given`, `When` y `Then`. Estos son lineas de codigo que seran ejecutadas por Cucumber.
`src/test/resources/hellocucumber/is_it_friday_yet.feature`
```
Feature: Is it Friday yet?
  Everybody wants to know when it's Friday

  Scenario: Sunday isn't Friday
    Given today is Sunday
    When I ask whether it's Friday yet
    Then I should be told "Nope"
```
4. Cucumber permite que los pasos comiencen con `Given`,`When`, `Then`, `And`, `But`, etc. Aunque son funcionalmente idénticos, ¿cuándo se debe usar cada uno?
* `Given`: Se utiliza para establecer un contexto para el escenario. Aqui se configura el estado del sistema antes de que ocurran las acciones principales.
* `When`: Se utiliza para describir la accion o evento que desencadenara el comportamiento que se esta probando.
* `Then`: Se utiliza para describrir el resultado o el comportamiento esperado una vez que se haya realizado la accion.
* `And, But`: Si tenemos `Then` o `Given` sucesivos, por ejemplo: 
```
Example: Multiple Givens
  Given one thing
  Given another thing
  Given yet another thing
  When I open my eyes
  Then I should see something
  Then I shouldn't see something else
```
Podriamos estructurar el ejemplo anterior con las palabras `And` and `But` de la siguiente manera:
```
Example: Multiple Givens
  Given one thing
  And another thing
  And yet another thing
  When I open my eyes
  Then I should see something
  But I shouldn't see something else
```
Mejorando asi la legibilidad evitando repeticion de palabras clave y asi obtener una mayor coherencia y claridad de redaccion.

5. 