# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "admin/api/v1/components", type: :request, swagger_doc: "admin/v1/schema.yaml" do
  fixtures :all

  let(:user) { nil }

  before do
    sign_in user if user.present?
  end

  path "/components/item_type_filters" do
    get("Component Item Type Filters") do
      operationId "itemTypes"
      description "Get a list of Component Item Types"
      produces "application/json"
      tags "ComponentsFilters"

      response(200, "successful") do
        schema type: :array, items: {"$ref": "#/components/schemas/FilterOption"}

        let(:user) { admin_users :jeanluc }

        after do |example|
          if response&.body.present?
            example.metadata[:response][:content] = {
              "application/json": {
                example: JSON.parse(response.body, symbolize_names: true)
              }
            }
          end
        end

        run_test! do |response|
          data = JSON.parse(response.body)

          expect(data.count).to be > 0
        end
      end

      response(401, "unauthorized") do
        schema "$ref": "#/components/schemas/StandardError"

        run_test!
      end
    end
  end
end
