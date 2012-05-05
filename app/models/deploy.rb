class Deploy < ActiveRecord::Base
  attr_accessible :commit, :service_id

  belongs_to :service

end
