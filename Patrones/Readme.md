# Presentacion
> **Alumnos**
- Franklin Espinoza Pari - 20210135D
- Luis Angel Azaña Vega - 20212195D
- Pedro Luis David De la cruz Valdiviezo - 20172198H

> **Profesor**
- Cesar Jesús Lara Avila

> **Tarea - PC°2**
- Tema de Patrones 
  - Facade
  - Prototype
  - Visitor
  
# Problematica

Buscamos con esta elemental aplicacion hacer uso de los siguientes patrones
- **Facade** es un patrón de diseño estructural que proporciona una interfaz simplificada a una biblioteca, un framework o cualquier otro grupo complejo de clases.
- **Prototype** es un patrón de diseño creacional que nos permite copiar objetos existentes sin que el código dependa de sus clases.
- **Visitor** es un patrón de diseño de comportamiento que te permite separar algoritmos de los objetos sobre los que operan.

Esta aplicacion se basa en generar la factura con descuentos segun la temporada *(Navidad, Black Friday, etc)*
de una tienda con ciertos productos electronicos. 
Ademas, consideramos que la tienda solo vende 3 tipos de productos; laptops, celulares y tablets, esto es importante ya que en el patron
vistor la cantidad de elementos se considera constante y lo que varia es el numero de metodos que aplicamos sobre ellos, en este caso los metodos 
serian los descuentos de cada temporada.


# Implementación

## Clase ProductoPrototype
En este bloque de codigo implementamos el patron de diseño **Prototype**. La clase ***ProductoPrototype*** será el padre de las clases ***Laptop***, ***Celular*** y ***Tablet*** donde
heredaran el método `clone()` que se usa para crear copias exactas de los productos.

~~~ruby
class ProductoPrototype
  attr_accessor :nombre, :precio

  def initialize(nombre, precio)
    @nombre = nombre
    @precio = precio
  end
  
  # Metodo de clonacion
  def clone temporada
    obj = Marshal.load(Marshal.dump(self))
    obj.precio = self.accept(temporada)
    return obj
  end

end
~~~

### Uso del patron Prototype
Cuando se agrega un nuevo producto a la tienda, se crea una instancia de la clase prototipo correspondiente. Esta instancia
se `clona` para crear una nueva instancia del producto con los descuentos aplicados.
~~~ruby 
def calcular_descuentos
    # Clonando los productos actuales
    @productos.each do |producto|
      productosTemp << producto.clone(@temporada)
    end
end
~~~

## Clase Visitor

En esta clase se define un grupo de metodos donde cada uno de ellos toma distintos tipos de ***productos*** *(laptop, celular, tablet)*, estos grupos de metodos 
dependeran de la clase que los implemente, en nuestro caso, veremos que esas clases seran las temporadas de venta y sus metodos seran los  descuentos
a cada tipo de producto en esa determinada temporada.

~~~ruby
class Visitor
  def visit_laptop(laptop); end
  def visit_celular(celular); end
  def visit_tablet(tablet); end
end
~~~



## Productos
Cada una de estas clases representa una categoria de productos. Su constructor inicializa el respectivo `nombre` y `precio` de cada producto y tenemos un metodo de objeto
`accept` que toma como parametro un objeto de tipo `visitor`, este objeto sera el que nos de la temporada en la que se encuentra, para poder aplicar el respectivo descuento al 
objeto del cual es llamado.
~~~ruby
class Laptop < ProductoPrototype
  def initialize(nombre,precio)
    super(nombre,precio)
  end
  def accept(visitor)
    visitor.visit_laptop(self)
  end
end

class Celular < ProductoPrototype
  def initialize(nombre,precio)
    super(nombre,precio)
  end
  def accept(visitor)
    visitor.visit_celular(self)
  end
end

class Tablet < ProductoPrototype
  def initialize(nombre,precio)
    super(nombre,precio)
  end
  def accept(visitor)
    visitor.visit_tablet(self)
  end
end
~~~



 
## Clases de temporadas
Crearemos a continuación las clases de temporadas ***Christmas*** y ***BlackFriday*** que heredan
de la clase ***Visitor***. Hay que tener en cuenta que pueden agregarse mas temporadas sin afectar el codigo de cada una de las clases Laptop, Celular y Tablet,
he aqui la base del patron vistor.
### Uso del patron Visitor
El patron `Visitor` se usa para aplicar descuentos en los distintos productos. Estas clases 
de temporadas heredan de `Visitor`, donde los métodos `visit_laptop()`, `visit_celular()` y `visit_tablet()` son los responsables
de aplicar la operación a los productos correspondientes.

