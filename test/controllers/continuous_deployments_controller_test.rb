require 'test_helper'

class ContinuousDeploymentsControllerTest < ActionController::TestCase
  setup do
    @continuous_deployment = continuous_deployments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:continuous_deployments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create continuous_deployment" do
    assert_difference('ContinuousDeployment.count') do
      post :create, continuous_deployment: { deployed_revision_extract_regex: @continuous_deployment.deployed_revision_extract_regex, deployed_revision_url: @continuous_deployment.deployed_revision_url, git_repo_cloned: @continuous_deployment.git_repo_cloned, git_repo_url: @continuous_deployment.git_repo_url, name: @continuous_deployment.name }
    end

    assert_redirected_to continuous_deployment_path(assigns(:continuous_deployment))
  end

  test "should show continuous_deployment" do
    get :show, id: @continuous_deployment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @continuous_deployment
    assert_response :success
  end

  test "should update continuous_deployment" do
    patch :update, id: @continuous_deployment, continuous_deployment: { deployed_revision_extract_regex: @continuous_deployment.deployed_revision_extract_regex, deployed_revision_url: @continuous_deployment.deployed_revision_url, git_repo_cloned: @continuous_deployment.git_repo_cloned, git_repo_url: @continuous_deployment.git_repo_url, name: @continuous_deployment.name }
    assert_redirected_to continuous_deployment_path(assigns(:continuous_deployment))
  end

  test "should destroy continuous_deployment" do
    assert_difference('ContinuousDeployment.count', -1) do
      delete :destroy, id: @continuous_deployment
    end

    assert_redirected_to continuous_deployments_path
  end
end
