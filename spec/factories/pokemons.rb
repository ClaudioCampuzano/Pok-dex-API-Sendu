# frozen_string_literal: true

FactoryBot.define do
  factory :pokemon do
    name { 'bulbasaur' }
    order { 1 }
    base_experience { 64 }
    height { 7 }
    weight { 69 }
    types { 'grass,posion' }
  end
end
