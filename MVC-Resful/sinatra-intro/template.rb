=begin
A toy Sinatra app to demonstrate the basic concept of MVC, RESTful Routes and CRUD.
Run ``bundle install`` to make sure you have necessary gems installed.
TO run the script, type ``ruby template.rb`` in command line.
updated: jeremy warner, original author: hezheng.yin
=end

# load libraries we need
require 'sinatra'
require 'active_record'
require 'json'

# tell active_record which database to connect to
db_options = {adapter: 'sqlite3', database: 'todos_db'}
ActiveRecord::Base.establish_connection(db_options)

# write migration class for creating Todo table in database
### how do we write migration in rails?
class CreateTodos < ActiveRecord::Migration[5.0]
  def change
    create_table :todos do |t|
      t.string :description
    end
  end
end

# create Todo table by executing the function we just wrote
### how do apply migration in rails?
### why do we handle exception here?
begin
  CreateTodos.new.change
rescue ActiveRecord::StatementInvalid
  # it's probably OK
end

# create Todo class by inheriting from ActiveRecord::Base
### how do we write new class in Rails?
### why there's no setter and getter method (or attr_accessor)?
class Todo < ActiveRecord::Base
end

# populate the database if it is empty (avoid running this piece of code twice)
### do you still remember this cleaner and simpler hash syntax?
# old version: new_hash = {:simon => "Talek", :lorem => "Ipsum"}
if Todo.all.empty?
  Todo.create(description: "prepare for discussion section")
  Todo.create(description: "release cc 3s2")
end

#### OPERACION INDEX ####
# display all todos (tareas)
get '/todos' do
  content_type :json
  Todo.all.to_json
end

#### OPERACION READ ####
# show a specific todo
get '/todos/:id' do
  content_type :json
  todo = Todo.find(params[:id])
  if todo
    return {description: todo.description}.to_json
  else
    return {msg: "error: specified todo not found"}.to_json
  end
end

#### OPERACION CREATE ####
# create a new todo
# return: if we receive non-empty description, render json with msg set to "create success"
# 			otherwise render json with msg set to "error: description can't be blank"
# hint: use method Todo's class method create
post '/todos' do
  content_type :json

  # Obtenemos la descripción de la tarea.
  description = params[:description]

  # Si la descripción de la tarea no está vacía, creamos una nueva tarea y
  # una respuesta JSON con el mensaje "create success".
  if description.present?
    Todo.create(description: description)
    return { msg: 'create success' }.to_json
  else
    # Si la descripción de la tarea está vacía, renderizamos una respuesta JSON con el mensaje "error: description can't be blank".
    return { msg: 'error: description can\'t be blank' }.to_json
  end
end

#### OPERACION UPDATE ####
# update a todo
# return: if todo with specified id exist and description non-empty, render json with msg set to "update success"
# 				otherwise render json with msg set to "update failure"
# hint: Todo class has instance method update_attribute
put '/todos/:id' do
  content_type :json
  # Obtenemos el ID de la tarea
  id = params[:id]
  # Obtenemos la descripción de la nueva tarea
  description = params[:description]

  # Buscamos la tarea en la base de datos
  todo = Todo.find(id)

  # Si la tarea existe y la descripción no esta vacia
  if todo and description != ""
    todo.update_attribute(:description, description)
    return { msg: 'update success' }.to_json
  else
    return { msg: 'update failure' }.to_json
  end

end

#### OPERACION DESTROY ####
# delete a todo
# return: if todo with specified id exist, render json with msg set to "delete success"
# 				otherwise render json with msg set to "delete failure"
# hint: Todo class has instance method destroy
delete '/todos/:id' do
  content_type :json
  # Obtenemos el ID de la tarea
  id = params[:id]

  # Buscamos la tarea en la base de datos
  todo = Todo.find(id)

  # Si la tarea no existe
  if todo.nil?
    return { msg: 'delete failure' }.to_json
  else
    # Si la tarea eiste
    todo.destroy
    return { msg: 'delete success' }.to_json
  end

end
