# frozen_string_literal: true

module V1
  module Schemas
    class HangarGroup
      include SchemaConcern

      schema({
        type: :object,
        properties: {
          id: {type: :string, format: :uuid},
          name: {type: :string},
          slug: {type: :string},
          color: {type: :string}
        },
        additionalProperties: false,
        required: %w[id name slug color]
      })
    end
  end
end
