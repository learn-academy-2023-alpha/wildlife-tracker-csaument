# Wildlife Tracker Challenge
The Forest Service is considering a proposal to place in conservancy a forest of virgin Douglas fir just outside of Portland, Oregon. Before they give the go ahead, they need to do an environmental impact study. They've asked you to build an API the rangers can use to report wildlife sightings.

## Story 1: In order to track wildlife sightings, as a user of the API, I need to manage animals.

### Branch: animal-crud-actions

### Acceptance Criteria

[x] Create a resource for animal with the following information: common name and scientific binomial
```console
rails g resource Animal common_name:string scientific_binomial:string

rails c

Animal.create(common_name: 'Human', scientific_binomial: 'Homo sapien')
Animal.create(common_name: 'Gray wolf', scientific_binomial: 'Canis lupus')
Animal.create(common_name: 'Lion', scientific_binomial: 'Panthera leo')
Animal.create(common_name: 'Arabian camel', scientific_binomial: 'Camelus dromedarius')
Animal.create(common_name: 'Asian elephant', scientific_binomial: 'Elephas maximus')
Animal.create(common_name: 'Brown tree snake', scientific_binomial: 'Boiga irregularis')
Animal.create(common_name: 'Polar bear', scientific_binomial: 'Ursus maritimus')
Animal.create(common_name: 'Buffalo', scientific_binomial: '	Bubalus bubalis')
Animal.create(common_name: 'Cheetah', scientific_binomial: 'Acinonyx jubatus')
Animal.create(common_name: 'Cow', scientific_binomial: 'Bos taurus')

exit
```
[x] Can see the data response of all the animals
* Functions in Postman
[x] Can create a new animal in the database
[x] Can update an existing animal in the database
[x] Can remove an animal entry in the database


## Story 2: In order to track wildlife sightings, as a user of the API, I need to manage animal sightings.

### Branch: sighting-crud-actions

### Acceptance Criteria

[x] Create a resource for animal sightings with the following information: latitude, longitude, date
* Hint: An animal has_many sightings (rails g resource Sighting animal_id:integer ...)
* Hint: Date is written in Active Record as yyyy-mm-dd (“2022-07-28")
[x] Can create a new animal sighting in the database
* Note: compound words are particular with snake_case and PascalCase, as well as singular and plurals. A cheat sheet would be useful...
```console
animal.animal_sighting.create(latitude: 33.0, longitude: -117.0, date: "2023-03-30")
```
[x] Can update an existing animal sighting in the database
[x] Can remove an animal sighting in the database
* Note: Unable to create a sighting through an animal, despite association...
* Note: Compound words are tricky. AnimalSighting, AnimalSightings, animal_sighting, and animal_sighting are interchangeably used in different contexts.

## Story 3: In order to see the wildlife sightings, as a user of the API, I need to run reports on animal sightings.

### Branch: animal-sightings-reports

### Acceptance Criteria

[x] Can see one animal with all its associated sightings
* Hint: Checkout this example on how to include associated records

Animal Sightings Controller
```ruby
def animal_index
      sightings = AnimalSighting.where(animal_id: params[:id])
      render json: sightings, include: [:animal]
end
```

Routes
```ruby
get '/animals/:id/sightings' => 'animal_sightings#animal_index'
```

[x] Can see all the all sightings during a given time period
* Hint: Your controller can use a range to look like this:
```ruby
class SightingsController < ApplicationController
  def index
    sightings = Sighting.where(date: params[:start_date]..params[:end_date])
    render json: sightings
  end
end
```

Animal Sightings Controller 
```ruby
def date_index
      sightings = AnimalSighting.where(date: params[:start_date]..params[:end_date])
      render json: sightings
end
```

Routes *Must be above resource line*
```ruby
get '/animal_sightings/dates' => 'animal_sightings#date_index'
```
* Hint: Be sure to add the start_date and end_date to what is permitted in your strong parameters method
* Hint: Utilize the params section in Postman to ease the developer experience
* Hint: Routes with params

## Stretch Challenges

## Story 4: In order to see the wildlife sightings contain valid data, as a user of the API, I need to include proper specs.

### Branch: animal-sightings-specs

### Acceptance Criteria
[] Validations will require specs in spec/models and the controller methods will require specs in spec/requests.

[] Can see validation errors if an animal doesn't include a common name and scientific binomial
[] Can see validation errors if a sighting doesn't include latitude, longitude, or a date
[] Can see a validation error if an animal's common name exactly matches the scientific binomial
[] Can see a validation error if the animal's common name and scientific binomial are not unique
[] Can see a status code of 422 when a post request can not be completed because of validation errors
* Hint: Handling Errors in an API Application the Rails Way


## Story 5: In order to increase efficiency, as a user of the API, I need to add an animal and a sighting at the same time.

### Branch: submit-animal-with-sightings

### Acceptance Criteria

[] Can create new animal along with sighting data in a single API request
* Hint: Look into accepts_nested_attributes_for