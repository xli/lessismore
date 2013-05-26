class ContinuousDeploymentsController < ApplicationController
  before_action :set_continuous_deployment, only: [:show, :edit, :update, :destroy]

  # GET /continuous_deployments
  # GET /continuous_deployments.json
  def index
    @continuous_deployments = current_user.continuous_deployments
  end

  # GET /continuous_deployments/1
  # GET /continuous_deployments/1.json
  def show
  end

  # GET /continuous_deployments/new
  def new
    @continuous_deployment = ContinuousDeployment.new
  end

  # GET /continuous_deployments/1/edit
  def edit
  end

  # POST /continuous_deployments
  # POST /continuous_deployments.json
  def create
    @continuous_deployment = current_user.continuous_deployments.create(continuous_deployment_params)

    respond_to do |format|
      if @continuous_deployment.save
        format.html { redirect_to @continuous_deployment, notice: 'Continuous deployment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @continuous_deployment }
      else
        format.html { render action: 'new' }
        format.json { render json: @continuous_deployment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /continuous_deployments/1
  # PATCH/PUT /continuous_deployments/1.json
  def update
    respond_to do |format|
      if @continuous_deployment.update(continuous_deployment_params)
        format.html { redirect_to @continuous_deployment, notice: 'Continuous deployment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @continuous_deployment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /continuous_deployments/1
  # DELETE /continuous_deployments/1.json
  def destroy
    @continuous_deployment.destroy
    respond_to do |format|
      format.html { redirect_to continuous_deployments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_continuous_deployment
      @continuous_deployment = current_user.continuous_deployments.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def continuous_deployment_params
      params.require(:continuous_deployment).permit(:name, :deployed_revision_url, :deployed_revision_extract_regex, :git_repo_url, :git_repo_cloned)
    end
end
