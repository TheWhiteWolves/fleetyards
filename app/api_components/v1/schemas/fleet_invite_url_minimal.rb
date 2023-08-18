# frozen_string_literal: true

module V1
  module Schemas
    class FleetInviteUrlMinimal < FleetInviteUrlBase
      include SchemaConcern

      schema({
        properties: {
          createdAt: {type: :string, format: "date-time"},
          updatedAt: {type: :string, format: "date-time"}
        },
        required: %w[createdAt updatedAt]
      })
    end
  end
end
