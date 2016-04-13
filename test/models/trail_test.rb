require 'test_helper'

class TrailTest < ActiveSupport::TestCase

  setup do
    @caddy_lake_trail = trails(:caddy_lake)    
  end

  test "should create trail with unique_id" do
    new_trail = Trail.new(name: 'West Hawk Lake', unique_id: '101')
    assert new_trail.save  
  end

  test "should not create a trail with a duplicate unique_id" do
    new_trail = Trail.new(name: 'West Hawk Lake', unique_id: '1')
    assert_not new_trail.save
  end

end
