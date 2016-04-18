require 'test_helper'

class ActivityTest < ActiveSupport::TestCase
  setup do
    @west_hawk_lake_trail = trails(:west_hawk_lake)
    @caddy_lake_trail = trails(:caddy_lake)
    @new_activities_json = [{ "name"=>"Activity 1", "unique_id"=>"6-841", "place_id"=>15289, "activity_type_id"=>9, "activity_type_name"=>"snow sports", "url"=>"http://www.snowtoit.com/trail.php?c=73&i=841", "attribs"=>{ "\"type\""=>"\"Lift-serviced \\/ Resort\"" }, "description"=>"Apex Mountain offers a wide array of activities", "length"=>0.0, "activity_type"=>{ "created_at"=>"2012-08-15T17:33:19Z", "id"=>9, "name"=>"snow sports", "updated_at"=>"2012-08-15T17:33:19Z" }, "thumbnail"=>"", "rank"=>nil, "rating"=>5.0},
                            { "name"=>"Activity 2", "unique_id"=>"6-842", "place_id"=>15289, "activity_type_id"=>8, "activity_type_name"=>"hiking", "url"=>"http://www.snowtoit.com/trail.php?c=73&i=841", "attribs"=>{ "\"type\""=>"\"Lift-serviced \\/ Resort\"" }, "description"=>"Apex Mountain offers a wide array of activities", "length"=>0.0, "activity_type"=>{ "created_at"=>"2012-08-15T17:33:19Z", "id"=>8, "name"=>"hiking", "updated_at"=>"2012-08-15T17:33:19Z" }, "thumbnail"=>"", "rank"=>nil, "rating"=>3.0},
                            { "name"=>"Activity 3", "unique_id"=>"6-843", "place_id"=>15289, "activity_type_id"=>7, "activity_type_name"=>"canoeing", "url"=>"http://www.snowtoit.com/trail.php?c=73&i=841", "attribs"=>{ "\"type\""=>"\"Lift-serviced \\/ Resort\"" }, "description"=>"Apex Mountain offers a wide array of activities", "length"=>0.0, "activity_type"=>{ "created_at"=>"2012-08-15T17:33:19Z", "id"=>7, "name"=>"canoeing", "updated_at"=>"2012-08-15T17:33:19Z" }, "thumbnail"=>"", "rank"=>nil, "rating"=>2.0}]
  
    @update_activities_json = [ {"unique_id"=>"1", "length"=>1}, 
                                { "name"=>"Activity 4", "unique_id"=>"6-844", "place_id"=>15289, "activity_type_id"=>7, "activity_type_name"=>"canoeing", "url"=>"http://www.snowtoit.com/trail.php?c=73&i=841", "attribs"=>{ "\"type\""=>"\"Lift-serviced \\/ Resort\"" }, "description"=>"Apex Mountain offers a wide array of activities", "length"=>0.0, "activity_type"=>{ "created_at"=>"2012-08-15T17:33:19Z", "id"=>7, "name"=>"canoeing", "updated_at"=>"2012-08-15T17:33:19Z" }, "thumbnail"=>"", "rank"=>nil, "rating"=>2.0}]

  end

  test "should create new activities" do
    assert_difference('Activity.count', 3) do
      Activity.update_or_create_activities_from_json(@new_activities_json, @west_hawk_lake_trail)
    end
  end

  test "should insert new activity for trail that already has activities" do
    assert_difference('Activity.count', 1) do
      Activity.update_or_create_activities_from_json(@update_activities_json, @caddy_lake_trail)
    end
  end

  test "should update an existing activity" do
    Activity.update_or_create_activities_from_json(@update_activities_json, @caddy_lake_trail)
    assert_equal(1, Activity.find_by(unique_id: 1).length)
  end 

end
