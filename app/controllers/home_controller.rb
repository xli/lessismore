class HomeController < ApplicationController
  skip_before_filter :authenticate_user!, :only => ['index']

  def dashboard
    @continuous_deployments = current_user.continuous_deployments
    render :layout => 'dashboard'
  end
end
