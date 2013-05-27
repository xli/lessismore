class HomeController < ApplicationController
  skip_before_filter :authenticate_user!, :only => ['index']

  def dashboard
    @continuous_deployments = current_user.continuous_deployments
    render :layout => 'dashboard'
  end

  def test_revision_extraction
    revision = begin
      DeployedRevision.fetch(params[:url], params[:extract_regex])
    rescue => e
      "Error: #{e.message}"
    end
    render :text => revision
  end
end
