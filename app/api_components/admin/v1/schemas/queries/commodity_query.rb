# frozen_string_literal: true

module Admin
  module V1
    module Schemas
      module Queries
        class CommodityQuery
          include SchemaConcern

          schema({
            type: :object,
            properties: {
              commodityItemId: {type: :array, items: {type: :string}}
            },
            additionalProperties: false
          })
        end
      end
    end
  end
end
