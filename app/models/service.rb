class Service < ActiveRecord::Base
  attr_accessible :description, :name, :subdomain
end
