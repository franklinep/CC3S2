# Parte 1

def sum(array)
  sum = 0
  # Sumamos cada elemento de nuestro array
  array.each do |a|
    sum += a
  end
  sum
end

def max_2_sum(array)
  # Si el arreglo está vacío, devuelve cero
  return 0 if array.empty?

  # Si el arreglo tiene solo un elemento, devuelve ese elemento
  return array.first if array.length == 1

  # Ordena el arreglo de manera descendente y suma los dos elementos más grandes
  sorted_array = array.sort.reverse
  sorted_array[0] + sorted_array[1]
end

def sum_to_n?(array, n)
  # Si el arreglo está vacío, devuelve falso
  return false if array.empty?

  # Comprueba todas las combinaciones de dos elementos en el arreglo
  array.combination(2).any? { |a, b| a + b == n }
end

# Parte 2

def hello(name)
  "Hello, " + name
end

def starts_with_consonant?(s)
  # Verifica si la cadena está vacía
  return false if s.nil? || s.empty?
  # Creamos nuestra expresion regular
  regexp = /[bcdfghjklmnñpqrstvwxyz]/i
  s[0].match?(regexp)
end

def binary_multiple_of_4?(s)
  # Verificamos que sea binario
  return false unless s =~ /^[01]+$/

  # Si termina en 00 es multiplo de 4
  if s =~ /00\z/ || s == '0'
    return true
  end
  false
end


# Parte 3

class BookInStock
  # getter and setter
  attr_accessor :isbn, :price

  # Constructor
  def initialize(isbn, price)
    # Si isbn esta vacio o el precio es negativo
    if isbn.empty? || price <= 0
      return raise ArgumentError # Genera un ArgumentError
    end
    @isbn = isbn
    @price = price
  end

  # Metodo price_as_string
  def price_as_string
    format("$%.2f", @price)
  end
end


