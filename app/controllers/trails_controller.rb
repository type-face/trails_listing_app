class TrailsController < ApplicationController
  before_action :set_trail, only: [:show]

  # GET /trails
  # GET /trails.json
  def index
    trail_api_request
    @trails = Trail.order(:city).order(:name)
  end

  # GET /trails/1
  # GET /trails/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trail
      @trail = Trail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trail_params
      params.require(:trail).permit(:city, :state, :country, :name, :unique_id, :directions, :lat, :lon, :activity_id)
    end

    def trail_api_request
      Rails.cache.fetch('trails_cache', expires_in: 7.days) do
        Rails.logger.info "#{Time.now} TRAIL API REQUEST"
        response = Unirest.get "https://trailapi-trailapi.p.mashape.com/?limit=200&q[state_cont]=British+Columbia&q[country_cont]=Canada",
            headers:{
              "X-Mashape-Key" => Rails.application.secrets.x_mashape_key,
              "Accept" => "application/json"
            }
        Trail.create_from_api_response(response) if response.code == 200
      end
    end

end
