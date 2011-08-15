class HomeController < ApplicationController
  def index
    redirect_to(army_lists_path) and return if user_signed_in?

    render :layout => 'home'
  end
end
