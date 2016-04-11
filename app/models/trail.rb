class Trail < ActiveRecord::Base

  validates :unique_id, uniqueness: true

  has_many :activities

  def self.create_from_api_response(response)
    Rails.logger.info "#{Time.now} #{__FILE__} #{__method__}"
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
        Rails.logger.info "#{Time.now}: NEW #{self.class.upcase}, id: new_trail.id"
        
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
end
