# frozen_string_literal: true

# == Schema Information
#
# Table name: celestial_objects
#
#  id                :uuid             not null, primary key
#  code              :string
#  description       :text
#  designation       :string
#  fairchanceact     :boolean          default(FALSE)
#  habitable         :boolean          default(FALSE)
#  hidden            :boolean          default(TRUE)
#  last_updated_at   :datetime
#  name              :string
#  object_type       :string
#  orbit_period      :string
#  sensor_danger     :integer
#  sensor_economy    :integer
#  sensor_population :integer
#  size              :string
#  slug              :string
#  status            :string
#  store_image       :string
#  sub_type          :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  parent_id         :uuid
#  rsi_id            :integer
#  starsystem_id     :uuid
#
# Indexes
#
#  index_celestial_objects_on_starsystem_id  (starsystem_id)
#
class CelestialObject < ApplicationRecord
  paginates_per 30

  searchkick searchable: %i[name starsystem],
    word_start: %i[name]

  def search_data
    {
      name:,
      starsystem: starsystem&.name
    }
  end

  def should_index?
    !hidden
  end

  belongs_to :starsystem, optional: true

  belongs_to :parent,
    class_name: "CelestialObject",
    optional: true

  has_many :moons,
    class_name: "CelestialObject",
    foreign_key: :parent_id,
    inverse_of: :parent,
    dependent: :destroy

  has_many :affiliations,
    as: :affiliationable,
    dependent: :destroy
  has_many :factions, through: :affiliations

  before_save :update_slugs

  mount_uploader :store_image, StoreImageUploader

  DEFAULT_SORTING_PARAMS = ["parent_id desc", "designation asc"]
  ALLOWED_SORTING_PARAMS = [
    "name asc", "name desc", "parent_id asc", "parent_id desc", "designation asc",
    "designation desc"
  ]

  ransack_alias :starsystem, :starsystem_slug
  ransack_alias :parent, :parent_slug
  ransack_alias :name, :name_or_slug
  ransack_alias :search, :name_or_slug_or_starsystem_slug

  def self.ransackable_attributes(auth_object = nil)
    [
      "code", "created_at", "description", "designation", "fairchanceact", "habitable", "hidden",
      "id", "id_value", "last_updated_at", "name", "object_type", "orbit_period", "parent",
      "parent_id", "rsi_id", "search", "sensor_danger", "sensor_economy", "sensor_population",
      "size", "slug", "starsystem", "starsystem_id", "status", "store_image", "sub_type",
      "updated_at"
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    ["affiliations", "factions", "moons", "parent", "starsystem"]
  end

  def self.main
    where(parent_id: nil)
  end

  def self.planet
    where(object_type: "PLANET")
  end

  def self.moon
    where(object_type: "SATELLITE")
  end

  def self.visible
    where(hidden: false)
  end

  def location_label
    if starsystem.present?
      I18n.t("activerecord.attributes.celestial_object.location_prefix.default", starsystem: starsystem.name)
    end
  end
end
