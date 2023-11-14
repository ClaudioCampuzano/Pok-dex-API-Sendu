# frozen_string_literal: true

# == Schema Information
#
# Table name: pokemons
#
#  id              :integer          not null, primary key
#  base_experience :integer
#  height          :integer
#  name            :string
#  order           :integer
#  types           :string
#  weight          :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_pokemons_on_name  (name) UNIQUE
#
class Pokemon < ApplicationRecord
  validates :base_experience, :height, :weight, :name, :order, :types, presence: true
  validates :height, :weight, :base_experience, numericality: { greater_than: 0 }
  validates :name, uniqueness: true

  before_save :downcase_values

  private

  def downcase_values
    self.name = name.downcase
    self.types = types.downcase
  end
end
