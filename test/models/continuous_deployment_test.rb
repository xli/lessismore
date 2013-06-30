require 'test_helper'

class ContinuousDeploymentTest < ActiveSupport::TestCase

  def test_deployed_revision
    cd = continuous_deployments(:cloned_no_deploy)
    assert_nil cd.deployed_revision
    cd.deployed_revisions.create!(version: 'v1')
    assert_equal 'v1', cd.deployed_revision

    cd.deployed_revisions.create!(version: 'v2')
    assert_equal 'v2', cd.deployed_revision

    cd.deployed_revisions.create!(version: 'v3')
    assert_equal 'v3', cd.deployed_revision
  end

  def test_rename_should_not_change_git_repo_dir
    cd = continuous_deployments(:cloned_no_deploy)
    FileUtils.touch(cd.git_repo.repo_dir)
    path1 = cd.git_repo.repo_dir
    assert File.exists?(path1)
    cd.update_attribute(:name, 'newname')

    assert_equal path1, cd.git_repo.repo_dir
    assert File.exists?(cd.git_repo.repo_dir)
  end

  def test_change_git_repo_should_also_change_cloned_status
    cd = continuous_deployments(:cloned_no_deploy)
    cd.update_attribute(:git_repo_url, 'newurl')
    cd.reload
    assert !cd.git_repo_cloned?
  end

  def test_update_git_repo_cloned_status
    cd = continuous_deployments(:cloned_no_deploy)
    cd.update_attribute(:git_repo_cloned, false)
    assert !cd.git_repo_cloned?
  end
  
  def test_show_stories_with_projects_waiting_for_deployment
    cd = continuous_deployments(:cloned_no_deploy)
    commit_12345 = OpenStruct.new( message: "project1/#12345 - committing for awesome story")
    another_commit_12345 = OpenStruct.new( message: "project1/#12345 - committing for awesome story - with some changes")
    commit_789 = OpenStruct.new( message: "#789 - this story is almost done")
    commit_build_fix = OpenStruct.new( message: "Build Fix - changing assertion to remove flakiness")
    commits = [commit_789, commit_build_fix, commit_12345, another_commit_12345]
    stories = cd.waiting_deployment_stories(commits)
    assert stories.include?( { "project1" => "12345"})
    assert stories.include?( {"mingle" =>"789" } )
  end

  def test_show_stories_with_projects_waiting_for_deployment
    cd = continuous_deployments(:cloned_no_deploy)
    commit_12345 = OpenStruct.new( message: "project1/#12345 - committing for awesome story")
    another_commit_12345 = OpenStruct.new( message: "project1/#12345 - committing for awesome story - with some changes")
    commit_789 = OpenStruct.new( message: "#789 - this story is almost done")
    commit_build_fix = OpenStruct.new( message: "Build Fix - changing assertion to remove flakiness")
    commits = [commit_789, commit_build_fix, commit_12345, another_commit_12345]
    stories = cd.waiting_deployment_stories(commits)
    assert_equal [commit_789], stories["mingle1"]["789"]
    assert_equal [commit_12345, another_commit_12345], stories["project1"]["12345"]
  end

end
