# encoding: utf-8
# frozen_string_literal: true

module Resolvers
  class Vehicles < Resolvers::Base
    def resolve
      return detail if args[:slug].present?

      collection
    end

    def collection
      search = Ship.enabled
                   .ransack(args[:q].to_h)

      search.sorts = 'name asc' if search.sorts.empty?

      search.result
            .offset(args[:offset])
            .limit(args[:limit])
    end

    private def detail
      Ship.enabled.find_by(slug: args[:slug])
    end
  end
end
