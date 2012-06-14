class Provision < ActiveRecord::Base
  attr_accessible :machine_id, :service_id, :start_port

  belongs_to :machine
  belongs_to :service

  def host_ports
    ports.where(:service_id => self.id).map do |port|
      (1..4).map do |i|
        "#{machine.ip_address}:#{port.port + i}"
      end
    end.flatten
  end

end
