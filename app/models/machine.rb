class Machine < ActiveRecord::Base
  attr_accessible :title, :body, :tag

  serialize :data

  has_many :resources

  has_many :services, :through => :machine_services
end
