class BaseController < ApplicationController
  skip_authorization_check
  before_filter :authenticate_user!, only: []

  def index
  end

  def impressum
    content = File.read Rails.root.join("texts", I18n.locale.to_s, "impressum.md")
    @text = Metadown.render(content)
  end

  def privacy
    content = File.read Rails.root.join("texts", I18n.locale.to_s, "privacy.md")
    @text = Metadown.render(content)
  end
end
