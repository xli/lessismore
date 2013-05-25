class CommitLogsController < ApplicationController
  before_action :set_commit_log, only: [:show, :edit, :update, :destroy]

  # GET /commit_logs
  # GET /commit_logs.json
  def index
    @commit_logs = CommitLog.all
  end

  # GET /commit_logs/1
  # GET /commit_logs/1.json
  def show
  end

  # GET /commit_logs/new
  def new
    @commit_log = CommitLog.new
  end

  # GET /commit_logs/1/edit
  def edit
  end

  # POST /commit_logs
  # POST /commit_logs.json
  def create
    @commit_log = CommitLog.new(commit_log_params)

    respond_to do |format|
      if @commit_log.save
        format.html { redirect_to @commit_log, notice: 'Commit log was successfully created.' }
        format.json { render action: 'show', status: :created, location: @commit_log }
      else
        format.html { render action: 'new' }
        format.json { render json: @commit_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /commit_logs/1
  # PATCH/PUT /commit_logs/1.json
  def update
    respond_to do |format|
      if @commit_log.update(commit_log_params)
        format.html { redirect_to @commit_log, notice: 'Commit log was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @commit_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /commit_logs/1
  # DELETE /commit_logs/1.json
  def destroy
    @commit_log.destroy
    respond_to do |format|
      format.html { redirect_to commit_logs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_commit_log
      @commit_log = CommitLog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def commit_log_params
      params.require(:commit_log).permit(:name, :repository_url, :since, :until)
    end
end
