class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for
    army_lists_url
  end
end
