require 'fog'

class Machine < ActiveRecord::Base
  # attr_accessible :title, :body

  serialize :data
end
