class HomeController < ApplicationController
  def index
    @commit_logs = CommitLog.all
  end

  def dashboard
    render :layout => 'dashboard'
  end
end
