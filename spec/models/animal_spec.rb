require 'rails_helper'

RSpec.describe Animal, type: :model do
  it 'is valid with valid data' do
      animal = Animal.create common_name: 'Dog', scientific_binomial: 'Canis familiaris'
      expect(animal.errors).to be_empty
  end

  it 'is not valid without a common name' do
      animal = Animal.create scientific_binomial: 'Canis familiaris'
      expect(animal.errors[:common_name]).to_not be_empty
  end

  it 'is not valid without a scientific binomial' do
      animal = Animal.create common_name: 'Dog'
      expect(animal.errors[:scientific_binomial]).to_not be_empty
  end

  it 'is not valid if common name is scientific binomial' do
      animal = Animal.create common_name: 'Canis familiaris', scientific_binomial: 'Canis familiaris'
      expect(animal.errors[:common_name]).to_not be_empty
  end

  it 'is not valid if common name is not unique' do
      Animal.create common_name: 'Dog', scientific_binomial: 'Feline familiaris'
      animal = Animal.create common_name: 'Dog', scientific_binomial: 'Canis familiaris'
      expect(animal.errors[:common_name]).to_not be_empty
  end

  it 'is not valid if scientfic binomial is not unique' do
      Animal.create common_name: 'Cat', scientific_binomial: 'Canis familiaris'
      animal = Animal.create common_name: 'Dog', scientific_binomial: 'Canis familiaris'
      expect(animal.errors[:scientific_binomial]).to_not be_empty
  end
end