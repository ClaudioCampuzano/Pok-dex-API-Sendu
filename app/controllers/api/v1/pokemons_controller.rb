# frozen_string_literal: true

module Api
  module V1
    class PokemonsController < ApplicationController
      def index
        @pokemons = Pokemon.all

        render json: @pokemons, status: :ok
      end

      def show
        return render_not_found_response 'find' unless pokemon

        render json: pokemon, status: :ok
      end

      def create
        new_pokemon = Pokemon.new create_params

        return render json: new_pokemon, status: :created if new_pokemon.save

        render json: { error: new_pokemon.errors.full_messages }, status: :conflict
      end

      def update
        return render_not_found_response 'update' unless pokemon

        unless pokemon.update update_params
          return render json: { error: 'Unable to update Pokemon' }, status: :unprocessable_entity
        end

        render json: pokemon, status: :ok
      end

      def destroy
        return render_not_found_response 'delete' unless pokemon

        pokemon.destroy
        render status: :no_content
      end

      private

      def pokemon
        search_param = params[:id]

        @pokemon = if number? search_param
                     Pokemon.find search_param
                   else
                     Pokemon.find_by(name: search_param.downcase)
                   end
      end

      def pokemon_params
        @pokemon_params ||= params[:pokemon] || params
      end

      def create_params
        pokemon_params.permit(%i[base_experience height weight name order types])
      end

      def update_params
        pokemon_params.permit(%i[base_experience height weight order types])
      end

      def render_not_found_response(action)
        render json: { error: "Unable to #{action} Pokemon" }, status: :not_found
      end

      def number?(string)
        true if Float(string)
      rescue StandardError
        false
      end
    end
  end
end
