# frozen_string_literal: true

class PokeapiClient
  POKEAPI_BASE_URL = ENV.fetch('POKEAPI_BASE_URL', 'https://pokeapi.co/api/v2/')
  LIMIT_OF_POKEMONS = ENV.fetch('LIMIT_OF_POKEMONS', '10000')

  class << self
    def get_pokemons_names(limit: LIMIT_OF_POKEMONS, offset: 0)
      response = connection.get('pokemon', { limit:, offset: })

      handle_response(response)['results'].map { |pokemon| pokemon['name'] }
    end

    def get_pokemon_data(pokemon_id)
      response = connection.get("pokemon/#{pokemon_id}")
      response_body = handle_response(response)

      {
        name: response_body['name'],
        base_experience: response_body['base_experience'],
        height: response_body['height'],
        order: response_body['order'],
        weight: response_body['weight'],
        types: response_body['types'].map { |type| type['type']['name'] }.join(',')
      }
    end

    private

    def handle_response(response)
      raise ClientError::Pokeapi.new(response.status, response.body) unless [200, 202].include?(response.status)

      response.body
    end

    def connection
      @connection ||=
        Faraday.new(url: POKEAPI_BASE_URL) do |f|
          f.request :json
          f.response :json
        end
    end
  end
end
