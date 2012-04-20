class Resource < ActiveRecord::Base
  attr_accessible :data, :service_id, :type
end
