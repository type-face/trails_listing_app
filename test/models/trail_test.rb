require 'test_helper'

class TrailTest < ActiveSupport::TestCase

  setup do
    @caddy_lake_trail = trails(:caddy_lake)
    @updated_city_name = "Updated City"
    @update_caddy_lake_trail_json = { :city=>@updated_city_name, :state=>"Manitoba", :country=>"Canada", :name=>"Caddy Lake", :parent_id=>nil, :unique_id=>1, :directions=>"Turn left off Hwy 1 before West Hawk Lake", :lat=>49.893332, :lon=>-97.142216, :description=>nil, :date_created=>nil, :children=>[], :activities=>[{ "name"=>"Caddy Lake", "unique_id"=>"000", "place_id"=>1, "activity_type_id"=>9, "activity_type_name"=>"canoeing", "url"=>"", "attribs"=>{ "\"type\""=>"\"Lift-serviced \\/ Resort\"" }, "description"=>"These are the updated directions for Caddy Lake canoeing activity", "length"=>0.0, "activity_type"=>{ "created_at"=>"2012-08-15T17:33:19Z", "id"=>9, "name"=>"canoeing", "updated_at"=>"2012-08-15T17:33:19Z" }, "thumbnail"=>"", "rank"=>nil, "rating"=>0.0}] } 
    @conflict_trail_json = { :city=>"Winnipeg", :state=>"Manitoba", :country=>"Canada", :name=>"Caddy Lake", :parent_id=>nil, :unique_id=>2, :directions=>"Turn left off Hwy 1 before West Hawk Lake", :lat=>49.893332, :lon=>-97.142216, :description=>nil, :date_created=>nil, :children=>[], :activities=>[{ "name"=>"Caddy Lake", "unique_id"=>"000", "place_id"=>1, "activity_type_id"=>9, "activity_type_name"=>"canoeing", "url"=>"", "attribs"=>{ "\"type\""=>"\"Lift-serviced \\/ Resort\"" }, "description"=>"These are the updated directions for Caddy Lake canoeing activity", "length"=>0.0, "activity_type"=>{ "created_at"=>"2012-08-15T17:33:19Z", "id"=>9, "name"=>"canoeing", "updated_at"=>"2012-08-15T17:33:19Z" }, "thumbnail"=>"", "rank"=>nil, "rating"=>0.0}] } 
    @new_trail_json = { :city=>"Penticton", :state=>"British Columbia", :country=>"Canada", :name=>"Apex Mountain Resort", :parent_id=>nil, :unique_id=>15289, :directions=>nil, :lat=>49.389847, :lon=>-119.900606, :description=>nil, :date_created=>nil, :children=>[], :activities=>[{ "name"=>"Apex Mountain Resort", "unique_id"=>"6-841", "place_id"=>15289, "activity_type_id"=>9, "activity_type_name"=>"snow sports", "url"=>"http://www.snowtoit.com/trail.php?c=73&i=841", "attribs"=>{ "\"type\""=>"\"Lift-serviced \\/ Resort\"" }, "description"=>"Apex Mountain offers a wide array of activities", "length"=>0.0, "activity_type"=>{ "created_at"=>"2012-08-15T17:33:19Z", "id"=>9, "name"=>"snow sports", "updated_at"=>"2012-08-15T17:33:19Z" }, "thumbnail"=>"", "rank"=>nil, "rating"=>0.0}] } 
  end

  test "should create trail with unique_id" do
    new_trail = Trail.new(name: 'West Hawk Lake', unique_id: '101')
    assert new_trail.save  
  end

  test "should not create a trail with a duplicate unique_id" do
    new_trail = Trail.new(name: 'West Hawk Lake', unique_id: '1')
    assert_not new_trail.save
  end

  test "should create trail from json" do
    assert_difference('Trail.count') do
      Trail.update_or_create_trail_from_json(@new_trail_json)
    end
  end

  test "should update trail from json" do
    assert Trail.update_or_create_trail_from_json(@update_caddy_lake_trail_json, @caddy_lake_trail)
    assert_equal(@caddy_lake_trail.city, @updated_city_name)
  end

  test "should not update trail and will raise error from json if unique_id already exists in database" do
    assert_raise do
      Trail.update_or_create_trail_from_json(@conflict_trail_json, @caddy_lake_trail)
    end
  end

end
