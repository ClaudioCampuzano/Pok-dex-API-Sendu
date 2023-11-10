# frozen_string_literal: true

module ClientError
  class Pokeapi < StandardError
    attr_reader :status, :detail

    def initialize(status, detail)
      super("Pokeapi error: #{status} #{detail}")

      @status = status
      @detail = detail
    end
  end
end
