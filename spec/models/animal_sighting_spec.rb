require 'rails_helper'

RSpec.describe AnimalSighting, type: :model do
  it 'is valid with valid data' do
      animal = Animal.create common_name: 'Dog', scientific_binomial: 'Canis familiaris'
      sighting = animal.animal_sightings.create(latitude: 30.0, longitude: -120.0, date: "2023-03-30")
      expect(sighting.errors).to be_empty
  end

  it 'is not valid without a lat' do
      animal = Animal.create common_name: 'Dog', scientific_binomial: 'Canis familiaris'
      sighting = animal.animal_sightings.create(longitude: -120.0, date: "2023-03-30")
      expect(sighting.errors[:latitude]).to_not be_empty
  end

  it 'is not valid if latitude is out of -90..90' do
      animal = Animal.create common_name: 'Dog', scientific_binomial: 'Canis familiaris'
      sighting = animal.animal_sightings.create(latitude: 100.0, longitude: -120.0, date: "2023-03-30")
      expect(sighting.errors[:latitude]).to_not be_empty
  end

  it 'is not valid without a long' do
      animal = Animal.create common_name: 'Dog', scientific_binomial: 'Canis familiaris'
      sighting = animal.animal_sightings.create(latitude: 30.0, date: "2023-03-30")
      expect(sighting.errors[:longitude]).to_not be_empty
  end

  it 'is not valid if longitude is out of -180..180' do
      animal = Animal.create common_name: 'Dog', scientific_binomial: 'Canis familiaris'
      sighting = animal.animal_sightings.create(latitude: 30.0, longitude: -200.0, date: "2023-03-30")
      expect(sighting.errors[:longitude]).to_not be_empty
  end

  it 'is not valid without a date' do
      animal = Animal.create common_name: 'Dog', scientific_binomial: 'Canis familiaris'
      sighting = animal.animal_sightings.create(latitude: 30.0, longitude: -120.0)
      expect(sighting.errors[:date]).to_not be_empty
  end
end
