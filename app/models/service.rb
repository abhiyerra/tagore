class Service < ActiveRecord::Base
  attr_accessible :description, :name, :subdomain

  validates_uniqueness_of :name

  has_many :resources
end
