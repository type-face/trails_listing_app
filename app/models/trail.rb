class Trail < ActiveRecord::Base
  validates :unique_id, uniqueness: true

  has_many :activities

  def self.create_from_api_response(response)
    Rails.logger.info "#{Time.now} #{__FILE__} #{__method__}"
    existing_trails = Trail.all.pluck(:unique_id)
    
    response_body = response.body.symbolize_keys!
    response_body[:places].each do |trail_json|
      trail_json.symbolize_keys!
      if !existing_trails.include?(trail_json[:unique_id])
        update_or_create_trail_from_json(trail_json)
      end
    end
  end

  def self.update_or_create_trail_from_json(trail_json, trail_to_update = Trail.new)
    decoder = HTMLEntities.new
    trail_to_update.assign_attributes(city:       trail_json[:city], 
                                      state:      trail_json[:state],
                                      country:    trail_json[:country],
                                      name:       decoder.decode(trail_json[:name]),
                                      unique_id:  trail_json[:unique_id],
                                      directions: decoder.decode(trail_json[:directions]),
                                      lat:        trail_json[:lat],
                                      lon:        trail_json[:lon]
                                      )
      trail_saved = trail_to_update.save
      if trail_saved
        Rails.logger.info "#{Time.now}: NEW TRAIL - id: #{trail_to_update.id}"  
        Activity.update_or_create_activities_from_json(trail_json[:activities], trail_to_update.id) unless trail_json[:activities].empty?
      end

    return trail_saved
  end
end
