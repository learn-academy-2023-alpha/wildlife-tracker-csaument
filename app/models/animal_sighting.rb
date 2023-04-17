class LatValidator < ActiveModel::Validator
      # custom validation for latitude -90.0..90.0
      def validate(sighting)
            if (-90.0..90.0).exclude? sighting.latitude
                  sighting.errors.add :latitude, (options[:message] || 'Must be between -90 and 90 degrees')
            end
      end
end

class LongValidator < ActiveModel::Validator
      # custom validation for longitude -180.0..180.0
      def validate(sighting)
            if (-180.0..180.0).exclude? sighting.longitude
                  sighting.errors.add :longitude, (options[:message] || 'Must be between -180 and 180 degrees')
            end
      end
end

class AnimalSighting < ApplicationRecord
      belongs_to :animal
      include ActiveModel::Validations
      validates_with LatValidator
      validates_with LongValidator

      validates :latitude, presence: true
      validates :longitude, presence: true
      validates :date, presence: true
end