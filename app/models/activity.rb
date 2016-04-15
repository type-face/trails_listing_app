class Activity < ActiveRecord::Base
  belongs_to :trail

  def self.update_or_create_activities_from_json(activities_json, parent_id, activity_to_update = Activity.new)
    activities_json.each do |activity|
      activity.symbolize_keys!
      activity_to_update.assign_attributes(name:                  activity[:name],
                                            unique_id:            activity[:unique_id],
                                            trail_id:             parent_id,
                                            activity_type_name:   activity[:activity_type_name],
                                            url:                  activity[:url],
                                            description:          activity[:description],
                                            length:               activity[:length],
                                            rating:               activity[:rating]
                                            )

      Rails.logger.info "#{Time.now}: NEW ACTIVITY - id: #{activity_to_update.id}" if activity_to_update.save 
    end
  end
end
