# frozen_string_literal: true

json.array! @vehicles, partial: "api/v1/vehicles/vehicle", as: :vehicle
