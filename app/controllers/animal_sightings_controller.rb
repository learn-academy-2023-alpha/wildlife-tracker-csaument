class AnimalSightingsController < ApplicationController
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
            sighting = AnimalSighting.find(params[:id])
            render json: sighting
      end

      # def new

      # end

      def create
            sighting = AnimalSighting.create(animalsighting_params)
            if sighting.valid?
              render json: sighting
            else
              render json: sighting.errors
            end
      end

      # def edit

      # end

      def update
            sighting = AnimalSighting.find(params[:animal_id])
            sighting.update(animalsighting_params)
            if sighting.valid?
              render json: sighting
            else
              render json: sighting.errors
            end
      end

      def destroy
            sighting = AnimalSighting.find(params[:id])
            if sighting.destroy
              render json: sighting
            else
              render json: sighting.errors
            end
      end

      private
      def animalsighting_params
            params.require(:animal_sighting).permit(:latitude, :longitude, :date, :animal_id, :start_date, :end_date)
      end
end

