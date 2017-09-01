# encoding: utf-8
# frozen_string_literal: true

class RsiUser
  attr_accessor :username, :avatar, :handle, :title, :enlisted,
                :citizen_record, :location, :languages, :orgs

  def initialize(args = {})
    self.username = args[:username]
    self.handle = args[:handle]
    self.avatar = args[:avatar]
    self.title = args[:title]
    self.enlisted = args[:enlisted]
    self.citizen_record = args[:citizen_record]
    self.location = args[:location]
    self.languages = args[:languages]
    self.orgs = args[:orgs]
  end
end
