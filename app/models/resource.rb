class Resource < ActiveRecord::Base
  attr_accessible :data, :service_id, :type

  belongs_to :service

  serialize :data
end
