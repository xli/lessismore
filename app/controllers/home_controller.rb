class HomeController < ApplicationController
  def dashboard
    render :action => 'index', :layout => 'dashboard'
  end
end
