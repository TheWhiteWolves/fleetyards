# frozen_string_literal: true

json.array! @groups, partial: "api/v1/hangar_groups/minimal", as: :group
