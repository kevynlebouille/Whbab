class HomeController < ApplicationController
  def index
    redirect_to(army_lists_path) if user_signed_in?
  end
end
