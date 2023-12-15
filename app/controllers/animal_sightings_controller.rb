class AnimalSightingsController < ApplicationController
      rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
      rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

      def render_unprocessable_entity_response(exception)
            render json: exception.record.errors, status: :unprocessable_entity
      end
  
      def render_not_found_response(exception)
            render json: { error: exception.message }, status: :not_found
      end
      
      def index
            sightings = AnimalSighting.all
            render json: sightings
      end

      def animal_index
            sightings = AnimalSighting.where(animal_id: params[:id])
            render json: sightings, include: [:animal]
      end

      def date_index
            sightings = AnimalSighting.where(date: params[:start_date]..params[:end_date])
            render json: sightings
      end

      def show
            sighting = AnimalSighting.find!(params[:id])
            render json: sighting
      end

      def create
            sighting = AnimalSighting.create!(animalsighting_params)
            render json: sighting
      end

      def update
            sighting = AnimalSighting.find(params[:animal_id])
            sighting.update!(animalsighting_params)
            render json: sighting
      end

      def destroy
            sighting = AnimalSighting.find(params[:id])
            sighting.destroy!
            render json: sighting
      end

      private
      def animalsighting_params
            params.require(:animal_sighting).permit(:latitude, :longitude, :date, :animal_id, :start_date, :end_date)
      end
end

