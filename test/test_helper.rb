ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  @trail_json = { :city=>"Penticton", :state=>"British Columbia", :country=>"Canada", :name=>"Apex Mountain Resort", :parent_id=>nil, :unique_id=>15289, :directions=>nil, :lat=>49.389847, :lon=>-119.900606, :description=>nil, :date_created=>nil, :children=>[], :activities=>[{ "name"=>"Apex Mountain Resort", "unique_id"=>"6-841", "place_id"=>15289, "activity_type_id"=>9, "activity_type_name"=>"snow sports", "url"=>"http://www.snowtoit.com/trail.php?c=73&i=841", "attribs"=>{ "\"type\""=>"\"Lift-serviced \\/ Resort\"" }, "description"=>"Apex Mountain offers a wide array of activities in addition to skiing and snowboarding. Visitors have access to snow shoeing, snow tubing, ice skating, and nordic skiing. &lt;br /&gt;<br />&lt;br /&gt;<br />The mountain receives 236 inches in annual snowfall and sits at an elevation of 7,200 feet. The 2,000 vertical feet are covered quickly by the 3 lifts and a tube tow at a rate of 6,700 riders per hour. &lt;br /&gt;<br />&lt;br /&gt;<br />Apex Mountain Resort boasts 59 trails (according to the trail map), of which 10 are beginner, 20 are more difficult, 20 are most difficult, and 9 are expert. The longest trail is Grandfather's Trail at 5 km (3.1 miles). Other popular trails include Highway 97 and Juniper.", "length"=>0.0, "activity_type"=>{ "created_at"=>"2012-08-15T17:33:19Z", "id"=>9, "name"=>"snow sports", "updated_at"=>"2012-08-15T17:33:19Z" }, "thumbnail"=>"http://images.snowtoit.com/2011/10/841-0.jpg", "rank"=>nil, "rating"=>0.0}] } 
  @trail_json_updated = @trail_json
  @trail_json_updated[:city] = "Updated City"

  # Add more helper methods to be used by all tests here...
  VCR.configure do |c|
    c.cassette_library_dir = 'test/vcr_cassettes'
    c.hook_into :webmock
  end

end
