# frozen_string_literal: true

json.id item.id
json.name item.name
json.release item.release
json.release_description item.release_description
json.rsi_release_id item.rsi_release_id
json.description item.description
json.body item.body
json.rsi_category_id item.rsi_category_id
json.image item.image
json.media do
  json.store_image do
    json.partial! "api/v1/shared/media_image", media_image: item.store_image
  end
end
json.store_image item.store_image.url
json.store_image_large item.store_image.large.url
json.store_image_medium item.store_image.medium.url
json.store_image_small item.store_image.small.url
json.released item.released
json.committed item.committed
json.active item.active
