# frozen_string_literal: true

json.array! @commodity_prices, partial: "admin/api/v1/commodity_prices/commodity_price", locals: {extended: true}, as: :commodity_price
