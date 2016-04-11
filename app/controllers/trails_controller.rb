class TrailsController < ApplicationController
  require 'unirest'
  require 'htmlentities'

  before_action :set_trail, only: [:show]

  # GET /trails
  # GET /trails.json
  def index
    response = trail_api_request

    if response.code == '200'
      response_body = response.body.symbolize_keys!
      response_body[:places].each do |trail|
        trail.symbolize_keys!
        decoder = HTMLEntities.new
        new_trail = Trail.new(city:       trail[:city], 
                              state:      trail[:state],
                              country:    trail[:country],
                              name:       decoder.decode(trail[:name]),
                              unique_id:  trail[:unique_id],
                              directions: decoder.decode(trail[:directions]),
                              lat:        trail[:lat],
                              lon:        trail[:lon]
                              )

        if new_trail.valid?
          new_trail.save

          trail[:activities].each do |activity|
            activity.symbolize_keys!
            Activity.create(name:                 activity[:name],
                            unique_id:            activity[:unique_id],
                            trail_id:             new_trail.id,
                            activity_type_name:   activity[:activity_type_name],
                            url:                  activity[:url],
                            description:          activity[:description],
                            length:               activity[:length],
                            rating:               activity[:rating]
                            )
          end unless trail[:activities].empty?
        end
      end
    end

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
      Rails.cache.fetch("trails_cache", expires_in: 7.days) do
        Unirest.get "https://trailapi-trailapi.p.mashape.com/?limit=100&q[state_cont]=British+Columbia&q[country_cont]=Canada",
            headers:{
              "X-Mashape-Key" => Rails.application.secrets.x_mashape_key,
              "Accept" => "application/json"
            }
      end
    end

end
