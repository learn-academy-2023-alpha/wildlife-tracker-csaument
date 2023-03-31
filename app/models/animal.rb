class ScienceValidator < ActiveModel::Validator
      # custom validation for common name != scientific binomial
      def validate(animal)
            if animal.common_name == animal.scientific_binomial
                  animal.errors.add :common_name, (options[:message] || 'Common name cannot be scientific binomial')
            end
      end
end

class Animal < ApplicationRecord
      has_many :animal_sightings
      include ActiveModel::Validations
      validates_with ScienceValidator

      validates :common_name, presence: true, uniqueness: true
      validates :scientific_binomial, presence: true, uniqueness: true
end