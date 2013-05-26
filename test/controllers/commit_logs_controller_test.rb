require 'test_helper'

class CommitLogsControllerTest < ActionController::TestCase
  setup do
    @commit_log = commit_logs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:commit_logs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create commit_log" do
    assert_difference('CommitLog.count') do
      post :create, commit_log: { name: @commit_log.name, repository_url: @commit_log.repository_url, since: @commit_log.since }
    end

    assert_redirected_to commit_log_path(assigns(:commit_log))
  end

  test "should show commit_log" do
    get :show, id: @commit_log
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @commit_log
    assert_response :success
  end

  test "should update commit_log" do
    patch :update, id: @commit_log, commit_log: { name: @commit_log.name, repository_url: @commit_log.repository_url, since: @commit_log.since }
    assert_redirected_to commit_log_path(assigns(:commit_log))
  end

  test "should destroy commit_log" do
    assert_difference('CommitLog.count', -1) do
      delete :destroy, id: @commit_log
    end

    assert_redirected_to commit_logs_path
  end
end
