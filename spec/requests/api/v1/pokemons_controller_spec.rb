# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::PokemonsController, type: :request do
  let!(:bulbasur) { create :pokemon }
  let!(:lugia) { create :pokemon, name: 'lugia' }

  describe '#index' do
    it 'responds with a success status code' do
      get api_v1_pokemons_path

      expect(response).to have_http_status(:ok)
    end

    it 'respond with all pokemons' do
      get api_v1_pokemons_path

      expect(json_response).to eq([{ 'base_experience' => bulbasur.base_experience, 'height' => bulbasur.height,
                                     'name' => bulbasur.name, 'order' => bulbasur.order,
                                     'types' => bulbasur.types.split(','), 'weight' => bulbasur.weight },
                                   { 'base_experience' => lugia.base_experience, 'height' => lugia.height,
                                     'name' => lugia.name, 'order' => lugia.order,
                                     'types' => lugia.types.split(','), 'weight' => lugia.weight }])
    end
  end

  describe '#show' do
    context 'when given a params that exists' do
      context 'when id is number of pokemon' do
        it 'responds with a success status code' do
          get "#{api_v1_pokemons_path}/#{bulbasur.id}"

          expect(response).to have_http_status(:ok)
        end
      end

      context 'when id is a name of pokemon' do
        it 'responds with a success status code' do
          get "#{api_v1_pokemons_path}/#{lugia.name}"

          expect(response).to have_http_status(:ok)
        end
      end

      it 'respond with pokemon' do
        get "#{api_v1_pokemons_path}/#{lugia.name}"

        expect(json_response).to eq({ 'base_experience' => lugia.base_experience, 'height' => lugia.height,
                                      'name' => lugia.name, 'order' => lugia.order, 'types' => lugia.types.split(','),
                                      'weight' => lugia.weight })
      end
    end

    context 'when the pokemon does not exist in the database' do
      it 'responds with a not found status code' do
        get "#{api_v1_pokemons_path}/#{bulbasur.id}+100"

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe '#create' do
    let(:request_params) do
      { pokemon: { name: 'picachu', order: 3, base_experience: 67, height: 25, weight: 23, types: 'electric' } }
    end

    it 'responds with a crated status code' do
      post api_v1_pokemons_path, params: request_params

      expect(response).to have_http_status :created
    end

    it 'create a new pokemon' do
      expect { post api_v1_pokemons_path, params: request_params }.to change { Pokemon.count }.by(1)
    end

    context 'when already exist that pokemon in database' do
      let(:request_params) do
        { pokemon: { name: 'bulbasaur', order: 3, base_experience: 67, height: 25, weight: 23, types: 'electric' } }
      end

      it 'responds with a conflict status code' do
        post api_v1_pokemons_path, params: request_params

        expect(response).to have_http_status :conflict
      end
    end
  end

  describe '#update' do
    let(:update_params) do
      {
        height: 50,
        weight: 50
      }
    end

    context 'when pokemon exist in database' do
      it 'responds with a ok status code' do
        put "#{api_v1_pokemons_path}/#{lugia.id}", params: update_params

        expect(response).to have_http_status(:ok)
      end

      it 'update a pokemon' do
        expect do
          put "#{api_v1_pokemons_path}/#{lugia.id}", params: update_params
        end.to change {
                 {
                   height: Pokemon.find(lugia.id).height,
                   weight: Pokemon.find(lugia.id).weight
                 }
               }.to(update_params)
      end
    end

    context 'when the pokemon does not exist in the database' do
      it 'responds with a not found status code' do
        put "#{api_v1_pokemons_path}/#{bulbasur.id + 100}"

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe '#delete' do
    context 'when pokemon exist in database' do
      it 'responds with a no content status code' do
        delete "#{api_v1_pokemons_path}/#{bulbasur.id}"

        expect(response).to have_http_status(:no_content)
      end

      it 'delete a pokemon' do
        expect { delete "#{api_v1_pokemons_path}/#{bulbasur.id}" }.to change { Pokemon.count }.by(-1)
      end
    end

    context 'when the pokemon does not exist in the database' do
      it 'responds with a not found status code' do
        delete "#{api_v1_pokemons_path}/#{bulbasur.id + 100}"

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
