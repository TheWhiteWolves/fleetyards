# frozen_string_literal: true

json.array! @images, partial: "api/v1/images/image", locals: {extended: true}, as: :image
