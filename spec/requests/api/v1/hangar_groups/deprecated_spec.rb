# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "api/v1/hangar_groups", type: :request, swagger_doc: "v1/schema.yaml" do
  fixtures :users, :hangar_groups

  let(:user) { nil }
  let(:hangar_group) { hangar_groups :hangargroupone }

  before do
    sign_in(user) if user.present?
  end

  path "/hangar-groups" do
    get("HangarGroup list") do
      operationId "list"
      tags "HangarGroups"
      produces "application/json"
      deprecated true

      response(200, "successful") do
        schema type: :array, items: {"$ref": "#/components/schemas/HangarGroupMinimal"}

        let(:user) { users :data }

        after do |example|
          example.metadata[:response][:content] = {
            "application/json" => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test! do |response|
          data = JSON.parse(response.body)

          expect(data.size).to eq(2)
        end
      end

      response(401, "unauthorized") do
        schema "$ref": "#/components/schemas/StandardError"

        run_test!
      end
    end

    post("HangarGroup create") do
      operationId "create"
      tags "HangarGroups"
      consumes "application/json"
      produces "application/json"
      deprecated true

      parameter name: :input, in: :body, schema: {"$ref": "#/components/schemas/HangarGroupCreateInput"}, required: true

      response(201, "successful") do
        schema "$ref": "#/components/schemas/HangarGroupMinimal"

        let(:user) { users :data }
        let(:input) do
          {
            name: "Hangar Group One Test",
            color: "#000000"
          }
        end

        after do |example|
          example.metadata[:response][:content] = {
            "application/json" => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test! do |response|
          data = JSON.parse(response.body)

          expect(data["name"]).to eq("Hangar Group One Test")
        end
      end

      response(401, "unauthorized") do
        schema "$ref": "#/components/schemas/StandardError"

        let(:input) { nil }

        run_test!
      end
    end
  end

  path "/hangar-groups/{id}" do
    parameter name: "id", in: :path, description: "HangarGroup ID", schema: {type: :string, format: :uuid}, required: true

    delete("HangarGroup Destroy") do
      operationId "destroy"
      tags "HangarGroups"
      produces "application/json"
      deprecated true

      response(200, "successful") do
        schema "$ref": "#/components/schemas/HangarGroupMinimal"

        let(:id) { hangar_group.id }
        let(:user) { users :data }

        after do |example|
          example.metadata[:response][:content] = {
            "application/json" => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test!
      end

      response(404, "not found") do
        schema "$ref": "#/components/schemas/StandardError"

        let(:id) { SecureRandom.uuid }
        let(:user) { users :data }

        run_test!
      end

      response(401, "unauthorized") do
        schema "$ref": "#/components/schemas/StandardError"

        let(:id) { hangar_group.id }

        run_test!
      end
    end

    put("HangarGroup Update") do
      operationId "update"
      tags "HangarGroups"
      consumes "application/json"
      produces "application/json"
      deprecated true

      parameter name: :input, in: :body, schema: {"$ref": "#/components/schemas/HangarGroupUpdateInput"}, required: true

      response(200, "successful") do
        schema "$ref": "#/components/schemas/HangarGroupMinimal"

        let(:id) { hangar_group.id }
        let(:user) { users :data }
        let(:input) do
          {
            name: "Hangar Group One Test"
          }
        end

        after do |example|
          example.metadata[:response][:content] = {
            "application/json" => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test! do |response|
          data = JSON.parse(response.body)

          expect(data["name"]).to eq("Hangar Group One Test")
        end
      end

      response(404, "not found") do
        schema "$ref": "#/components/schemas/StandardError"

        let(:id) { SecureRandom.uuid }
        let(:user) { users :data }
        let(:input) { nil }

        run_test!
      end

      response(401, "unauthorized") do
        schema "$ref": "#/components/schemas/StandardError"

        let(:id) { hangar_group.id }
        let(:input) { nil }

        run_test!
      end
    end

    path "/hangar-groups/sort" do
      put("HangarGroup sort") do
        operationId "sort"
        tags "HangarGroups"
        produces "application/json"
        deprecated true

        response(200, "successful") do
          schema type: :object, properties: {success: {type: :boolean}}

          let(:user) { users :data }

          after do |example|
            example.metadata[:response][:content] = {
              "application/json" => {
                example: JSON.parse(response.body, symbolize_names: true)
              }
            }
          end

          run_test!
        end

        response(401, "unauthorized") do
          schema "$ref": "#/components/schemas/StandardError"

          run_test!
        end
      end
    end

    path "/hangar-groups/{username}" do
      parameter name: "username", in: :path, type: :string, description: "Username", required: true

      get("HangarGroup list") do
        operationId "list"
        tags "PublicHangarGroups"
        produces "application/json"
        deprecated true

        response(200, "successful") do
          schema type: :array, items: {"$ref": "#/components/schemas/HangarGroupMinimalPublic"}

          let(:user) { users :data }
          let(:username) { user.username }

          after do |example|
            example.metadata[:response][:content] = {
              "application/json" => {
                example: JSON.parse(response.body, symbolize_names: true)
              }
            }
          end

          run_test! do |response|
            data = JSON.parse(response.body)

            expect(data.size).to eq(1)
          end
        end
      end
    end
  end
end
