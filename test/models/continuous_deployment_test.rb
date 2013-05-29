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
end
