# frozen_string_literal: true

module Api
  module V1
    class PokemonSerializer < ActiveModel::Serializer
      attributes :base_experience, :height, :name, :order, :types, :weight

      def types
        object.types.split(',')
      end
    end
  end
end
