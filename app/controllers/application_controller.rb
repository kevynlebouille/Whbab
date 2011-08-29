class ApplicationController < ActionController::Base
  protect_from_forgery

  layout Proc.new { |controller| controller.request.xhr? ? false : 'application' }

  def after_sign_in_path_for(resource_or_scope)
    army_lists_path
  end
end
