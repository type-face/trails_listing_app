class TrailsController < ApplicationController
  require 'unirest'
  require 'htmlentities'

  before_action :set_trail, only: [:show]

  # GET /trails
  # GET /trails.json
  def index
    response = trail_api_request
    Trail.create_from_api_response(response) if response.code == 200
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
      response = Rails.cache.fetch('trails_cache', expires_in: 7.days) do
      Rails.logger.info "#{Time.now} TRAIL API REQUEST"
        Unirest.get "https://trailapi-trailapi.p.mashape.com/?limit=100&q[state_cont]=British+Columbia&q[country_cont]=Canada",
            headers:{
              "X-Mashape-Key" => Rails.application.secrets.x_mashape_key,
              "Accept" => "application/json"
            }
      end

      return response
    end

end
