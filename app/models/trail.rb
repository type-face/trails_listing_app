class Trail < ActiveRecord::Base

  validates :unique_id, uniqueness: true

  has_many :activities
end
