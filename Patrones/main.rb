class ProductoPrototype
  attr_accessor :nombre, :precio

  def initialize(nombre, precio)
    @nombre = nombre
    @precio = precio
  end

  def clone temporada
    obj = Marshal.load(Marshal.dump(self))
    obj.precio = self.accept(temporada)
    return obj
  end

end

class Visitor
  def visit_laptop(laptop)
    raise NotImplementedError
  end
  def visit_celular(celular)
    raise NotImplementedError
  end
  def visit_tablet(tablet)
    raise NotImplementedError
  end
end

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

class Christmas < Visitor
  def visit_laptop(laptop)
    descuento = 0.1
    precio =laptop.precio*(1-descuento)
    return precio
  end

  def visit_celular(celular)
    descuento = 0.15
    precio = celular.precio*(1-descuento)
    return precio
  end

  def visit_tablet(tablet)
    descuento = 0.2
    precio = tablet.precio*(1-descuento)
    return precio
  end
end

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


# ==========Aplicacion==============================================

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






