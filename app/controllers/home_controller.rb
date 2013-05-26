class HomeController < ApplicationController
  skip_before_filter :authenticate_user!, :only => ['index']

  def dashboard
    render :layout => 'dashboard'
  end
end
