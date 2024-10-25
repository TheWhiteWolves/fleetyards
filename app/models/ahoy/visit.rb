# frozen_string_literal: true

# == Schema Information
#
# Table name: ahoy_visits
#
#  id               :bigint           not null, primary key
#  accept_language  :string
#  browser          :string
#  device_type      :string
#  ip               :string
#  landing_page     :text
#  os               :string
#  referrer         :text
#  referring_domain :string
#  started_at       :datetime
#  user_agent       :text
#  visit_token      :string
#  visitor_token    :string
#  user_id          :uuid
#
# Indexes
#
#  index_ahoy_visits_on_user_id                       (user_id)
#  index_ahoy_visits_on_visit_token                   (visit_token) UNIQUE
#  index_ahoy_visits_on_visitor_token_and_started_at  (visitor_token,started_at)
#
module Ahoy
  class Visit < ApplicationRecord
    self.table_name = "ahoy_visits"

    has_many :events, class_name: "Ahoy::Event", dependent: :nullify
    belongs_to :user, optional: true

    def self.without_users(user_ids)
      where.not(user_id: user_ids).or(where(user_id: nil))
    end

    def self.one_month
      where(started_at: 1.month.ago...Time.zone.now.beginning_of_day)
    end

    def self.one_year
      where(started_at: 1.year.ago..)
    end
  end
end
