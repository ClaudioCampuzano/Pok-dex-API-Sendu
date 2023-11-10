# frozen_string_literal: true

require 'rails_helper'

POKEAPI_BASE_URL = ENV.fetch('POKEAPI_BASE_URL', 'https://pokeapi.co/api/v2/')
LIMIT_OF_POKEMONS = ENV.fetch('LIMIT_OF_POKEMONS', '10000')

describe PokeapiClient do
  let(:client) { described_class }
  let(:status) { 200 }
  let(:faraday_response) { instance_double(Faraday::Response, body: response_hash, status:) }
  let(:connection) { instance_double(Faraday::Connection) }

  before do
    allow(Faraday).to receive(:new).and_return connection
    allow(connection).to receive(:get).and_return faraday_response
  end

  after { client.instance_variable_set(:@connection, nil) }

  describe '#get_pokemons_names' do
    let(:response_hash) { { 'results' => [{ 'name' => 'bulbasor' }, { 'name' => 'charmander' }] } }

    it 'returns hash with markets' do
      expect(client.get_pokemons_names).to eq(response_hash['results'].map { |pokemon| pokemon['name'] })
    end

    context 'when the api responds with 200' do
      before { client.get_pokemons_names }

      it 'creates a new connection with the correct url' do
        expect(Faraday).to have_received(:new).with(url: POKEAPI_BASE_URL)
      end

      it 'calls with the correct method and path' do
        expect(connection).to have_received(:get).with('pokemon', { limit: LIMIT_OF_POKEMONS.to_s, offset: 0 })
      end
    end

    context 'when the api does not respond with 200' do
      let(:status) { 500 }

      it 'raises a Pokeapi Error' do
        expect { client.get_pokemons_names }.to raise_error(ClientError::Pokeapi)
      end
    end
  end

  describe '#get_pokemon_data' do
    let(:pokemon_name) { 'charmander' }
    let(:response_hash) do
      { 'name' => pokemon_name, 'base_experience' => 40, 'height' => 10, 'order' => 10, 'weight' => 10,
        'types' => [{ 'type' => { 'name' => 'psychic' } }] }
    end

    it 'returns hash with trades' do
      expect(client.get_pokemon_data(pokemon_name))
        .to eq({ name: response_hash['name'],
                 base_experience: response_hash['base_experience'],
                 height: response_hash['height'],
                 order: response_hash['order'],
                 weight: response_hash['weight'],
                 types: response_hash['types'].map { |type| type['type']['name'] }.join(',') })
    end

    context 'when the api responds with 200' do
      before { client.get_pokemon_data(pokemon_name) }

      it 'creates a new connection with the correct url' do
        expect(Faraday).to have_received(:new).with(url: POKEAPI_BASE_URL)
      end

      it 'calls with the correct method and path' do
        expect(connection).to have_received(:get)
                          .with("pokemon/#{pokemon_name}")
      end
    end

    context 'when the api does not respond with 200' do
      let(:status) { 500 }

      it 'raises a PricesCollectorError' do
        expect { client.get_pokemon_data(pokemon_name) }
          .to raise_error(ClientError::Pokeapi)
      end
    end
  end
end
