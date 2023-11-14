# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::PokemonSerializer, type: :serializer do
  let(:pokemon) { create(:pokemon) }

  let(:serialized_pokemon) { described_class.new(pokemon).as_json }
  let :expected_hash do
    {
      name: pokemon.name,
      order: pokemon.order,
      height: pokemon.height,
      weight: pokemon.weight,
      types: pokemon.types.split(','),
      base_experience: pokemon.base_experience
    }
  end

  it 'returns hash with pokemon' do
    expect(serialized_pokemon).to eq expected_hash
  end
end
