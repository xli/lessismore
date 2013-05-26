class HomeController < ApplicationController
  def dashboard
    render :layout => 'dashboard'
  end
end
