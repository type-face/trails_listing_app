class Trail < ActiveRecord::Base
  validates :unique_id, uniqueness: true

  has_many :activities

  def self.create_from_api_response(response)
    Rails.logger.info "#{Time.now} #{__FILE__} #{__method__}"
    existing_trails = Trail.all.pluck(:unique_id)
    
    response_body = response.body.symbolize_keys!
    response_body[:places].each do |trail|
      trail.symbolize_keys!
      if !existing_trails.include?(trail[:unique_id])
        new_trail = new_from_json(trail)

        if new_trail.valid?
          Rails.logger.info "#{Time.now}: NEW TRAIL - id: #{new_trail.id}" if new_trail.save 
          Activity.create_activities_from_json(trail[:activities], new_trail.id) unless trail[:activities].empty?
        end
      end
    end
  end

  def self.new_from_json(trail)
    decoder = HTMLEntities.new
    Trail.new(city:       trail[:city], 
              state:      trail[:state],
              country:    trail[:country],
              name:       decoder.decode(trail[:name]),
              unique_id:  trail[:unique_id],
              directions: decoder.decode(trail[:directions]),
              lat:        trail[:lat],
              lon:        trail[:lon]
              )
  end
end