Ahora veremos la implementacion en codigo de las clases `Christmas` y `BlackFriday`
~~~ruby
class Christmas < Visitor
  def visit_laptop(laptop)
    descuento = 0.1 # Se le aplica un descuento del 10%
    precio =laptop.precio*(1-descuento)
    return precio
  end

  def visit_celular(celular)
    descuento = 0.15 # Se le aplica un descuento del 15%
    precio = celular.precio*(1-descuento)
    return precio
  end

  def visit_tablet(tablet)
    descuento = 0.2 # Se le aplica un descuento del 20%
    precio = tablet.precio*(1-descuento)
    return precio
  end
end
~~~
~~~ruby
class BlackFriday < Visitor
  def visit_laptop(laptop)
    descuento = 0.2
    precio = laptop.precio*(1-descuento)
    return precio
  end

  def visit_celular(celular)
    descuento = 0.25
    precio = celular.precio*(1-descuento)
    return precio
  end

  def visit_tablet(tablet)
    descuento = 0.3
    precio = tablet.precio*(1-descuento)
    return precio
  end
end
~~~

## Clase Tienda

- Este representa una tienda de productos electrónicos. 
- El constructor tiene como parametros a la temporada actual, la lista de productos disponibles en la tienda (`@productos`) y productos de temporada (`@productosTemp`) donde guardaremos a los
productos en un array en la que  cada uno de estos elementos es un  clon de los productos orginales  aplicando el descuento de  temporada, esto lo hacemos
para no alterar los datos del producto original, ya que mas adelante podemos aplicarle otro descuento al precio original en una distinta temporada.
- El metodo `generarFactura(compra)` tiene como parametro una compra de tipo `hash` para obtener el `nombre` y la `cantidad` que realizo el cliente. Cabe resaltar que se condiciona que exista el producto dentro de nuestros productos agregados. Finalmente este
  genera una factura detallada de los productos comprados, mostrando el nombre del producto, la cantidad y el precio total con el descuento aplicado para cada producto de la compra.

### Uso del patron Facade
La clase tienda trabaja como una clase fachada que encapulsa funcionalidades y la esconde del resto del codigo. Por ejemplo los metodos `generarFactura()` y `calcular_descuentos` utiliza la clase `Producto` en distintas operaciones. Esto ayuda a minimizar el esfuerzo de actualizar a futuras versiones de las clases de uso ya que lo unico que tendrias que cambiar en la aplicación es la implementación de los métodos de la fachada.
~~~ruby
class Tienda
  attr_accessor :productosTemp, :temporada;
  def initialize temporada
    @productos = []
    @temporada = temporada
    @productosTemp =[]
  end

  def agregar_producto(producto)
    @productos << producto
  end

  def calcular_descuentos
    # Clonando los productos actuales
    @productos.each do |producto|
      productosTemp << producto.clone(@temporada)
    end
  end

  # Realizando la factura
  def generarFactura(compra)
    compra.each do |nombre,cantidad|
      producto = productosTemp.find{|p| p.nombre==nombre}
      if producto!=nil
        sumaProd = 0
        sumaProd += cantidad*producto.precio
        puts sumaProd!=0 ? "producto : #{nombre}\tcantidad: #{cantidad}\tprecio:#{sumaProd}" : ""
      end
    end
  end

end
~~~

# Aplicacion

~~~ruby
p1 = Tablet.new("s7+",3600)
p2 = Laptop.new("msi",6200)
p3 = Celular.new("redmiNote12",1400)
temporada = BlackFriday.new

# Instanciamos nuestra tienda, en una temporada
tienda = Tienda.new(temporada)

# Agregamos los productos a nuestra tienda
tienda.agregar_producto(p1)
tienda.agregar_producto(p2)
tienda.agregar_producto(p3)

# Calculamos los descuentos de los productos
tienda.calcular_descuentos

# Realizamos la compra de nuestro carrita
compra = {"s7+"=>2,
          "redmiNote12"=>1,
          "msi"=>3}
# Generamos la factura
tienda.generarFactura(compra)
~~~

# Output
~~~
producto : s7+  cantidad: 2     precio:5040.0
producto : redmiNote12  cantidad: 1     precio:1050.0
producto : msi  cantidad: 3     precio:14880.0
~~~