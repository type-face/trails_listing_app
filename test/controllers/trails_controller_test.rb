require 'test_helper'

class TrailsControllerTest < ActionController::TestCase

  setup do
    Rails.cache.clear
  end

  test "should create Trails from API data" do
    VCR.use_cassette("trails_api_call", match_requests_on: [:method, VCR.request_matchers.uri_without_param(:limit)]) do
      assert_difference('Trail.count', 50) do
        get :index
      end
    end
  end

end
