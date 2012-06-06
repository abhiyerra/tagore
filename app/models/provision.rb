class Provision < ActiveRecord::Base
  attr_accessible :machine_id, :service_id, :start_port
end
