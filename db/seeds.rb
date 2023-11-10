# frozen_string_literal: true

pokemons_names = PokeapiClient.get_pokemons_names
total_pokemons = pokemons_names.length
bar = TTY::ProgressBar.new('[:bar] :percent', total: total_pokemons)

pokemons_names.each do |pokemon_name|
  pokemon_data = PokeapiClient.get_pokemon_data pokemon_name
  Pokemon.create pokemon_data
  bar.advance
end
