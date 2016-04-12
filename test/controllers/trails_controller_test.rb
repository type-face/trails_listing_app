require 'test_helper'

class TrailsControllerTest < ActionController::TestCase

  test "should create Trails from API data" do
    VCR.use_cassette("trails_api_call") do
      assert_difference('Trail.count', 500) do
        get :index
      end
    end
  end

end
