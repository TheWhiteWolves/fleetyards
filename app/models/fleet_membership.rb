# frozen_string_literal: true

class FleetMembership < ApplicationRecord
  belongs_to :fleet, touch: true
  belongs_to :user

  enum ships_filter: { purchased: 0, hangar_group: 1, hide: 2 }, _prefix: true

  enum role: { admin: 0, officer: 1, member: 2 }
  ransacker :role, formatter: proc { |v| FleetMembership.roles[v] } do |parent|
    parent.table[:role]
  end

  ransack_alias :username, :user_username

  after_create :notify_user
  after_save :set_primary

  def set_primary
    return unless primary?

    # rubocop:disable Rails/SkipsModelValidations
    FleetMembership.where(user_id: user_id, primary: true)
                   .where.not(id: id)
                   .update_all(primary: false)
    # rubocop:enable Rails/SkipsModelValidations
  end

  def notify_user
    return unless invitation

    FleetMembershipMailer.new_invite(user.email, fleet).deliver_later
  end

  def visible_vehicle_ids
    visibile_vehicles.pluck(:id)
  end

  def visible_model_ids
    visibile_vehicles.pluck(:model_id)
  end

  def visibile_vehicles
    return unless ships_filter_purchased? || ships_filter_hangar_group?

    return user.vehicles.includes(:task_forces).where(task_forces: { hangar_group_id: hangar_group_id }) if ships_filter_hangar_group? && hangar_group_id.present?

    user.vehicles.where(loaner: false).purchased if ships_filter_purchased?
  end

  def invitation
    accepted_at.blank? && declined_at.blank?
  end

  def promote
    return if admin?

    if officer?
      update(role: :admin)
    else
      update(role: :officer)
    end
  end

  def demote
    return if member?

    if admin?
      update(role: :officer)
    else
      update(role: :member)
    end
  end
end
