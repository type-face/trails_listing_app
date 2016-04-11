class Activity < ActiveRecord::Base
  belongs_to :trail

  def self.create_activities_from_json(activities, parent_id)
    activities.each do |activity|
      activity.symbolize_keys!
      new_activity = Activity.new(name:     activity[:name],
                      unique_id:            activity[:unique_id],
                      trail_id:             parent_id,
                      activity_type_name:   activity[:activity_type_name],
                      url:                  activity[:url],
                      description:          activity[:description],
                      length:               activity[:length],
                      rating:               activity[:rating]
                      )

        if new_activity.save 
          Rails.logger.info "#{Time.now}: NEW ACTIVITY - id: #{new_activity.id}"
        end
      end 
    end
end
