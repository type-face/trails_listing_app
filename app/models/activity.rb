class Activity < ActiveRecord::Base
  belongs_to :trail

  def self.update_or_create_activities_from_json(activities_json, trail)
    activities_json.each do |activity|
      activity.symbolize_keys!
      activity_to_update = Activity.find_or_create_by!(unique_id: activity[:unique_id])

      activity_to_update.assign_attributes(name:                  activity[:name],
                                            trail_id:             trail.id,
                                            activity_type_name:   activity[:activity_type_name],
                                            url:                  activity[:url],
                                            description:          activity[:description],
                                            length:               activity[:length],
                                            rating:               activity[:rating]
                                          )

      if activity_to_update.changed? && activity_to_update.save!
        Rails.logger.info "#{Time.now}: MODIFIED ACTIVITY - id: #{activity_to_update.id}" 
      end
    end
  end
end
