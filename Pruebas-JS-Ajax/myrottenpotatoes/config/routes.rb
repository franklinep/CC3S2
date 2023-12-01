Myrottenpotatoes::Application.routes.draw do
  #resources :movies
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  resources :movies do
  resources :reviews
end
  root :to => redirect('/movies')
end
