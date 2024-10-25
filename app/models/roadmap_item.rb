# frozen_string_literal: true

# == Schema Information
#
# Table name: roadmap_items
#
#  id                  :uuid             not null, primary key
#  active              :boolean          default(FALSE)
#  body                :text
#  committed           :boolean          default(FALSE)
#  completed           :integer
#  description         :text
#  image               :string
#  inprogress          :integer
#  name                :string
#  release             :string
#  release_description :text
#  released            :boolean          default(FALSE)
#  store_image         :string
#  tasks               :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  model_id            :uuid
#  rsi_category_id     :integer
#  rsi_id              :integer
#  rsi_release_id      :integer
#
class RoadmapItem < ApplicationRecord
  MODELS_CATEGORY = 6

  has_paper_trail on: %i[create update], only: %i[release committed active]

  belongs_to :model, optional: true

  mount_uploader :store_image, StoreImageUploader

  DEFAULT_SORTING_PARAMS = ["rsi_category_id asc", "name asc"]
  ALLOWED_SORTING_PARAMS = ["name asc", "name desc", "rsi_category_id asc", "rsi_category_id desc"]

  ransack_alias :last_updated_at, :versions_created_at

  def self.ransackable_attributes(auth_object = nil)
    [
      "active", "body", "committed", "completed", "created_at", "description", "id", "id_value",
      "image", "inprogress", "last_updated_at", "model_id", "name", "release",
      "release_description", "released", "rsi_category_id", "rsi_id", "rsi_release_id",
      "store_image", "tasks", "updated_at"
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    ["model", "versions"]
  end

  def self.active
    where(active: true)
  end

  def last_version(max_created_at = nil)
    max_created_at = 1.day.from_now.to_date if max_created_at.nil?
    versions.where("created_at < ?", max_created_at).last
  end

  def last_version_changed_at(max_created_at = nil)
    max_created_at = 1.day.from_now.to_date if max_created_at.nil?
    last_version(max_created_at)&.created_at || created_at
  end
end
