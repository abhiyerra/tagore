class Machine < ActiveRecord::Base
  attr_accessible :title, :body, :tag, :ip_address

  serialize :data

  has_many :resources
  has_many :machine_ports
end
