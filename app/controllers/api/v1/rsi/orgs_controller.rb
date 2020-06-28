# frozen_string_literal: true

require 'rsi/orgs_loader'

module Api
  module V1
    module Rsi
      class OrgsController < ::Api::BaseController
        skip_authorization_check
        before_action :authenticate_user!, only: %i[]

        def show
          success, @org = ::RSI::OrgsLoader.new.fetch(params[:sid].downcase)

          return if success

          render json: { code: 'rsi.org.not_found', message: 'Could not find Org' }, status: :not_found
        end
      end
    end
  end
end
