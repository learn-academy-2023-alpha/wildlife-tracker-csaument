Rails.application.routes.draw do
      # Path for looking up sightings in a date range
      get '/animal_sightings/dates' => 'animal_sightings#date_index'
      
      resources :animal_sightings
      resources :animals
      # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

      # Defines the root path route ("/")
      # root "articles#index"

      # Path for looking up sightings of a specific animal
      get '/animals/:id/sightings' => 'animal_sightings#animal_index'
end
