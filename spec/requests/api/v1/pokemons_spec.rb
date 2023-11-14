# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/pokemons', type: :request do
  let(:pokemon) do
    {
      name: 'charmander',
      types: 'fire',
      weight: 85,
      height: 7,
      order: 4,
      base_experience: 64
    }
  end

  path '/api/v1/pokemons' do
    get('') do
      description 'Retrieve a list of all Pokemons'

      response(200, 'All pokemon retrieved') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post('') do
      description 'Create a new Pokemon'

      consumes 'application/json'
      parameter name: :pokemon, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, default: 'ditto' },
          types: { type: :string, default: 'normal,poison' },
          weight: { type: :integer, default: 40 },
          height: { type: :integer, default: 3 },
          order: { type: :integer, default: 214 },
          base_experience: { type: :string, default: 101 }
        },
        required: %w[name types weight height order base_experience]
      }

      response(201, 'Pokemon created') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(409, 'Problems creating pokemon') do
        before { create :pokemon, name: 'charmander' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/pokemons/{id}' do
    let(:id) { 'bulbasaur' }

    before { create :pokemon }
    parameter name: 'id', in: :path, type: :string,
              description: 'ID or name of the Pokemon', default: 'ditto'

    get('') do
      description 'Retrieve details of a specific Pokemon'

      response(200, 'Pokemon find') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(404, 'Pokemon not found') do
        let(:id) { 'Charmander' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    put('') do
      description 'Update an existing Pokemon'

      consumes 'application/json'
      parameter name: :pokemon, in: :body, schema: {
        type: :object,
        properties: {
          types: { type: :string, default: 'electric' },
          weight: { type: :integer, default: 40 },
          height: { type: :integer, default: 10 },
          order: { type: :integer, default: 350 },
          base_experience: { type: :string, default: 5 }
        },
        required: []
      }
      response(200, 'Pokemon updated') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(404, 'Pokemon not found') do
        let(:id) { 'Charmander' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    delete('') do
      description 'Delete a Pokemon'

      response(204, 'Pokemon deleted') do
        after do |example|
        end
        run_test! do
          expect(Pokemon.count).to eq(0)
        end
      end

      response(404, 'Pokemon not found') do
        let(:id) { 'Charmander' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
