# frozen_string_literal: true

json.cache! ["v1", component] do
  json.partial!("admin/api/v1/components/base", component:)
end
