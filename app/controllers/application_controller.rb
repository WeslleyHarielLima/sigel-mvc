
class ApplicationController < ActionController::Base
  include Pagy::Backend
  # include LayoutByUser
  # include DevisePermittedParameters
  before_action :authenticate_user!
end
