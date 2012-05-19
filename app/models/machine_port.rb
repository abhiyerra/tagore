class MachinePort < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :machine
  belongs_to :service
end
