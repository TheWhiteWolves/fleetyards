# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "api/v1/vehicles", type: :request, swagger_doc: "v1/schema.yaml" do
  fixtures :all

  let(:user) { users(:data) }

  before do
    sign_in(user)
  end

  path "/vehicles" do
    get("Vehicles List -> use GET /hangar") do
      deprecated true
      tags "Vehicles"
      produces "application/json"

      parameter name: "page", in: :query, schema: {type: :string, default: "1"}, required: false
      parameter name: "perPage", in: :query, schema: {type: :string, default: Vehicle.default_per_page}, required: false
      parameter name: "q", in: :query,
        schema: {
          type: :object,
          "$ref": "#/components/schemas/HangarQuery"
        },
        style: :deepObject,
        explode: true,
        required: false

      response(200, "successful") do
        schema type: :array,
          items: {"$ref": "#/components/schemas/VehicleMinimal"}

        run_test!
      end
    end
  end

  path "/vehicles/fleetchart" do
    get("Vehicle Fleetchart List -> use GET /hangar") do
      deprecated true
      tags "Vehicles"
      produces "application/json"

      response(200, "successful") do
        schema type: :array,
          items: {"$ref": "#/components/schemas/VehicleMinimal"}

        run_test!
      end
    end
  end

  path "/vehicles/export" do
    get("Vehicle Export -> use GET /hangar/export") do
      deprecated true
      tags "Vehicles"
      produces "application/json"

      response(200, "successful") do
        schema type: :array,
          items: {"$ref": "#/components/schemas/VehicleExport"}

        run_test!
      end
    end
  end

  path "/vehicles/import" do
    put("Vehicle import -> use PUT /hangar/import") do
      deprecated true
      tags "Vehicles"
      consumes "multipart/form-data"
      produces "application/json"

      parameter name: :import, in: :formData, type: :string, format: :binary, required: true

      response(200, "successful") do
        schema "$ref": "#/components/schemas/HangarImportResult"

        let(:import) do
          Rack::Test::UploadedFile.new(File.new(Rails.root.join("test/fixtures/files/hangar_import.json")))
        end

        run_test!
      end
    end
  end

  path "/vehicles/destroy-all" do
    delete("Vehicle Destroy all -> use DELETE /hangar") do
      deprecated true
      tags "Vehicles"
      consumes "application/json"
      produces "application/json"

      response(204, "successful") do
        run_test!
      end
    end
  end

  path "/vehicles/embed" do
    get("Vehicle embed -> use GET /public/hangar/embed") do
      deprecated true
      tags "Vehicles"
      produces "application/json"

      response(200, "successful") do
        schema type: :array,
          items: {"$ref": "#/components/schemas/VehicleMinimal"}

        run_test!
      end
    end
  end

  path "/vehicles/hangar-items" do
    get("Vehicle Hangar items -> use GET /hangar/items") do
      deprecated true
      tags "Vehicles"
      produces "application/json"

      response(200, "successful") do
        schema type: :array, items: {type: :string}

        run_test!
      end
    end
  end

  path "/vehicles/hangar" do
    get("Vehicle hangar -> no replacement") do
      deprecated true
      tags "Vehicles"
      produces "application/json"

      response(200, "successful") do
        schema type: :array,
          items: {"$ref": "#/components/schemas/VehicleMinimal"}

        run_test!
      end
    end
  end

  path "/vehicles/quick-stats" do
    get("Vehicle Quickstats -> use GET /hangar/stats") do
      deprecated true
      tags "Vehicles - Stats"
      produces "application/json"

      response(200, "successful") do
        run_test!
      end
    end
  end

  path "/vehicles/stats/models-by-size" do
    get("Vehicle Models by size -> use GET /hangar/stats/models-by-size") do
      deprecated true
      tags "Vehicles - Stats"
      produces "application/json"

      response(200, "successful") do
        run_test!
      end
    end
  end

  path "/vehicles/stats/models-by-production-status" do
    get("Vehicle Models by ProductionStatus -> use GET /hangar/stats/models-by-production-status") do
      deprecated true
      tags "Vehicles - Stats"
      produces "application/json"

      response(200, "successful") do
        run_test!
      end
    end
  end

  path "/vehicles/stats/models-by-manufacturer" do
    get("models_by_manufacturer vehicle") do
      deprecated true
      tags "Vehicles - Stats"
      produces "application/json"

      response(200, "successful") do
        run_test!
      end
    end
  end

  path "/vehicles/stats/models-by-classification" do
    get("models_by_classification vehicle") do
      deprecated true
      tags "Vehicles - Stats"
      produces "application/json"

      response(200, "successful") do
        run_test!
      end
    end
  end

  path "/vehicles/{username}" do
    parameter name: "username", in: :path, type: :string, description: "username"

    get("public vehicle") do
      deprecated true
      tags "Vehicles - Public"
      produces "application/json"

      response(200, "successful") do
        schema type: :array,
          items: {"$ref": "#/components/schemas/VehicleMinimalPublic"}

        let(:username) { user.username }

        run_test!
      end
    end
  end

  path "/vehicles/{username}/fleetchart" do
    parameter name: "username", in: :path, type: :string, description: "username"

    get("public_fleetchart vehicle") do
      deprecated true
      tags "Vehicles - Public"
      produces "application/json"

      response(200, "successful") do
        schema type: :array,
          items: {"$ref": "#/components/schemas/VehicleMinimalPublic"}

        let(:username) { user.username }

        run_test!
      end
    end
  end

  path "/vehicles/{username}/quick-stats" do
    parameter name: "username", in: :path, type: :string, description: "username"

    get("public_quick_stats vehicle") do
      deprecated true
      tags "Vehicles - Public"
      produces "application/json"

      response(200, "successful") do
        let(:username) { user.username }

        run_test!
      end
    end
  end
end
